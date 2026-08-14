import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_transfer.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_transfer.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:test/test.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

import '../support/controlled_seismicity_isolate_launcher.dart';
import '../support/seismicity_mvt_fixture_mutator.dart';

void main() {
  final fixtures = _Task43Fixtures();

  test(
    'controlled handle routes ready two progress acks and '
    'finish materialization',
    () async {
      final controlled = ControlledSeismicityIsolateLauncher();
      final factory = IsolateSeismicityDecoderWorkerFactory(
        launcher: controlled,
        probe: controlled,
      );
      final descriptor = fixtures.descriptor(expectedFeatureCount: 2);

      final spawnFuture = factory.spawn(
        acceptedDescriptor: descriptor,
        chunkCapacity: 8,
      );
      await fixtures.waitUntil(
        () => controlled.sent.any(
          (request) => request is SeismicityDecoderWorkerInitializeRequest,
        ),
      );
      controlled.emitReady(requestId: 0);
      final handle = await spawnFuture;
      expect(controlled.launchCount, 1);

      final firstDecode = handle.decode(
        tileId: 0,
        tileBytes: TransferableTypedData.fromList([Uint8List(1)]),
      );
      await fixtures.waitUntil(
        () =>
            controlled.sent
                .whereType<SeismicityDecoderWorkerDecodeRequest>()
                .length ==
            1,
      );
      controlled.emitResponse(
        response: const SeismicityDecoderWorkerResponse.progress(
          requestId: 1,
          progress: SeismicityPmTilesDecodeProgress(
            decodedTileCount: 1,
            rawFeatureCount: 1,
            uniqueFeatureCount: 1,
          ),
        ),
      );
      expect(
        await firstDecode,
        const SeismicityPmTilesDecodeProgress(
          decodedTileCount: 1,
          rawFeatureCount: 1,
          uniqueFeatureCount: 1,
        ),
      );

      final secondDecode = handle.decode(
        tileId: 0,
        tileBytes: TransferableTypedData.fromList([Uint8List(2)]),
      );
      await fixtures.waitUntil(
        () =>
            controlled.sent
                .whereType<SeismicityDecoderWorkerDecodeRequest>()
                .length ==
            2,
      );
      controlled.emitResponse(
        response: const SeismicityDecoderWorkerResponse.progress(
          requestId: 2,
          progress: SeismicityPmTilesDecodeProgress(
            decodedTileCount: 2,
            rawFeatureCount: 2,
            uniqueFeatureCount: 2,
          ),
        ),
      );
      expect(
        await secondDecode,
        const SeismicityPmTilesDecodeProgress(
          decodedTileCount: 2,
          rawFeatureCount: 2,
          uniqueFeatureCount: 2,
        ),
      );

      final finishFuture = handle.finish();
      await fixtures.waitUntil(
        () => controlled.sent.any(
          (request) => request is SeismicityDecoderWorkerFinishRequest,
        ),
      );
      final finishRequest = controlled.sent
          .whereType<SeismicityDecoderWorkerFinishRequest>()
          .single;
      controlled.emitResponse(
        response: SeismicityDecoderWorkerResponse.finished(
          requestId: finishRequest.requestId,
          datasetTransfer: fixtures.transfer(descriptor: descriptor),
        ),
      );
      final dataset = await finishFuture;
      expect(dataset.featureCount, 2);
      expect(dataset.archiveRevision, descriptor.archiveRevision);
      expect(dataset.chunks, hasLength(2));
      expect(controlled.launchCount, 1);
    },
  );

  test(
    'real launcher smoke path uses one isolate for decode and finish',
    () async {
      final factory = IsolateSeismicityDecoderWorkerFactory();
      final descriptor = fixtures.descriptor(expectedFeatureCount: 2);
      final handle = await factory.spawn(
        acceptedDescriptor: descriptor,
        chunkCapacity: 8,
      );
      addTearDown(() async {
        await handle.close();
        await handle.retired;
      });

      final tileA = buildSeismicityMvtFixtureCatalog().valid;
      final tileB = fixtures.secondTileBytes();
      expect(
        await handle.decode(
          tileId: 0,
          tileBytes: TransferableTypedData.fromList([
            Uint8List.fromList(tileA),
          ]),
        ),
        const SeismicityPmTilesDecodeProgress(
          decodedTileCount: 1,
          rawFeatureCount: 1,
          uniqueFeatureCount: 1,
        ),
      );
      expect(
        await handle.decode(
          tileId: 0,
          tileBytes: TransferableTypedData.fromList([
            Uint8List.fromList(tileB),
          ]),
        ),
        const SeismicityPmTilesDecodeProgress(
          decodedTileCount: 2,
          rawFeatureCount: 2,
          uniqueFeatureCount: 2,
        ),
      );
      final dataset = await handle.finish();
      expect(dataset.featureCount, 2);
      expect(dataset.chunks, hasLength(1));
      expect(dataset.chunks.single.latitudes, hasLength(2));
    },
  );

  test('cancel settles pending decode without worker cancel request', () async {
    final controlled = ControlledSeismicityIsolateLauncher();
    final factory = IsolateSeismicityDecoderWorkerFactory(
      launcher: controlled,
      probe: controlled,
    );
    final descriptor = fixtures.descriptor(expectedFeatureCount: 1);
    final spawnFuture = factory.spawn(
      acceptedDescriptor: descriptor,
      chunkCapacity: 8,
    );
    await fixtures.waitUntil(
      () => controlled.sent.any(
        (request) => request is SeismicityDecoderWorkerInitializeRequest,
      ),
    );
    controlled.emitReady(requestId: 0);
    final handle = await spawnFuture;

    final pendingDecode = handle.decode(
      tileId: 0,
      tileBytes: TransferableTypedData.fromList([Uint8List(1)]),
    );
    await fixtures.waitUntil(
      () =>
          controlled.sent
              .whereType<SeismicityDecoderWorkerDecodeRequest>()
              .length ==
          1,
    );
    final pendingExpectation = expectLater(
      pendingDecode,
      throwsA(
        isA<SeismicityPmTilesException>().having(
          (error) => error.toString(),
          'toString',
          contains('cancelled'),
        ),
      ),
    );
    await handle.cancel();
    await pendingExpectation;
    await handle.retired;
    expect(
      controlled.sent.whereType<SeismicityDecoderWorkerFinishRequest>(),
      isEmpty,
    );
    expect(controlled.killCount, greaterThan(0));
  });
}

