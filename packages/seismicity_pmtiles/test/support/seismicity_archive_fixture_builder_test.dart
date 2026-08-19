import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/test.dart';

import 'seismicity_archive_fixture_builder.dart';

void main() {
  final fixtures = _Task58Fixtures();

  test(
    'opens gzip z2 fixture via asset reader and rejects truncations',
    () async {
      final fixture = fixtures.builder.buildGzipZ2(
        schemaVersion: 1,
        expectedFeatureCount: 2,
        archiveRevision: 'rev-task-58',
        periodFrom: DateTime.utc(2024),
        periodTo: DateTime.utc(2025),
      );
      expect(fixture.bytes.length, fixture.descriptor.expectedSizeBytes);

      final archive = await fixtures.openAssetArchive(
        bytes: fixture.bytes,
        descriptor: fixture.descriptor,
      );
      expect(identical(archive.descriptor, fixture.descriptor), isTrue);
      expect(
        await archive.occupiedTileIdsAtZoom(zoom: 2).toList(),
        fixture.occupiedTileIds,
      );
      for (final tileId in fixture.occupiedTileIds) {
        expect(
          await archive.readTile(tileId: tileId),
          fixture.decompressedTiles[tileId],
        );
      }
      await archive.close();

      await expectLater(
        fixtures.openAssetArchive(
          bytes: fixture.truncatedHeader,
          descriptor: fixture.descriptor.copyWith(
            expectedSizeBytes: fixture.truncatedHeader.length,
          ),
        ),
        throwsA(isA<SeismicityPmTilesException>()),
      );
      await expectLater(
        fixtures.openAssetArchive(
          bytes: fixture.truncatedDirectory,
          descriptor: fixture.descriptor.copyWith(
            expectedSizeBytes: fixture.truncatedDirectory.length,
          ),
        ),
        throwsA(isA<SeismicityPmTilesException>()),
      );
      await expectLater(
        fixtures.openAssetArchive(
          bytes: fixture.truncatedTileData,
          descriptor: fixture.descriptor.copyWith(
            expectedSizeBytes: fixture.truncatedTileData.length,
          ),
        ),
        throwsA(isA<SeismicityPmTilesException>()),
      );
    },
  );
}

final class _Task58Fixtures {
  final builder = SeismicityArchiveFixtureBuilder();

  Future<SeismicityPmTilesArchive> openAssetArchive({
    required Uint8List bytes,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) async {
    final factory = SeismicityRandomAccessReaderFactory(
      assetLoader: ({required assetKey}) async {
        expect(assetKey, SeismicityArchiveFixtureBuilder.assetKey);
        return bytes;
      },
      dio: Dio(),
      networkMaxCacheBytes: 1024,
    );
    final opened = await factory.create(
      descriptor: descriptor,
      cancelToken: CancelToken(),
    );
    final reader = switch (opened) {
      SeismicityPmTilesSuccess<PmTilesRandomAccessReader>(:final value) =>
        value,
      SeismicityPmTilesFailure<PmTilesRandomAccessReader>(:final exception) =>
        throw exception,
    };
    return SeismicityPmTilesArchive.open(
      reader: reader,
      descriptor: descriptor,
    );
  }
}
