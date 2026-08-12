import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_transfer.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:test/test.dart';

void main() {
  test('worker protocol messages round-trip through an isolate', () async {
    final replies = ReceivePort();
    final iterator = StreamIterator(replies);
    final isolate = await Isolate.spawn(
      WorkerProtocolRoundTripIsolate.run,
      replies.sendPort,
    );
    addTearDown(() {
      replies.close();
      isolate.kill(priority: Isolate.immediate);
    });

    await iterator.moveNext();
    final workerPort = iterator.current as SendPort;
    final descriptor = SeismicityPmTilesArchiveDescriptor(
      source: const SeismicityPmTilesSource.file(path: 'archive.pmtiles'),
      schemaVersion: 1,
      dataZoom: 14,
      expectedSizeBytes: 2048,
      expectedFeatureCount: 31,
      archiveRevision: 'revision-34',
      periodFrom: DateTime.utc(2020),
      periodTo: DateTime.utc(2021),
    );
    final requests = [
      SeismicityDecoderWorkerRequest.initialize(
        requestId: 1,
        responsePort: replies.sendPort,
        acceptedDescriptor: descriptor,
        chunkCapacity: 128,
      ),
      SeismicityDecoderWorkerRequest.decode(
        requestId: 2,
        tileBytes: TransferableTypedData.fromList([
          Uint8List.fromList([3, 4, 5]),
        ]),
      ),
      const SeismicityDecoderWorkerRequest.finish(requestId: 3),
    ];

    expect(
      [
        for (final request in requests)
          switch (request) {
            SeismicityDecoderWorkerInitializeRequest() => 'initialize',
            SeismicityDecoderWorkerDecodeRequest() => 'decode',
            SeismicityDecoderWorkerFinishRequest() => 'finish',
          },
      ],
      ['initialize', 'decode', 'finish'],
    );

    for (final request in requests) {
      workerPort.send(request);
      await iterator.moveNext();
      final roundTripped = iterator.current as SeismicityDecoderWorkerRequest;
      expect(roundTripped.requestId, request.requestId);
      switch (roundTripped) {
        case SeismicityDecoderWorkerInitializeRequest(
          :final responsePort,
          :final acceptedDescriptor,
          :final chunkCapacity,
        ):
          expect(responsePort, replies.sendPort);
          expect(
            acceptedDescriptor.source,
            const SeismicityPmTilesSource.file(path: 'archive.pmtiles'),
          );
          expect(acceptedDescriptor.schemaVersion, 1);
          expect(acceptedDescriptor.dataZoom, 14);
          expect(acceptedDescriptor.expectedSizeBytes, 2048);
          expect(acceptedDescriptor.archiveRevision, 'revision-34');
          expect(acceptedDescriptor.expectedFeatureCount, 31);
          expect(acceptedDescriptor.periodFrom, DateTime.utc(2020));
          expect(acceptedDescriptor.periodTo, DateTime.utc(2021));
          expect(chunkCapacity, 128);
        case SeismicityDecoderWorkerDecodeRequest(:final tileBytes):
          expect(tileBytes.materialize().asUint8List(), [3, 4, 5]);
        case SeismicityDecoderWorkerFinishRequest():
          expect(roundTripped.requestId, 3);
      }
    }

    final responses = [
      const SeismicityDecoderWorkerResponse.ready(requestId: 1),
      const SeismicityDecoderWorkerResponse.progress(
        requestId: 2,
        progress: SeismicityPmTilesDecodeProgress(
          decodedTileCount: 1,
          rawFeatureCount: 2,
          uniqueFeatureCount: 2,
        ),
      ),
      SeismicityDecoderWorkerResponse.finished(
        requestId: 3,
        datasetTransfer: SeismicityDatasetTransfer(
          archiveRevision: 'revision-34',
          schemaVersion: 1,
          dataZoom: 14,
          featureCount: 2,
          chunks: const [],
        ),
      ),
      const SeismicityDecoderWorkerResponse.failure(
        requestId: 4,
        error: SeismicityPmTilesException.invalidVectorTile(
          tileId: 9,
          reason: 'bad command',
        ),
      ),
    ];

    expect(
      [
        for (final response in responses)
          switch (response) {
            SeismicityDecoderWorkerReadyResponse() => 'ready',
            SeismicityDecoderWorkerProgressResponse() => 'progress',
            SeismicityDecoderWorkerFinishedResponse() => 'finished',
            SeismicityDecoderWorkerFailureResponse() => 'failure',
          },
      ],
      ['ready', 'progress', 'finished', 'failure'],
    );

    for (final response in responses) {
      workerPort.send(response);
      await iterator.moveNext();
      final roundTripped = iterator.current as SeismicityDecoderWorkerResponse;
      expect(roundTripped.requestId, response.requestId);
      switch (roundTripped) {
        case SeismicityDecoderWorkerReadyResponse():
          expect(roundTripped.requestId, 1);
        case SeismicityDecoderWorkerProgressResponse(:final progress):
          expect(progress.decodedTileCount, 1);
          expect(progress.rawFeatureCount, 2);
          expect(progress.uniqueFeatureCount, 2);
        case SeismicityDecoderWorkerFinishedResponse(:final datasetTransfer):
          expect(datasetTransfer.archiveRevision, 'revision-34');
          expect(datasetTransfer.schemaVersion, 1);
          expect(datasetTransfer.dataZoom, 14);
          expect(datasetTransfer.featureCount, 2);
          expect(datasetTransfer.chunks, isEmpty);
        case SeismicityDecoderWorkerFailureResponse(:final error):
          expect(
            error,
            isA<SeismicityPmTilesInvalidVectorTileException>()
                .having((exception) => exception.tileId, 'tileId', 9)
                .having(
                  (exception) => exception.reason,
                  'reason',
                  'bad command',
                ),
          );
      }
    }
  });
}

// Isolate.spawn needs a static entrypoint, while project rules avoid
// top-level helpers.
// ignore: avoid_classes_with_only_static_members
final class WorkerProtocolRoundTripIsolate {
  static Future<void> run(SendPort sendPort) async {
    final inbox = ReceivePort();
    sendPort.send(inbox.sendPort);
    await inbox.forEach(sendPort.send);
  }
}
