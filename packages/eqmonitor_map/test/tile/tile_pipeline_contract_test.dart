// tile pipeline の本番契約を local / remote の両 source で end-to-end に固定する
// (Issue #1591 Task 15)。個別 unit test（`verified_source_contract_test.dart` /
// `map_remote_pm_tiles_reader_test.dart` / `base_map_tile_cache_test.dart` 等）が
// 各段を検証するのに対し、本ファイルは
// `VerifiedTileSource → BaseMapTileRepository → BaseMapTileDecoder →
// BaseMapTileCache` を実際に繋いだときに Global Constraints が保たれることだけを
// 見る。
//
// MVT は実 fixture（`test/tile/mvt/fixtures/*.mvt`）ではなく合成 tile を使う。
// 実 fixture の layer 名は `baseMapLayerSpecs` の source layer 名と別系統であり
// decode しても mesh が空になるため、pipeline が geometry を運べたことを
// 確認できない（`base_map_tile_decoder_test.dart` 冒頭の注記と同じ理由）。
import 'dart:io';
import 'dart:typed_data';

import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_repository.dart';
import 'package:eqmonitor_map/src/tile/map_tile_fallback_policy.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_limits.dart';
import 'package:eqmonitor_map/src/tile/verified_pm_tiles_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';

import '../support/controlled_remote_pmtiles_server.dart';
import '../support/minimal_pmtiles_archive_builder.dart';
import 'mvt/support/mvt_fixture_builder.dart';

const _mvt = MvtFixtureBuilder();

const _archiveLimits = PmTilesV3Limits(
  maxDirectoryDepth: 3,
  rootDirectoryWindowLength: 16384,
);

const _decodeLimits = BaseMapTileDecodeLimits(
  mvtLimits: MvtDecodeLimits(
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
  ),
  fillLimits: FillMeshBuilderLimits(
    maxHolesPerPolygon: 16,
    maxVerticesPerFeature: 4096,
    maxVerticesPerSegment: 65536,
  ),
  lineLimits: LineMeshBuilderLimits(maxVerticesPerSegment: 65536),
  lineMiterLimit: 4,
);

/// `tileId: 1` = `CanonicalTileId(z: 1, x: 0, y: 0)`。`(1,1,1)` は archive に
/// 入れないため sparse gap（`readTile` が `null` を返す）になる。
const _presentTile = CanonicalTileId(z: 1, x: 0, y: 0);
const _missingTile = CanonicalTileId(z: 1, x: 1, y: 1);

/// `countries` layer に三角形 1 枚だけを持つ合成 MVT。
Uint8List _buildCountriesTile() {
  return _mvt.buildTile(
    layers: [
      _mvt.buildLayer(
        name: 'countries',
        extent: 4096,
        features: [
          _mvt.buildFeature(
            geomType: MvtFixtureBuilder.geomTypePolygon,
            rawCommands: [
              ..._mvt.moveTo([(0, 0)]),
              ..._mvt.lineTo([(10, 0), (-10, 10)]),
              ..._mvt.closePath(),
            ],
          ),
        ],
      ),
    ],
  );
}

/// repository → decoder → cache を実際に通し、cache へ入った geometry を返す。
/// cache へ入らなかった（欠損 / cancel 済み）場合は `null`。
Future<BaseMapTileGeometry?> _runPipeline({
  required BaseMapTileRepository repository,
  required BaseMapTileCache cache,
  required CanonicalTileId tileId,
  AsyncGenerationTokenTap? beforePut,
}) async {
  final token = cache.beginDecode();
  final tileBytes = await repository.readTile(tileId);
  if (tileBytes == null) {
    return null;
  }
  final geometry = await const BaseMapTileDecoder().decode(
    tileBytes: tileBytes,
    limits: _decodeLimits,
  );
  beforePut?.call();
  cache.put(
    sourceInstanceId: repository.source.cacheIdentity,
    tileId: tileId,
    geometry: geometry,
    token: token,
  );
  return cache.get(
    sourceInstanceId: repository.source.cacheIdentity,
    tileId: tileId,
  );
}

/// [_runPipeline] が decode 完了後・`put` 直前に呼ぶフック（cancel の差し込み用）。
typedef AsyncGenerationTokenTap = void Function();

void _expectCarriesCountriesFill(BaseMapTileGeometry? geometry) {
  final fill = geometry!.layers.firstWhere(
    (layer) => layer.styleLayerId == 'countriesFill',
  ) as BaseMapTileFillLayerGeometry;
  expect(fill.extent, 4096);
  expect(fill.meshes, isNotEmpty);
}

