import 'dart:typed_data';

import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:eqmonitor_map/src/tile/map_tile_pipeline_budget.dart';
import 'package:flutter_test/flutter_test.dart';

BaseMapTileGeometry _geometry(int marker) => BaseMapTileGeometry(
  layers: [
    BaseMapTileFillLayerGeometry(
      styleLayerId: 'countriesFill',
      extent: 4096,
      meshes: [
        FillMesh(
          positions: Float32List.fromList([marker.toDouble(), 0]),
          indices: Uint16List.fromList([0]),
          vertexCount: 1,
        ),
      ],
    ),
  ],
);

MapTilePipelineBudget _budget({int maxCacheEntries = 3, int maxPinned = 2}) =>
    createMapTilePipelineBudget(
      schemaVersion: 1,
      maxInFlightDecodes: 2,
      maxCacheEntries: maxCacheEntries,
      maxPinnedEntries: maxPinned,
      cpuWorkUnitsPerFrame: 4,
      maxGpuUploadBytesPerFrame: null,
    );

void main() {
  BaseMapTileCache cacheOf(MapTilePipelineBudget budget) => BaseMapTileCache(
    maxEntries: budget.maxCacheEntries,
    maxParentFallbackSteps: 1,
    budget: budget,
  );

  void put(BaseMapTileCache cache, int i) => cache.put(
    sourceInstanceId: 'a',
    tileId: CanonicalTileId(z: 5, x: i, y: 0),
    geometry: _geometry(i),
    token: cache.beginDecode(),
  );

  group('pinning', () {
    test('requires a budget to be configured', () {
      final cache = BaseMapTileCache(maxEntries: 3, maxParentFallbackSteps: 1);
      put(cache, 0);
      expect(
        () => cache.pin(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 5, x: 0, y: 0),
        ),
        throwsStateError,
      );
    });

    test('pinning an uncached tile throws', () {
      final cache = cacheOf(_budget());
      expect(
        () => cache.pin(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 5, x: 9, y: 0),
        ),
        throwsArgumentError,
      );
    });

    test('a pinned entry survives capacity eviction; LRU ones do not', () {
      final cache = cacheOf(_budget());
      put(cache, 0);
      cache.pin(
        sourceInstanceId: 'a',
        tileId: const CanonicalTileId(z: 5, x: 0, y: 0),
      );
      put(cache, 1);
      put(cache, 2);
      put(cache, 3);

      expect(
        cache.get(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 5, x: 0, y: 0),
        ),
        isNotNull,
        reason: 'the pinned entry must never be evicted',
      );
      expect(cache.length, lessThanOrEqualTo(3));
    });

    test('pinning beyond the budget cap throws', () {
      final cache = cacheOf(_budget(maxCacheEntries: 5));
      for (var i = 0; i < 3; i++) {
        put(cache, i);
      }
      cache.pin(
        sourceInstanceId: 'a',
        tileId: const CanonicalTileId(z: 5, x: 0, y: 0),
      );
      cache.pin(
        sourceInstanceId: 'a',
        tileId: const CanonicalTileId(z: 5, x: 1, y: 0),
      );
      expect(
        () => cache.pin(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 5, x: 2, y: 0),
        ),
        throwsStateError,
      );
    });

    test('unpinning lets an entry be evicted again', () {
      final cache = cacheOf(_budget(maxCacheEntries: 2, maxPinned: 1));
      put(cache, 0);
      cache.pin(
        sourceInstanceId: 'a',
        tileId: const CanonicalTileId(z: 5, x: 0, y: 0),
      );
      cache.unpin(
        sourceInstanceId: 'a',
        tileId: const CanonicalTileId(z: 5, x: 0, y: 0),
      );
      put(cache, 1);
      put(cache, 2);

      expect(
        cache.get(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 5, x: 0, y: 0),
        ),
        isNull,
      );
      expect(cache.length, 2);
    });
  });
}
