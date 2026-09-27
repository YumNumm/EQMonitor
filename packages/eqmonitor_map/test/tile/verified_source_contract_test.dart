import 'dart:io';
import 'dart:typed_data';

import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_repository.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_exception.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_limits.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decoder.dart';
import 'package:eqmonitor_map/src/tile/verified_pm_tiles_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';

import '../support/minimal_pmtiles_archive_builder.dart';

const _builder = MinimalPmTilesArchiveBuilder();

const _archiveLimits = PmTilesV3Limits(
  maxDirectoryDepth: 3,
  rootDirectoryWindowLength: 16384,
  maxDirectoryEncodedBytes: 1 << 20,
  maxDirectoryDecodedBytes: 8 << 20,
  maxDirectoryEntries: 65536,
  maxCachedLeafDirectories: 4,
  maxTileEncodedBytes: 4 << 20,
  maxTileDecodedBytes: 16 << 20,
);

const _mvtLimits = MvtDecodeLimits(
  maxLayers: 16,
  maxFeaturesPerLayer: 64,
  maxRingsPerFeature: 16,
  maxVerticesPerRing: 256,
  maxCommandsPerFeature: 1024,
  maxLayerNameBytes: 64,
  maxKeysPerLayer: 64,
  maxValuesPerLayer: 64,
  maxTagsPerFeature: 64,
  maxPropertyStringBytes: 64,
);

void main() {
  test(
    'VerifiedPmTilesSource repository returns null for sparse gaps and '
    'typed errors for invalid coordinates, never empty tile bytes',
    () async {
      final archiveBytes = _builder.buildSingleTile(
        tileId: 1,
        tileBytes: const [1, 2, 3],
        minZoom: 1,
        maxZoom: 1,
      );
      final file = File(
        '${Directory.systemTemp.path}/eqmonitor_map_verified_source_'
        '${DateTime.now().microsecondsSinceEpoch}.pmtiles',
      );
      await file.writeAsBytes(archiveBytes, flush: true);
      addTearDown(file.deleteSync);

      // package は sha256 を再検証しない（app 検証済み前提）。契約ピン用の固定値。
      final repository = await BaseMapTileRepository.open(
        source: VerifiedPmTilesSource(
          sourceInstanceId: 'contract-local-1',
          absolutePath: file.path,
          sizeBytes: archiveBytes.length,
          sha256: '0' * 64,
        ),
        limits: _archiveLimits,
      );
      addTearDown(repository.close);

      expect(
        await repository.readTile(const CanonicalTileId(z: 1, x: 0, y: 0)),
        orderedEquals([1, 2, 3]),
      );
      expect(
        await repository.readTile(const CanonicalTileId(z: 1, x: 1, y: 1)),
        isNull,
      );
      await expectLater(
        repository.readTile(const CanonicalTileId(z: 1, x: 2, y: 0)),
        throwsA(isA<PmTilesV3InvalidTileCoordinateException>()),
      );
    },
  );

  test(
    'corrupt MVT bytes fail as typed MvtDecodeException, not an empty tile',
    () {
      expect(
        () => decodeMvtTile(
          Uint8List.fromList(const [0xff, 0xff, 0xff, 0xff, 0xff]),
          limits: _mvtLimits,
        ),
        throwsA(isA<MvtMalformedProtobufException>()),
      );
    },
  );
}
