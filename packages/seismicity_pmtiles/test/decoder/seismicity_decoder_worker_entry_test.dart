import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_isolate_launcher.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_entry.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:test/test.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

import '../support/seismicity_mvt_fixture_mutator.dart';

void main() {
  final fixtures = _Task38Fixtures();

  test(
    'worker entry initializes once and decodes two tiles on one isolate',
    () async {
      final launcher = DartSeismicityDecoderIsolateLauncher();
      final endpoint = await launcher.launch(
        workerMain: seismicityDecoderWorkerEntry,
      );
      addTearDown(() async {
        endpoint.closeReceivePort();
        endpoint.kill();
        await endpoint.exited;
      });

      final responses = <SeismicityDecoderWorkerResponse>[];
      final subscription = endpoint.responses.listen(responses.add);
      addTearDown(subscription.cancel);

      final descriptor = fixtures.acceptedDescriptor();
      final tileA = buildSeismicityMvtFixtureCatalog().valid;
      final tileB = fixtures.secondTileBytes();
      final replyPort = ReceivePort();
      addTearDown(replyPort.close);

      endpoint.send(
        request: SeismicityDecoderWorkerRequest.initialize(
          requestId: 1,
          responsePort: replyPort.sendPort,
          acceptedDescriptor: descriptor,
          chunkCapacity: 8,
        ),
      );
      endpoint.send(
        request: SeismicityDecoderWorkerRequest.decode(
          requestId: 2,
          tileBytes: TransferableTypedData.fromList([
            Uint8List.fromList(tileA),
          ]),
        ),
      );
      endpoint.send(
        request: SeismicityDecoderWorkerRequest.decode(
          requestId: 3,
          tileBytes: TransferableTypedData.fromList([
            Uint8List.fromList(tileB),
          ]),
        ),
      );

      await fixtures.waitUntil(() => responses.length >= 3);
      expect(responses.map((response) => response.requestId), [1, 2, 3]);
      expect(responses[0], isA<SeismicityDecoderWorkerReadyResponse>());
      expect(
        responses[1],
        isA<SeismicityDecoderWorkerProgressResponse>().having(
          (response) => response.progress,
          'progress',
          const SeismicityPmTilesDecodeProgress(
            decodedTileCount: 1,
            rawFeatureCount: 1,
            uniqueFeatureCount: 1,
          ),
        ),
      );
      expect(
        responses[2],
        isA<SeismicityDecoderWorkerProgressResponse>().having(
          (response) => response.progress,
          'progress',
          const SeismicityPmTilesDecodeProgress(
            decodedTileCount: 2,
            rawFeatureCount: 2,
            uniqueFeatureCount: 2,
          ),
        ),
      );
    },
  );

  test(
    'worker entry rejects decode before initialize and second initialize',
    () async {
      final launcher = DartSeismicityDecoderIsolateLauncher();
      final endpoint = await launcher.launch(
        workerMain: seismicityDecoderWorkerEntry,
      );
      addTearDown(() async {
        endpoint.closeReceivePort();
        endpoint.kill();
        await endpoint.exited;
      });

      final responses = <SeismicityDecoderWorkerResponse>[];
      final subscription = endpoint.responses.listen(responses.add);
      addTearDown(subscription.cancel);
      final replyPort = ReceivePort();
      addTearDown(replyPort.close);

      endpoint.send(
        request: SeismicityDecoderWorkerRequest.decode(
          requestId: 10,
          tileBytes: TransferableTypedData.fromList([
            Uint8List.fromList(buildSeismicityMvtFixtureCatalog().valid),
          ]),
        ),
      );
      await fixtures.waitUntil(() => responses.isNotEmpty);
      expect(
        responses.single,
        isA<SeismicityDecoderWorkerFailureResponse>()
            .having((response) => response.requestId, 'requestId', 10)
            .having(
              (response) => response.error,
              'error',
              isA<SeismicityPmTilesDecoderWorkerFailedException>(),
            ),
      );

      final descriptor = fixtures.acceptedDescriptor();
      endpoint.send(
        request: SeismicityDecoderWorkerRequest.initialize(
          requestId: 11,
          responsePort: replyPort.sendPort,
          acceptedDescriptor: descriptor,
          chunkCapacity: 8,
        ),
      );
      endpoint.send(
        request: SeismicityDecoderWorkerRequest.initialize(
          requestId: 12,
          responsePort: replyPort.sendPort,
          acceptedDescriptor: descriptor,
          chunkCapacity: 8,
        ),
      );
      await fixtures.waitUntil(() => responses.length >= 3);
      expect(responses[1], isA<SeismicityDecoderWorkerReadyResponse>());
      expect(
        responses[2],
        isA<SeismicityDecoderWorkerFailureResponse>()
            .having((response) => response.requestId, 'requestId', 12)
            .having(
              (response) => response.error,
              'error',
              isA<SeismicityPmTilesDecoderWorkerFailedException>(),
            ),
      );
    },
  );
}

final class _Task38Fixtures {
  SeismicityPmTilesArchiveDescriptor acceptedDescriptor() =>
      SeismicityPmTilesArchiveDescriptor(
        source: SeismicityPmTilesSource.network(
          archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
        ),
        schemaVersion: 1,
        dataZoom: 0,
        expectedSizeBytes: 128,
        expectedFeatureCount: 2,
        archiveRevision: 'rev-task-38',
        periodFrom: DateTime.utc(2024),
        periodTo: DateTime.utc(2025),
      );

  List<int> secondTileBytes() {
    final tile = VectorTile.fromBuffer(
      buildSeismicityMvtFixtureCatalog().valid,
    );
    tile.layers.single.values[0] = createVectorTileValue(
      stringValue: '00000000-0000-4000-8000-000000000002',
    );
    tile.layers.single.values[3] = createVectorTileValue(
      stringValue: 'event-2',
    );
    return tile.writeToBuffer();
  }

  Future<void> waitUntil(bool Function() predicate) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (!predicate()) {
      if (DateTime.now().isAfter(deadline)) {
        fail('timed out waiting for worker responses');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}
