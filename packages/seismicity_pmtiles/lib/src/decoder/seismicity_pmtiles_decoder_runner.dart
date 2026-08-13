import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/archive/seismicity_pmtiles_archive.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_run_lifecycle.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_factory.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decode_operation.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_schema_v1_validator.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_load_state.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_result.dart';

/// Non-export runner: archive traversal into an injected worker factory.
final class SeismicityPmTilesDecoderRunner {
  SeismicityPmTilesDecoderRunner({
    required SeismicityDecoderWorkerFactory factory,
    this.schemaValidator = const SeismicitySchemaV1Validator(),
  }) : _factory = factory;

  final SeismicityDecoderWorkerFactory _factory;
  final SeismicitySchemaV1Validator schemaValidator;

  SeismicityPmTilesDecodeOperation start({
    required SeismicityPmTilesArchive archive,
    required int chunkCapacity,
  }) {
    final lifecycle = SeismicityDecoderRunLifecycle();
    late final SeismicityPmTilesDecodeOperationController controller;
    controller = SeismicityPmTilesDecodeOperationController(
      onCancel: () async {
        applyDecision(
          controller: controller,
          decision: lifecycle.handle(
            signal: const SeismicityDecoderRunCancelSignal(),
          ),
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
  }) async {
    try {
      controller.emit(state: const SeismicityPmTilesLoadState.openingSource());
      schemaValidator.validateDescriptor(descriptor: archive.descriptor);
      validateChunkCapacity(chunkCapacity: chunkCapacity);
      final handle = await _factory.spawn(
        acceptedDescriptor: archive.descriptor,
        chunkCapacity: chunkCapacity,
      );
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
    } on SeismicityPmTilesException catch (error) {
      lifecycle.handle(
        signal: SeismicityDecoderRunSourceFailureSignal(exception: error),
      );
      applyDecision(
        controller: controller,
        decision: lifecycle.handle(
          signal: const SeismicityDecoderRunCleanupSucceededSignal(),
        ),
      );
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

  void applyDecision({
    required SeismicityPmTilesDecodeOperationController controller,
    required SeismicityDecoderRunDecision decision,
  }) {
    if (!decision.publishResult) {
      return;
    }
    final result = decision.result;
    if (result == null) {
      return;
    }
    switch (result) {
      case SeismicityPmTilesSuccess<SeismicityPmTilesDataset>(:final value):
        controller.completeSuccess(dataset: value);
      case SeismicityPmTilesFailure<SeismicityPmTilesDataset>(:final exception):
        controller.completeFailure(exception: exception);
    }
  }
}