final class _Task43Fixtures {
  SeismicityPmTilesArchiveDescriptor descriptor({
    required int expectedFeatureCount,
  }) => SeismicityPmTilesArchiveDescriptor(
    source: SeismicityPmTilesSource.network(
      archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
    ),
    schemaVersion: 1,
    dataZoom: 0,
    expectedSizeBytes: 128,
    expectedFeatureCount: expectedFeatureCount,
    archiveRevision: 'rev-task-43',
    periodFrom: DateTime.utc(2024),
    periodTo: DateTime.utc(2025),
  );

  SeismicityDatasetTransfer transfer({
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) => SeismicityDatasetTransfer(
    archiveRevision: descriptor.archiveRevision,
    schemaVersion: descriptor.schemaVersion,
    dataZoom: descriptor.dataZoom,
    featureCount: descriptor.expectedFeatureCount,
    chunks: [
      SeismicityChunkTransfer.fromChunk(chunk: chunk(id: 1)),
      SeismicityChunkTransfer.fromChunk(chunk: chunk(id: 2)),
    ],
  );

  SeismicityPmTilesChunk chunk({required int id}) => SeismicityPmTilesChunk(
    hypocenterIds: Uint8List.fromList(List.filled(16, id)),
    latitudes: Float64List.fromList([(35 + id).toDouble()]),
    longitudes: Float64List.fromList([(139 + id).toDouble()]),
    depthsKm: Float32List.fromList([double.nan]),
    depthValidity: Uint8List(1),
    magnitudes: Float32List.fromList([double.nan]),
    magnitudeValidity: Uint8List(1),
    originTimeUnixMilliseconds: Int64List.fromList([id]),
    maxIntensityDictionaryIndexes: Uint32List(1),
    maxIntensityValidity: Uint8List(1),
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

  Future<void> waitUntil(bool Function() predicate) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (!predicate()) {
      if (DateTime.now().isAfter(deadline)) {
        throw StateError('Timed out waiting for worker routing.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}
