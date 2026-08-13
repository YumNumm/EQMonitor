import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_transfer.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_accumulator.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_transfer.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_tile_decoder.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

// Isolate.spawn requires a top-level or static entrypoint.
// ignore: avoid_top_level_functions
void seismicityDecoderWorkerEntry(SendPort initialReplyTo) {
  SeismicityDecoderWorkerSession(replyTo: initialReplyTo).start();
}

final class SeismicityDecoderWorkerSession {
  SeismicityDecoderWorkerSession({required this.replyTo});

  final SendPort replyTo;
  final inbox = ReceivePort();
  final decoder = const SeismicityMvtTileDecoder();
  SeismicityPmTilesArchiveDescriptor? acceptedDescriptor;
  SeismicityDatasetAccumulator? accumulator;
  var decodedTileCount = 0;
  var finished = false;

  void start() {
    replyTo.send(inbox.sendPort);
    inbox.listen((message) {
      switch (message) {
        case SeismicityDecoderWorkerInitializeRequest(
          :final requestId,
          acceptedDescriptor: final descriptor,
          :final chunkCapacity,
        ):
          if (accumulator != null || finished) {
            replyTo.send(
              SeismicityDecoderWorkerResponse.failure(
                requestId: requestId,
                error: const SeismicityPmTilesException.decoderWorkerFailed(
                  reason: 'already_initialized',
                ),
              ),
            );
            break;
          }
          acceptedDescriptor = descriptor;
          accumulator = SeismicityDatasetAccumulator(
            expectedUniqueCount: descriptor.expectedFeatureCount,
            chunkCapacity: chunkCapacity,
          );
          replyTo.send(
            SeismicityDecoderWorkerResponse.ready(requestId: requestId),
          );
        case SeismicityDecoderWorkerDecodeRequest(
          :final requestId,
          :final tileBytes,
        ):
          if (finished) {
            replyTo.send(
              SeismicityDecoderWorkerResponse.failure(
                requestId: requestId,
                error: const SeismicityPmTilesException.decoderWorkerFailed(
                  reason: 'already_finished',
                ),
              ),
            );
            break;
          }
          final activeAccumulator = accumulator;
          final descriptor = acceptedDescriptor;
          if (activeAccumulator == null || descriptor == null) {
            replyTo.send(
              SeismicityDecoderWorkerResponse.failure(
                requestId: requestId,
                error: const SeismicityPmTilesException.decoderWorkerFailed(
                  reason: 'not_initialized',
                ),
              ),
            );
            break;
          }
          try {
            final bytes = Uint8List.fromList(
              tileBytes.materialize().asUint8List(),
            );
            // Task 38 uses dataZoom 0 / tileId 0; multi-tileId framing lands later.
            decoder.decode(
              tileId: 0,
              dataZoom: descriptor.dataZoom,
              tileBytes: bytes,
              onHypocenter: (record) {
                activeAccumulator.add(record: record);
              },
            );
            decodedTileCount += 1;
            replyTo.send(
              SeismicityDecoderWorkerResponse.progress(
                requestId: requestId,
                progress: SeismicityPmTilesDecodeProgress(
                  decodedTileCount: decodedTileCount,
                  rawFeatureCount: activeAccumulator.rawCount,
                  uniqueFeatureCount: activeAccumulator.uniqueCount,
                ),
              ),
            );
          } on SeismicityPmTilesException catch (error) {
            replyTo.send(
              SeismicityDecoderWorkerResponse.failure(
                requestId: requestId,
                error: error,
              ),
            );
          }
        case SeismicityDecoderWorkerFinishRequest(:final requestId):
          if (finished) {
            replyTo.send(
              SeismicityDecoderWorkerResponse.failure(
                requestId: requestId,
                error: const SeismicityPmTilesException.decoderWorkerFailed(
                  reason: 'already_finished',
                ),
              ),
            );
            break;
          }
          final activeAccumulator = accumulator;
          final descriptor = acceptedDescriptor;
          if (activeAccumulator == null || descriptor == null) {
            replyTo.send(
              SeismicityDecoderWorkerResponse.failure(
                requestId: requestId,
                error: const SeismicityPmTilesException.decoderWorkerFailed(
                  reason: 'not_initialized',
                ),
              ),
            );
            break;
          }
          try {
            final chunks = activeAccumulator.buildValidatedChunks();
            final transfer = SeismicityDatasetTransfer(
              archiveRevision: descriptor.archiveRevision,
              schemaVersion: descriptor.schemaVersion,
              dataZoom: descriptor.dataZoom,
              featureCount: descriptor.expectedFeatureCount,
              chunks: [
                for (final chunk in chunks)
                  SeismicityChunkTransfer.fromChunk(chunk: chunk),
              ],
            );
            finished = true;
            replyTo.send(
              SeismicityDecoderWorkerResponse.finished(
                requestId: requestId,
                datasetTransfer: transfer,
              ),
            );
          } on SeismicityPmTilesException catch (error) {
            replyTo.send(
              SeismicityDecoderWorkerResponse.failure(
                requestId: requestId,
                error: error,
              ),
            );
          }
      }
    });
  }
}
