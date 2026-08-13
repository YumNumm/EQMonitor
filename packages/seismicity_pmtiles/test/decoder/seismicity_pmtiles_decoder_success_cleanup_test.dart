import 'dart:async';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decoder_runner.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_result.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:test/test.dart';

import '../support/controlled_seismicity_archive.dart';
import '../support/controlled_seismicity_decoder_worker_factory.dart';
import '../support/controlled_seismicity_decoder_worker_handle.dart';

void main() {
  final fixtures = _Task51Fixtures();

  test('runs archive close then worker close/retired before settle', () async {
    final descriptor = fixtures.descriptor(expectedFeatureCount: 1);
    final archive = ControlledSeismicityArchive(
      descriptor: descriptor,
      occupiedTileIds: const [1],
      tileBytes: {1: Uint8List.fromList([1])},
    )..deferCloseCompletion = true;
    final handle = ControlledSeismicityDecoderWorkerHandle();
    final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
    final runner = SeismicityPmTilesDecoderRunner(factory: factory);
    final operation = runner.start(archive: archive, chunkCapacity: 4);

    var resultCompleted = false;
    unawaited(operation.result.then((_) => resultCompleted = true));

    await fixtures.waitUntil(() => factory.spawnCount == 1);
    factory.succeedSpawn();
    await fixtures.waitUntil(() => handle.decodeCount == 1);
    handle.succeedDecode(
      progress: const SeismicityPmTilesDecodeProgress(
        decodedTileCount: 1,
        rawFeatureCount: 1,
        uniqueFeatureCount: 1,
      ),
    );
    await fixtures.waitUntil(() => handle.finishCount == 1);
    handle.succeedFinish(
      dataset: fixtures.dataset(
        descriptor: descriptor,
        chunks: [fixtures.chunk(id: 1)],
      ),
    );

    await fixtures.waitUntil(() => archive.closeCount == 1);
    expect(handle.closeCount, 0);
    expect(resultCompleted, isFalse);

    archive.releaseClose();
    await fixtures.waitUntil(() => handle.closeCount == 1);
    expect(resultCompleted, isFalse);

    handle.succeedClose();
    await Future<void>.delayed(Duration.zero);
    expect(resultCompleted, isFalse);

    handle.succeedRetired();
    final result = await operation.result;
    expect(result, isA<SeismicityPmTilesSuccess<SeismicityPmTilesDataset>>());
    expect(resultCompleted, isTrue);
    expect(archive.closeCount, 1);
    expect(handle.closeCount, 1);
    expect(handle.cancelCount, 0);

    await operation.cancel();
    await archive.close();
    expect(archive.closeCount, 1);
    expect(handle.closeCount, 1);
    expect(handle.cancelCount, 0);
  });
}

final class _Task51Fixtures {
  SeismicityPmTilesArchiveDescriptor descriptor({
    required int expectedFeatureCount,
  }) => SeismicityPmTilesArchiveDescriptor(
    source: SeismicityPmTilesSource.network(
      archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
    ),
    schemaVersion: 1,
    dataZoom: 2,
    expectedSizeBytes: 64,
    expectedFeatureCount: expectedFeatureCount,
    archiveRevision: 'rev-task-51',
    periodFrom: DateTime.utc(2024),
    periodTo: DateTime.utc(2025),
  );

  SeismicityPmTilesDataset dataset({
    required SeismicityPmTilesArchiveDescriptor descriptor,
    required List<SeismicityPmTilesChunk> chunks,
  }) => SeismicityPmTilesDataset(
    archiveRevision: descriptor.archiveRevision,
    schemaVersion: descriptor.schemaVersion,
    dataZoom: descriptor.dataZoom,
    featureCount: descriptor.expectedFeatureCount,
    chunks: chunks,
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

  Future<void> waitUntil(bool Function() predicate) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (!predicate()) {
      if (DateTime.now().isAfter(deadline)) {
        throw StateError('Timed out waiting for cleanup signal.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}
