import 'dart:typed_data';

import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:flutter_test/flutter_test.dart';

/// `marker`だけが違う[BaseMapTileGeometry]のsentinel。cacheが正しい
/// entryを返しているか(取り違え・上書きが起きていないか)を、marker値の
/// 一致で判定する。
BaseMapTileGeometry _geometry(int marker) {
  return BaseMapTileGeometry(
    layers: [
      BaseMapTileFillLayerGeometry(
        styleLayerId: 'countriesFill',
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
}

int _markerOf(BaseMapTileGeometry geometry) {
  final fill = geometry.layers.single as BaseMapTileFillLayerGeometry;
  return fill.meshes.single.positions[0].round();
}

void main() {
  group('cache key', () {
    test('the same sourceInstanceId+tileId retrieves the same entry', () {
      final cache = BaseMapTileCache(maxEntries: 10);
      const tileId = CanonicalTileId(z: 5, x: 3, y: 4);
      cache.put(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: _geometry(1),
        token: cache.beginDecode(),
      );

      final result = cache.get(sourceInstanceId: 'a', tileId: tileId);
      expect(result, isNotNull);
      expect(_markerOf(result!), 1);
    });

    test('a different sourceInstanceId is a different entry', () {
      final cache = BaseMapTileCache(maxEntries: 10);
      const tileId = CanonicalTileId(z: 5, x: 3, y: 4);
      cache.put(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: _geometry(1),
        token: cache.beginDecode(),
      );

      expect(cache.get(sourceInstanceId: 'b', tileId: tileId), isNull);
    });

    test(
      'the integer zoom is part of the key: tiles with the same x/y but '
      'different z do not collide',
      () {
        final cache = BaseMapTileCache(maxEntries: 10);
        const tileIdZ5 = CanonicalTileId(z: 5, x: 1, y: 1);
        const tileIdZ6 = CanonicalTileId(z: 6, x: 1, y: 1);
        cache
          ..put(
            sourceInstanceId: 'a',
            tileId: tileIdZ5,
            geometry: _geometry(5),
            token: cache.beginDecode(),
          )
          ..put(
            sourceInstanceId: 'a',
            tileId: tileIdZ6,
            geometry: _geometry(6),
            token: cache.beginDecode(),
          );

        final atZ5 = cache.get(sourceInstanceId: 'a', tileId: tileIdZ5);
        final atZ6 = cache.get(sourceInstanceId: 'a', tileId: tileIdZ6);
        expect(atZ5, isNotNull);
        expect(atZ6, isNotNull);
        expect(_markerOf(atZ5!), 5);
        expect(_markerOf(atZ6!), 6);
      },
    );

    test(
      'repeated noteActiveZoom calls with the same floor (simulating a '
      'fractional camera zoom change) do not invalidate the entry',
      () {
        final cache = BaseMapTileCache(maxEntries: 10);
        const tileId = CanonicalTileId(z: 5, x: 0, y: 0);
        cache.put(
          sourceInstanceId: 'a',
          tileId: tileId,
          geometry: _geometry(1),
          token: cache.beginDecode(),
        );

        // camera.zoomが5.0→5.4→5.9と小数だけ動いても floor は常に5。
        cache
          ..noteActiveZoom(5)
          ..noteActiveZoom(5)
          ..noteActiveZoom(5);

        expect(cache.get(sourceInstanceId: 'a', tileId: tileId), isNotNull);
      },
    );
  });

  group('eviction (zoom window)', () {
    test('keeps entries within activeZoom ± 1 and evicts the rest', () {
      final cache = BaseMapTileCache(maxEntries: 100);
      for (final z in [3, 4, 5, 6, 7]) {
        cache.put(
          sourceInstanceId: 'a',
          tileId: CanonicalTileId(z: z, x: 0, y: 0),
          geometry: _geometry(z),
          token: cache.beginDecode(),
        );
      }

      cache.noteActiveZoom(5);

      expect(
        cache.get(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 3, x: 0, y: 0),
        ),
        isNull,
        reason: 'z=3 is outside [4, 6]',
      );
      expect(
        cache.get(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 4, x: 0, y: 0),
        ),
        isNotNull,
      );
      expect(
        cache.get(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 5, x: 0, y: 0),
        ),
        isNotNull,
      );
      expect(
        cache.get(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 6, x: 0, y: 0),
        ),
        isNotNull,
      );
      expect(
        cache.get(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 7, x: 0, y: 0),
        ),
        isNull,
        reason: 'z=7 is outside [4, 6]',
      );
      expect(cache.length, 3);
    });
  });

  group('eviction (capacity)', () {
    test('evicts the oldest entry (FIFO) once maxEntries is exceeded', () {
      final cache = BaseMapTileCache(maxEntries: 2);
      cache
        ..put(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 5, x: 0, y: 0),
          geometry: _geometry(1),
          token: cache.beginDecode(),
        )
        ..put(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 5, x: 1, y: 0),
          geometry: _geometry(2),
          token: cache.beginDecode(),
        )
        ..put(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 5, x: 2, y: 0),
          geometry: _geometry(3),
          token: cache.beginDecode(),
        );

      expect(cache.length, 2);
      expect(
        cache.get(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 5, x: 0, y: 0),
        ),
        isNull,
        reason: 'the first-inserted entry should be evicted',
      );
      expect(
        cache.get(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 5, x: 1, y: 0),
        ),
        isNotNull,
      );
      expect(
        cache.get(
          sourceInstanceId: 'a',
          tileId: const CanonicalTileId(z: 5, x: 2, y: 0),
        ),
        isNotNull,
      );
    });
  });

  group('incarnation token', () {
    test('put is dropped once the token has been cancelled', () {
      final cache = BaseMapTileCache(maxEntries: 10);
      const tileId = CanonicalTileId(z: 5, x: 0, y: 0);

      final token = cache.beginDecode();
      cache.cancelInFlight();
      cache.put(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: _geometry(1),
        token: token,
      );

      expect(
        cache.get(sourceInstanceId: 'a', tileId: tileId),
        isNull,
        reason: 'a stale token must not be able to write to the cache',
      );
    });

    test('a token issued after cancellation still writes normally', () {
      final cache = BaseMapTileCache(maxEntries: 10);
      const tileId = CanonicalTileId(z: 5, x: 0, y: 0);

      cache.cancelInFlight();
      final freshToken = cache.beginDecode();
      cache.put(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: _geometry(1),
        token: freshToken,
      );

      expect(cache.get(sourceInstanceId: 'a', tileId: tileId), isNotNull);
    });
  });

  group('lookupWithFallback', () {
    test('returns an exact hit when the tile itself is cached', () {
      final cache = BaseMapTileCache(maxEntries: 10);
      const tileId = CanonicalTileId(z: 5, x: 2, y: 2);
      cache.put(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: _geometry(1),
        token: cache.beginDecode(),
      );

      final result = cache.lookupWithFallback(
        sourceInstanceId: 'a',
        tileId: tileId,
        maxParentSteps: 3,
      );

      expect(result, isA<BaseMapTileFallbackExact>());
      expect(_markerOf((result as BaseMapTileFallbackExact).geometry), 1);
    });

    test(
      'falls back to the 4 children when all 4 are cached and the tile '
      'itself is not',
      () {
        final cache = BaseMapTileCache(maxEntries: 10);
        const tileId = CanonicalTileId(z: 5, x: 2, y: 2);
        final childIds = tileId.children();
        for (var i = 0; i < childIds.length; i++) {
          cache.put(
            sourceInstanceId: 'a',
            tileId: childIds[i],
            geometry: _geometry(100 + i),
            token: cache.beginDecode(),
          );
        }

        final result = cache.lookupWithFallback(
          sourceInstanceId: 'a',
          tileId: tileId,
          maxParentSteps: 3,
        );

        expect(result, isA<BaseMapTileFallbackChildren>());
        final children = (result as BaseMapTileFallbackChildren).children;
        expect(children.map(_markerOf).toList(), [100, 101, 102, 103]);
      },
    );

    test(
      'does not use a partial set of 3 children as a children-fallback',
      () {
        final cache = BaseMapTileCache(maxEntries: 10);
        const tileId = CanonicalTileId(z: 5, x: 2, y: 2);
        final childIds = tileId.children();
        for (var i = 0; i < 3; i++) {
          cache.put(
            sourceInstanceId: 'a',
            tileId: childIds[i],
            geometry: _geometry(100 + i),
            token: cache.beginDecode(),
          );
        }

        final result = cache.lookupWithFallback(
          sourceInstanceId: 'a',
          tileId: tileId,
          maxParentSteps: 3,
        );

        expect(result, isA<BaseMapTileFallbackMiss>());
      },
    );

    test('falls back to the nearest cached ancestor within maxParentSteps', () {
      final cache = BaseMapTileCache(maxEntries: 10);
      const tileId = CanonicalTileId(z: 5, x: 4, y: 4);
      // z=3の祖先だけをcacheする(z=4の親はcacheしない)。
      final grandparentId = tileId.scaledTo(3);
      cache.put(
        sourceInstanceId: 'a',
        tileId: grandparentId,
        geometry: _geometry(42),
        token: cache.beginDecode(),
      );

      final result = cache.lookupWithFallback(
        sourceInstanceId: 'a',
        tileId: tileId,
        maxParentSteps: 3,
      );

      expect(result, isA<BaseMapTileFallbackParent>());
      final parent = result as BaseMapTileFallbackParent;
      expect(_markerOf(parent.geometry), 42);
      expect(parent.tileId, grandparentId);
      expect(parent.stepsUp, 2);
    });

    test('gives up once maxParentSteps is exceeded', () {
      final cache = BaseMapTileCache(maxEntries: 10);
      const tileId = CanonicalTileId(z: 5, x: 4, y: 4);
      final grandparentId = tileId.scaledTo(3);
      cache.put(
        sourceInstanceId: 'a',
        tileId: grandparentId,
        geometry: _geometry(42),
        token: cache.beginDecode(),
      );

      final result = cache.lookupWithFallback(
        sourceInstanceId: 'a',
        tileId: tileId,
        maxParentSteps: 1,
      );

      expect(result, isA<BaseMapTileFallbackMiss>());
    });

    test(
      'prefers the 4 children over an available parent (children→parent '
      'order, not parent→children)',
      () {
        final cache = BaseMapTileCache(maxEntries: 10);
        const tileId = CanonicalTileId(z: 5, x: 2, y: 2);
        final childIds = tileId.children();
        for (var i = 0; i < childIds.length; i++) {
          cache.put(
            sourceInstanceId: 'a',
            tileId: childIds[i],
            geometry: _geometry(100 + i),
            token: cache.beginDecode(),
          );
        }
        final parentId = tileId.scaledTo(4);
        cache.put(
          sourceInstanceId: 'a',
          tileId: parentId,
          geometry: _geometry(999),
          token: cache.beginDecode(),
        );

        final result = cache.lookupWithFallback(
          sourceInstanceId: 'a',
          tileId: tileId,
          maxParentSteps: 3,
        );

        expect(
          result,
          isA<BaseMapTileFallbackChildren>(),
          reason:
              'children must be preferred over a parent when both are '
              'available',
        );
      },
    );

    test('returns a miss when nothing is cached', () {
      final cache = BaseMapTileCache(maxEntries: 10);
      final result = cache.lookupWithFallback(
        sourceInstanceId: 'a',
        tileId: const CanonicalTileId(z: 5, x: 2, y: 2),
        maxParentSteps: 3,
      );

      expect(result, isA<BaseMapTileFallbackMiss>());
    });
  });
}
