import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_accumulator.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_isolate_launcher.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_entry.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_point_decoder.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_validity_bitmap.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

import '../support/seismicity_mvt_fixture_mutator.dart';

void main() {
  final fixtures = _Task41Fixtures();

  test(
    'worker finish emits transfer for zero and nonzero accumulations',
    () async {
      final zero = await fixtures.runFinish(
        expectedFeatureCount: 0,
        tiles: const [],
      );
      expect(zero, isA<SeismicityDecoderWorkerFinishedResponse>());
      final zeroTransfer =
          (zero as SeismicityDecoderWorkerFinishedResponse).datasetTransfer;
      expect(zeroTransfer.archiveRevision, 'rev-task-41');
      expect(zeroTransfer.schemaVersion, 1);
      expect(zeroTransfer.dataZoom, 0);
      expect(zeroTransfer.featureCount, 0);
      expect(zeroTransfer.chunks, isEmpty);

      final nonzero = await fixtures.runFinish(
        expectedFeatureCount: 2,
        tiles: [
          buildSeismicityMvtFixtureCatalog().valid,
          fixtures.secondTileBytes(),
        ],
      );
      expect(nonzero, isA<SeismicityDecoderWorkerFinishedResponse>());
      final transfer =
          (nonzero as SeismicityDecoderWorkerFinishedResponse).datasetTransfer;
      expect(transfer.archiveRevision, 'rev-task-41');
      expect(transfer.schemaVersion, 1);
      expect(transfer.dataZoom, 0);
      expect(transfer.featureCount, 2);
      expect(transfer.chunks, hasLength(1));
      final materialized = transfer.chunks.single.materialize();
      final point = const SeismicityMvtPointDecoder().decode(
        geometry: const [9, 2, 2],
        z: 0,
        x: 0,
        y: 0,
        extent: 4096,
        tileId: 0,
        featureIndex: 0,
      );
      expect(
        materialized.hypocenterIds,
        Uint8List.fromList([
          ...Uuid.parse('00000000-0000-4000-8000-000000000001'),
          ...Uuid.parse('00000000-0000-4000-8000-000000000002'),
        ]),
      );
      expect(materialized.latitudes, [point.latitude, point.latitude]);
      expect(materialized.longitudes, [point.longitude, point.longitude]);
      expect(materialized.originTimeUnixMilliseconds, [
        1700000000000,
        1700000000000,
      ]);
      expect(materialized.magnitudes[0], closeTo(5.1, 1e-5));
      expect(materialized.magnitudes[1], closeTo(5.1, 1e-5));
      expect(
        SeismicityValidityBitmap.isValid(
          bytes: materialized.magnitudeValidity,
          index: 0,
        ),
        isTrue,
      );
      expect(
        SeismicityValidityBitmap.isValid(
          bytes: materialized.depthValidity,
          index: 0,
        ),
        isFalse,
      );
      expect(materialized.depthsKm[0].isNaN, isTrue);
      expect(materialized.maxIntensityDictionaryUtf8, isEmpty);
      expect(materialized.maxIntensityDictionaryOffsets, [0]);
      expect(materialized.maxIntensityDictionaryIndexes, [0, 0]);
      expect(
        SeismicityValidityBitmap.isValid(
          bytes: materialized.maxIntensityValidity,
          index: 0,
        ),
        isFalse,
      );
      expect(
        SeismicityValidityBitmap.isValid(
          bytes: materialized.maxIntensityValidity,
          index: 1,
        ),
        isFalse,
      );
      expect(
        const SeismicityChunkLengthSummer().sumChecked(
          chunks: [materialized],
        ),
        2,
      );
    },
  );

  test(
    'worker finish rejects count mismatch finish-twice decode-after '
    'and unchecked sum',
    () async {
      final mismatch = await fixtures.runFinish(
        expectedFeatureCount: 2,
        tiles: [buildSeismicityMvtFixtureCatalog().valid],
      );
      expect(
        mismatch,
        isA<SeismicityDecoderWorkerFailureResponse>().having(
          (response) => response.error,
          'error',
          isA<SeismicityPmTilesFeatureCountMismatchException>(),
        ),
      );

      final endpoint = await fixtures.launch();
      final responses = <SeismicityDecoderWorkerResponse>[];
      final subscription = endpoint.responses.listen(responses.add);
      addTearDown(subscription.cancel);
      final replyPort = ReceivePort();
      addTearDown(replyPort.close);
      final descriptor = fixtures.acceptedDescriptor(expectedFeatureCount: 0);
      endpoint.send(
        request: SeismicityDecoderWorkerRequest.initialize(
          requestId: 1,
          responsePort: replyPort.sendPort,
          acceptedDescriptor: descriptor,
          chunkCapacity: 8,
        ),
      );
      endpoint.send(
        request: const SeismicityDecoderWorkerRequest.finish(requestId: 2),
      );
      endpoint.send(
        request: const SeismicityDecoderWorkerRequest.finish(requestId: 3),
      );
      endpoint.send(
        request: SeismicityDecoderWorkerRequest.decode(
        requestId: 4,
        tileId: 0,
        tileBytes: TransferableTypedData.fromList([
            Uint8List.fromList(buildSeismicityMvtFixtureCatalog().valid),
          ]),
        ),
      );
      await fixtures.waitUntil(() => responses.length >= 4);
      expect(responses[0], isA<SeismicityDecoderWorkerReadyResponse>());
      expect(responses[1], isA<SeismicityDecoderWorkerFinishedResponse>());
      expect(
        responses[2],
        isA<SeismicityDecoderWorkerFailureResponse>().having(
          (response) => response.error,
          'error',
          isA<SeismicityPmTilesDecoderWorkerFailedException>().having(
            (error) => error.reason,
            'reason',
            'already_finished',
          ),
        ),
      );
      expect(
        responses[3],
        isA<SeismicityDecoderWorkerFailureResponse>().having(
          (response) => response.error,
          'error',
          isA<SeismicityPmTilesDecoderWorkerFailedException>().having(
            (error) => error.reason,
            'reason',
            'already_finished',
          ),
        ),
      );

      expect(
        () => const SeismicityDatasetChunkSumGate().ensureMatches(
          chunks: [fixtures.lengthOnlyChunk(length: 1)],
          expectedFeatureCount: 2,
        ),
        throwsA(
          isA<SeismicityPmTilesFeatureCountMismatchException>()
              .having((error) => error.expected, 'expected', 2)
              .having((error) => error.actual, 'actual', 1),
        ),
      );
      expect(
        () => SeismicityDatasetAccumulator(
          expectedUniqueCount: 1,
          chunkCapacity: 1,
        ).buildValidatedChunks(),
        throwsA(isA<SeismicityPmTilesFeatureCountMismatchException>()),
      );
    },
  );
}

