import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_tile_id.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/test.dart';

import '../support/seismicity_archive_fixture_builder.dart';
import '../support/seismicity_mvt_fixture_mutator.dart';
import '../support/seismicity_pmtiles_archive_writer.dart';

void main() {
  final fixtures = _Task62Fixtures();

  test(
    'rejects malformed later MVT without publishing earlier rows',
    () async {
      final built = fixtures.buildArchive();
      final archive = await fixtures.openAssetArchive(
        bytes: built.bytes,
        descriptor: built.descriptor,
      );
      final operation = SeismicityPmTilesDecoder().start(
        archive: archive,
        chunkCapacity: 1,
      );
      final statesFuture = operation.states.toList();

      final result = await operation.result;
      final states = await statesFuture;

      expect(
        result,
        isA<SeismicityPmTilesFailure<SeismicityPmTilesDataset>>().having(
          (value) => value.exception,
          'exception',
          isA<SeismicityPmTilesInvalidHypocenterFeatureException>()
              .having((error) => error.tileId, 'tileId', built.malformedTileId)
              .having((error) => error.featureIndex, 'featureIndex', 0)
              .having((error) => error.field, 'field', 'hypocenter_id')
              .having((error) => error.reason, 'reason', 'invalid_uuid'),
        ),
      );
      expect(
        states,
        contains(const SeismicityPmTilesLoadState.openingSource()),
      );
      expect(
        states,
        contains(const SeismicityPmTilesLoadState.readingDirectory()),
      );
      expect(
        states,
        contains(
          const SeismicityPmTilesLoadState.decoding(
            progress: SeismicityPmTilesDecodeProgress(
              decodedTileCount: 1,
              rawFeatureCount: 1,
              uniqueFeatureCount: 1,
            ),
          ),
        ),
      );
      expect(
        states.whereType<SeismicityPmTilesLoadFailed>().single.exception,
        isA<SeismicityPmTilesInvalidHypocenterFeatureException>(),
      );
      expect(
        states,
        isNot(contains(const SeismicityPmTilesLoadState.completed())),
      );
      expect(states.whereType<SeismicityPmTilesLoadCompleted>(), isEmpty);

      await expectLater(
        archive.readTile(tileId: built.validTileId),
        throwsA(isA<SeismicityPmTilesException>()),
      );
      await archive.close();
    },
  );
}

final class _Task62BuiltArchive {
  const _Task62BuiltArchive({
    required this.bytes,
    required this.descriptor,
    required this.validTileId,
    required this.malformedTileId,
  });

  final Uint8List bytes;
  final SeismicityPmTilesArchiveDescriptor descriptor;
  final int validTileId;
  final int malformedTileId;
}

final class _Task62Fixtures {
  final tileId = const PmTilesV3TileId();
  final archiveWriter = const SeismicityPmTilesArchiveWriter();

  _Task62BuiltArchive buildArchive() {
    final catalog = buildSeismicityMvtFixtureCatalog();
    final validTileId = tileId.tileIdForZxy(z: 2, x: 0, y: 0);
    final malformedTileId = tileId.tileIdForZxy(z: 2, x: 1, y: 0);
    final malformed = catalog.corruptions
        .singleWhere((entry) => entry.name == 'invalid_uuid')
        .bytes;
    final bytes = archiveWriter.write(
      payloads: [
        SeismicityPmTilesArchiveTilePayload(
          tileId: validTileId,
          bytes: Uint8List.fromList(catalog.valid),
        ),
        SeismicityPmTilesArchiveTilePayload(
          tileId: malformedTileId,
          bytes: Uint8List.fromList(malformed),
        ),
      ],
      internalCompression: PmTilesV3CompressionDecoder.gzipCompression,
      tileCompression: PmTilesV3CompressionDecoder.gzipCompression,
      minZoom: 2,
      maxZoom: 2,
      clustered: true,
    );
    final descriptor = SeismicityPmTilesArchiveDescriptor(
      source: const SeismicityPmTilesSource.asset(
        assetKey: SeismicityArchiveFixtureBuilder.assetKey,
      ),
      schemaVersion: 1,
      dataZoom: 2,
      expectedSizeBytes: bytes.length,
      expectedFeatureCount: 2,
      archiveRevision: 'rev-task-62',
      periodFrom: DateTime.utc(2024),
      periodTo: DateTime.utc(2025),
    );
    return _Task62BuiltArchive(
      bytes: bytes,
      descriptor: descriptor,
      validTileId: validTileId,
      malformedTileId: malformedTileId,
    );
  }

  Future<SeismicityPmTilesArchive> openAssetArchive({
    required Uint8List bytes,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) async {
    final factory = SeismicityRandomAccessReaderFactory(
      assetLoader: ({required String assetKey}) async {
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
