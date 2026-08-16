import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decoder_runner.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:test/test.dart';

import '../support/controlled_seismicity_archive.dart';
import '../support/controlled_seismicity_decoder_worker_factory.dart';
import '../support/controlled_seismicity_decoder_worker_handle.dart';

void main() {
  final fixtures = _Task48Fixtures();

  test('start returns sync then traverses tiles sequentially', () async {
    final descriptor = fixtures.descriptor(dataZoom: 2);
    final tileA = Uint8List.fromList([10, 11]);
    final tileB = Uint8List.fromList([20, 21, 22]);
    final archive = ControlledSeismicityArchive(
      descriptor: descriptor,
      occupiedTileIds: const [7, 9],
      tileBytes: {7: tileA, 9: tileB},
    );
    final handle = ControlledSeismicityDecoderWorkerHandle(
      captureTileBytes: true,
    );
    final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
    final runner = SeismicityPmTilesDecoderRunner(factory: factory);

    final operation = runner.start(archive: archive, chunkCapacity: 8);
    expect(factory.spawnCount, 0);
    expect(identical(operation, operation), isTrue);

    await fixtures.waitUntil(() => factory.spawnCount == 1);
    expect(identical(factory.acceptedDescriptor, descriptor), isTrue);
    expect(factory.chunkCapacity, 8);
    factory.succeedSpawn();

    await fixtures.waitUntil(() => handle.decodeCount == 1);
    expect(archive.zoomRequests, [2]);
    expect(archive.readRequests, [7]);
    expect(handle.capturedTileBytes, [
      [10, 11],
    ]);

    const firstProgress = SeismicityPmTilesDecodeProgress(
      decodedTileCount: 1,
      rawFeatureCount: 1,
      uniqueFeatureCount: 1,
    );
    handle.succeedDecode(progress: firstProgress);

    await fixtures.waitUntil(() => handle.decodeCount == 2);
    expect(archive.readRequests, [7, 9]);
    expect(handle.capturedTileBytes, [
      [10, 11],
      [20, 21, 22],
    ]);
    expect(handle.finishCount, 0);

    const secondProgress = SeismicityPmTilesDecodeProgress(
      decodedTileCount: 2,
      rawFeatureCount: 2,
      uniqueFeatureCount: 2,
    );
    handle.succeedDecode(progress: secondProgress);
    await fixtures.waitUntil(() => handle.finishCount == 1);
    expect(factory.spawnCount, 1);
    expect(handle.finishCount, 1);
    handle.succeedFinish(
      dataset: SeismicityPmTilesDataset(
        archiveRevision: descriptor.archiveRevision,
        schemaVersion: descriptor.schemaVersion,
        dataZoom: descriptor.dataZoom,
        featureCount: 0,
        chunks: const [],
      ),
    );
    handle.succeedClose();
    handle.succeedRetired();
  });

  test('invalid descriptor fails before spawn', () async {
    final descriptor = fixtures.descriptor(dataZoom: 2, schemaVersion: 2);
    final archive = ControlledSeismicityArchive(
      descriptor: descriptor,
      occupiedTileIds: const [1],
      tileBytes: {
        1: Uint8List.fromList([1]),
      },
    );
    final handle = ControlledSeismicityDecoderWorkerHandle();
    final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
    final runner = SeismicityPmTilesDecoderRunner(factory: factory);

    runner.start(archive: archive, chunkCapacity: 1);
    expect(factory.spawnCount, 0);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(factory.spawnCount, 0);
    expect(handle.decodeCount, 0);
    expect(archive.readRequests, isEmpty);
  });
}

final class _Task48Fixtures {
  SeismicityPmTilesArchiveDescriptor descriptor({
    required int dataZoom,
    int schemaVersion = 1,
  }) => SeismicityPmTilesArchiveDescriptor(
    source: SeismicityPmTilesSource.network(
      archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
    ),
    schemaVersion: schemaVersion,
    dataZoom: dataZoom,
    expectedSizeBytes: 64,
    expectedFeatureCount: 0,
    archiveRevision: 'rev-task-48',
    periodFrom: DateTime.utc(2024),
    periodTo: DateTime.utc(2025),
  );

  Future<void> waitUntil(bool Function() predicate) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (!predicate()) {
      if (DateTime.now().isAfter(deadline)) {
        throw StateError('Timed out waiting for traversal signal.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}
