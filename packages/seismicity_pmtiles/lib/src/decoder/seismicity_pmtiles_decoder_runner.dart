import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/archive/seismicity_pmtiles_archive.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_publication_validator.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_run_lifecycle.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_factory.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decode_operation.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_schema_v1_validator.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_load_state.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_result.dart';

final class SeismicityDecoderRunnerCleanupMemo {
  Future<void>? future;
  SeismicityDecoderWorkerHandle? handle;
}

/// Non-export runner: archive traversal into an injected worker factory.
final class SeismicityPmTilesDecoderRunner {
  SeismicityPmTilesDecoderRunner({
    required this.factory,
    this.schemaValidator = const SeismicitySchemaV1Validator(),
    this.publicationValidator = const SeismicityDatasetPublicationValidator(),
  });

  final SeismicityDecoderWorkerFactory factory;
  final SeismicitySchemaV1Validator schemaValidator;
  final SeismicityDatasetPublicationValidator publicationValidator;

  SeismicityPmTilesDecodeOperation start({
    required SeismicityPmTilesArchive archive,
    required int chunkCapacity,
  }) {
    final lifecycle = SeismicityDecoderRunLifecycle();
    final cleanup = SeismicityDecoderRunnerCleanupMemo();
    late final SeismicityPmTilesDecodeOperationController controller;
    controller = SeismicityPmTilesDecodeOperationController(
      onCancel: () async {
        final decision = lifecycle.handle(
          signal: const SeismicityDecoderRunCancelSignal(),
        );
        try {
          await settleCleanup(
            memo: cleanup,
            archive: archive,
            lifecycle: lifecycle,
            controller: controller,
            decision: decision,
          );
        } on SeismicityPmTilesException {
          // Memoized or cancel-path cleanup failures must not escape cancel().
        }
      },
    );
    scheduleMicrotask(() {
      unawaited(
        runTraversal(
          archive: archive,
          chunkCapacity: chunkCapacity,
          controller: controller,
          lifecycle: lifecycle,
          cleanup: cleanup,
        ),
      );
    });
    return controller.operation;
  }

  Future<void> runTraversal({
    required SeismicityPmTilesArchive archive,
    required int chunkCapacity,
    required SeismicityPmTilesDecodeOperationController controller,
    required SeismicityDecoderRunLifecycle lifecycle,
    required SeismicityDecoderRunnerCleanupMemo cleanup,
  }) async {
    var classifyAsWorker = false;
    try {
      controller.emit(state: const SeismicityPmTilesLoadState.openingSource());
      schemaValidator.validateDescriptor(descriptor: archive.descriptor);
      validateChunkCapacity(chunkCapacity: chunkCapacity);
      final handle = await factory.spawn(
        acceptedDescriptor: archive.descriptor,
        chunkCapacity: chunkCapacity,
      );
      cleanup.handle = handle;
      if (cleanup.future != null) {
        // Cancel already settled without this handle — retire it once.
        await handle.cancel();
        await handle.close();
        await handle.retired;
        return;
      }
      controller.emit(
        state: const SeismicityPmTilesLoadState.readingDirectory(),
      );
      await for (final tileId in archive.occupiedTileIdsAtZoom(
        zoom: archive.descriptor.dataZoom,
      )) {
        final tileBytes = await archive.readTile(tileId: tileId);
        classifyAsWorker = true;
        final progress = await handle.decode(
          tileId: tileId,
          tileBytes: TransferableTypedData.fromList([
            exactTileBytes(bytes: tileBytes),
          ]),
        );
        classifyAsWorker = false;
        controller.emitProgress(progress: progress);
      }
      classifyAsWorker = true;
      final dataset = await handle.finish();
      classifyAsWorker = false;
      publicationValidator.validate(
        dataset: dataset,
        acceptedDescriptor: archive.descriptor,
      );
      final decision = lifecycle.handle(
        signal: SeismicityDecoderRunSuccessSignal(dataset: dataset),
      );
      await settleCleanup(
        memo: cleanup,
        archive: archive,
        lifecycle: lifecycle,
        controller: controller,
        decision: decision,
      );
    } on SeismicityPmTilesException catch (error) {
      final decision = lifecycle.handle(
        signal: classifyAsWorker
            ? SeismicityDecoderRunWorkerFailureSignal(exception: error)
            : SeismicityDecoderRunSourceFailureSignal(exception: error),
      );
      await settleCleanup(
        memo: cleanup,
        archive: archive,
        lifecycle: lifecycle,
        controller: controller,
        decision: decision,
      );
    }
  }

  Future<void> settleCleanup({
    required SeismicityDecoderRunnerCleanupMemo memo,
    required SeismicityPmTilesArchive archive,
    required SeismicityDecoderRunLifecycle lifecycle,
    required SeismicityPmTilesDecodeOperationController controller,
    required SeismicityDecoderRunDecision decision,
  }) async {
    try {
      await ensureCleanup(
        memo: memo,
        archive: archive,
        decision: decision,
      );
      publishDecision(
        controller: controller,
        decision: lifecycle.handle(
          signal: const SeismicityDecoderRunCleanupSucceededSignal(),
        ),
      );
    } on SeismicityPmTilesException catch (error) {
      publishDecision(
        controller: controller,
        decision: lifecycle.handle(
          signal: SeismicityDecoderRunCleanupFailedSignal(exception: error),
        ),
      );
    }
  }

  Future<void> ensureCleanup({
    required SeismicityDecoderRunnerCleanupMemo memo,
    required SeismicityPmTilesArchive archive,
    required SeismicityDecoderRunDecision decision,
  }) {
    final existing = memo.future;
    if (existing != null) {
      return existing;
    }
    final handle = memo.handle;
    final future = () async {
      if (decision.closeArchive) {
        await archive.close();
      }
      if (decision.cancelWorker && handle != null) {
        await handle.cancel();
      }
      if (decision.closeWorker && handle != null) {
        await handle.close();
      }
      if (decision.waitRetired && handle != null) {
        await handle.retired;
      }
    }();
    memo.future = future;
    return future;
  }

  void publishDecision({
    required SeismicityPmTilesDecodeOperationController controller,
    required SeismicityDecoderRunDecision decision,
  }) {
    if (!decision.publishResult) {
      return;
    }
    switch (decision.result) {
      case SeismicityPmTilesSuccess<SeismicityPmTilesDataset>(:final value):
        controller.completeSuccess(dataset: value);
      case SeismicityPmTilesFailure<SeismicityPmTilesDataset>(:final exception):
        switch (exception) {
          case SeismicityPmTilesDecoderWorkerFailedException(
            reason: 'cancelled',
          ):
            controller.completeCancelled(exception: exception);
          case _:
            controller.completeFailure(exception: exception);
        }
      case null:
        break;
    }
  }

  void validateChunkCapacity({required int chunkCapacity}) {
    if (chunkCapacity <= 0 || chunkCapacity > 0x3fffffff) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Invalid dataset chunk capacity.',
      );
    }
  }

  Uint8List exactTileBytes({required Uint8List bytes}) {
    if (bytes.offsetInBytes == 0 &&
        bytes.lengthInBytes == bytes.buffer.lengthInBytes) {
      return bytes;
    }
    return Uint8List.fromList(bytes);
  }
}