void main() {
  final archiveBytes = const MinimalPmTilesArchiveBuilder().buildSingleTile(
    tileId: 1,
    tileBytes: _buildCountriesTile(),
    minZoom: 1,
    maxZoom: 1,
  );

  Future<BaseMapTileRepository> openLocal() async {
    final file = File(
      '${Directory.systemTemp.path}/eqmonitor_map_pipeline_'
      '${DateTime.now().microsecondsSinceEpoch}.pmtiles',
    );
    await file.writeAsBytes(archiveBytes, flush: true);
    addTearDown(file.deleteSync);
    final repository = await BaseMapTileRepository.open(
      // package は sha256 を再検証しない（app 検証済み前提）。契約ピン用の固定値。
      source: VerifiedPmTilesSource(
        sourceInstanceId: 'pipeline-local',
        absolutePath: file.path,
        sizeBytes: archiveBytes.length,
        sha256: '0' * 64,
      ),
      limits: _archiveLimits,
    );
    addTearDown(repository.close);
    return repository;
  }

  Future<(BaseMapTileRepository, ControlledRemotePmTilesServer)>
  openRemote() async {
    final server = await ControlledRemotePmTilesServer.start(
      archiveBytes: archiveBytes,
    );
    addTearDown(server.stop);
    final repository = await BaseMapTileRepository.open(
      source: createVerifiedRemotePmTilesSource(
        sourceInstanceId: 'pipeline-remote',
        sourceRevision: 1,
        url: server.url,
        sizeBytes: archiveBytes.length,
        sha256: 'a' * 64,
      ),
      limits: _archiveLimits,
      remoteMaxCacheBytes: 1 << 16,
    );
    addTearDown(repository.close);
    return (repository, server);
  }

  BaseMapTileCache newCache({
    MapTileFallbackPolicy policy = MapTileFallbackPolicy.basemap,
  }) {
    final cache = BaseMapTileCache(
      maxEntries: 8,
      maxParentFallbackSteps: 2,
      fallbackPolicy: policy,
    );
    addTearDown(cache.dispose);
    return cache;
  }

  test('local verified source carries tile geometry through to the '
      'cache', () async {
    final repository = await openLocal();
    final cache = newCache();

    _expectCarriesCountriesFill(
      await _runPipeline(
        repository: repository,
        cache: cache,
        tileId: _presentTile,
      ),
    );
  });

  test('remote identity source carries the same geometry using range '
      'requests only', () async {
    final (repository, server) = await openRemote();
    final cache = newCache();

    _expectCarriesCountriesFill(
      await _runPipeline(
        repository: repository,
        cache: cache,
        tileId: _presentTile,
      ),
    );
    // 全リクエストが Range 要求であること = archive 全体を 200 で取りに行って
    // いないこと（Global Constraints「`200 OK` で Range 要求 body 全体受理禁止」
    // の入口側）。
    expect(server.rangeRequests, isNotEmpty);
    expect(
      server.rangeRequests,
      everyElement(startsWith('bytes=')),
    );
  });

  test('a sparse gap stays null on both sources and caches nothing', () async {
    final local = await openLocal();
    final (remote, _) = await openRemote();
    final cache = newCache();

    for (final repository in [local, remote]) {
      expect(
        await _runPipeline(
          repository: repository,
          cache: cache,
          tileId: _missingTile,
        ),
        isNull,
        reason: '欠損 tile を空 geometry へ丸めない',
      );
    }
    expect(cache.length, 0);
  });

  test('geometry decoded under a cancelled incarnation never reaches the '
      'cache, and cancelling is not an error', () async {
    final repository = await openLocal();
    final cache = newCache();

    expect(
      await _runPipeline(
        repository: repository,
        cache: cache,
        tileId: _presentTile,
        beforePut: cache.cancelInFlight,
      ),
      isNull,
    );
    expect(cache.length, 0);

    // cancel 後に発行した token は有効なままで、次の decode は通る。
    _expectCarriesCountriesFill(
      await _runPipeline(
        repository: repository,
        cache: cache,
        tileId: _presentTile,
      ),
    );
  });

  test('basemap falls back to the decoded parent while hazard fails '
      'closed', () async {
    final repository = await openLocal();
    const child = CanonicalTileId(z: 2, x: 0, y: 0);

    for (final policy in [
      MapTileFallbackPolicy.basemap,
      MapTileFallbackPolicy.hazard,
    ]) {
      final cache = newCache(policy: policy);
      await _runPipeline(
        repository: repository,
        cache: cache,
        tileId: _presentTile,
      );

      final result = cache.lookupWithFallback(
        sourceInstanceId: repository.source.cacheIdentity,
        tileId: child,
        maxParentSteps: 2,
      );
      expect(
        result,
        policy == MapTileFallbackPolicy.basemap
            ? isA<BaseMapTileFallbackParent>()
            : isA<BaseMapTileFallbackMiss>(),
      );
    }
  });
}