final class _Task41Fixtures {
  SeismicityPmTilesArchiveDescriptor acceptedDescriptor({
    required int expectedFeatureCount,
  }) => SeismicityPmTilesArchiveDescriptor(
    source: SeismicityPmTilesSource.network(
      archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
    ),
    schemaVersion: 1,
    dataZoom: 0,
    expectedSizeBytes: 128,
    expectedFeatureCount: expectedFeatureCount,
    archiveRevision: 'rev-task-41',
    periodFrom: DateTime.utc(2024),
    periodTo: DateTime.utc(2025),
  );

  SeismicityPmTilesChunk lengthOnlyChunk({required int length}) =>
      SeismicityPmTilesChunk(
        hypocenterIds: Uint8List(length * 16),
        latitudes: Float64List(length),
        longitudes: Float64List(length),
        depthsKm: Float32List(length),
        depthValidity: Uint8List((length + 7) ~/ 8),
        magnitudes: Float32List(length),
        magnitudeValidity: Uint8List((length + 7) ~/ 8),
        originTimeUnixMilliseconds: Int64List(length),
        maxIntensityDictionaryIndexes: Uint32List(length),
        maxIntensityValidity: Uint8List((length + 7) ~/ 8),
        maxIntensityDictionaryUtf8: Uint8List(0),
        maxIntensityDictionaryOffsets: Uint32List.fromList([0]),
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

  Future<SeismicityDecoderWorkerEndpoint> launch() async {
    final endpoint = await DartSeismicityDecoderIsolateLauncher().launch(
      workerMain: seismicityDecoderWorkerEntry,
    );
    addTearDown(() async {
      endpoint.closeReceivePort();
      endpoint.kill();
      await endpoint.exited;
    });
    return endpoint;
  }

  Future<SeismicityDecoderWorkerResponse> runFinish({
    required int expectedFeatureCount,
    required List<List<int>> tiles,
  }) async {
    final endpoint = await launch();
    final responses = <SeismicityDecoderWorkerResponse>[];
    final subscription = endpoint.responses.listen(responses.add);
    addTearDown(subscription.cancel);
    final replyPort = ReceivePort();
    addTearDown(replyPort.close);
    final accepted = acceptedDescriptor(
      expectedFeatureCount: expectedFeatureCount,
    );
    endpoint.send(
      request: SeismicityDecoderWorkerRequest.initialize(
        requestId: 1,
        responsePort: replyPort.sendPort,
        acceptedDescriptor: accepted,
        chunkCapacity: 8,
      ),
    );
    var requestId = 2;
    for (final tile in tiles) {
      endpoint.send(
        request: SeismicityDecoderWorkerRequest.decode(
        requestId: requestId,
        tileId: 0,
        tileBytes: TransferableTypedData.fromList([
            Uint8List.fromList(tile),
          ]),
        ),
      );
      requestId += 1;
    }
    endpoint.send(
      request: SeismicityDecoderWorkerRequest.finish(requestId: requestId),
    );
    final expectedCount = 1 + tiles.length + 1;
    await waitUntil(() => responses.length >= expectedCount);
    return responses.last;
  }

  Future<void> waitUntil(bool Function() predicate) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (!predicate()) {
      if (DateTime.now().isAfter(deadline)) {
        throw StateError('Timed out waiting for worker responses.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}
