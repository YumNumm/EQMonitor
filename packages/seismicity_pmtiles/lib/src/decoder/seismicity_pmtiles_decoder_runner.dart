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

final class _RunnerCleanupMemo {
  Future<void>? future;
  SeismicityDecoderWorkerHandle? handle;
}

/// Non-export runner: archive traversal into an injected worker factory.
final class SeismicityPmTilesDecoderRunner {
  SeismicityPmTilesDecoderRunner({
    required SeismicityDecoderWorkerFactory this.factory,
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
    final cleanup = _RunnerCleanupMemo();
    late final SeismicityPmTilesDecodeOperationController controller;
    controller = SeismicityPmTilesDecodeOperationController(
      onCancel: () async {
        final decision = lifecycle.handle(
          signal: const SeismicityDecoderRunCancelSignal(),
        );
        await ensureCleanup(
          memo: cleanup,
          archive: archive,
          decision: decision,
        );
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
    required _RunnerCleanupMemo cleanup,
  }) async {
    try {
      controller.emit(state: const SeismicityPmTilesLoadState.openingSource());
      schemaValidator.validateDescriptor(descriptor: archive.descriptor);
      validateChunkCapacity(chunkCapacity: chunkCapacity);
      final handle = await factory.spawn(
        acceptedDescriptor: archive.descriptor,
        chunkCapacity: chunkCapacity,
      );
      cleanup.handle = handle;
      controller.emit(
        state: const SeismicityPmTilesLoadState.readingDirectory(),
      );
      await for (final tileId in archive.occupiedTileIdsAtZoom(
        zoom: archive.descriptor.dataZoom,
      )) {
        final tileBytes = await archive.readTile(tileId: tileId);
        final progress = await handle.decode(
          tileBytes: TransferableTypedData.fromList([
            exactTileBytes(bytes: tileBytes),
          ]),
        );
        controller.emitProgress(progress: progress);
      }
      final dataset = await handle.finish();
      publicationValidator.validate(
        dataset: dataset,
        acceptedDescriptor: archive.descriptor,
      );
      final decision = lifecycle.handle(
        signal: SeismicityDecoderRunSuccessSignal(dataset: dataset),
      );
      await ensureCleanup(
        memo: cleanup,
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
      controller.completeFailure(exception: error);
    }
  }

  Future<void> ensureCleanup({
    required _RunnerCleanupMemo memo,
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
        controller.completeFailure(exception: exception);
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
