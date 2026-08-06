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
      final cache = BaseMapTileCache(maxEntries: 10, maxParentFallbackSteps: 1);
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
      final cache = BaseMapTileCache(maxEntries: 10, maxParentFallbackSteps: 1);
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
        final cache = BaseMapTileCache(
          maxEntries: 10,
          maxParentFallbackSteps: 1,
        );
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
        final cache = BaseMapTileCache(
          maxEntries: 10,
          maxParentFallbackSteps: 1,
        );
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
    test(
      'with maxParentFallbackSteps=1, keeps entries within activeZoom ± 1 '
      'and evicts the rest (the symmetric ±1 special case)',
      () {
        final cache = BaseMapTileCache(
          maxEntries: 100,
          maxParentFallbackSteps: 1,
        );
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
      },
    );

    test(
      'the upper bound stays activeZoom + 1 regardless of '
      'maxParentFallbackSteps (only the lower bound goes deeper)',
      () {
        final cache = BaseMapTileCache(
          maxEntries: 100,
          maxParentFallbackSteps: 4,
        );
        for (final z in [5, 6, 7]) {
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
            tileId: const CanonicalTileId(z: 6, x: 0, y: 0),
          ),
          isNotNull,
          reason: 'z=6 is activeZoom + 1',
        );
        expect(
          cache.get(
            sourceInstanceId: 'a',
            tileId: const CanonicalTileId(z: 7, x: 0, y: 0),
          ),
          isNull,
          reason:
              'z=7 is activeZoom + 2; a large maxParentFallbackSteps must '
              'not loosen the upper bound',
        );
      },
    );

    test(
      'a zoom jump that skips levels (e.g. z4 -> z6, as a pinch can '
      'produce) keeps the ancestor that lookupWithFallback needs, unlike '
      'the old symmetric ±1 window',
      () {
        final cache = BaseMapTileCache(
          maxEntries: 100,
          maxParentFallbackSteps: 4,
        );
        const ancestorId = CanonicalTileId(z: 4, x: 0, y: 0);
        cache.put(
          sourceInstanceId: 'a',
          tileId: ancestorId,
          geometry: _geometry(4),
          token: cache.beginDecode(),
        );

        // ピンチでz4からz6へ一気に動いた想定。z5を経由しない。
        cache.noteActiveZoom(6);

        // z4はactiveZoom(6)から見て2段下だが、maxParentFallbackSteps=4の
        // 範囲内なので生き残っているはず。
        expect(
          cache.get(sourceInstanceId: 'a', tileId: ancestorId),
          isNotNull,
          reason: 'z=4 is within activeZoom(6) - maxParentFallbackSteps(4) = 2',
        );

        final requestedTileId = ancestorId.scaledTo(6);
        final result = cache.lookupWithFallback(
          sourceInstanceId: 'a',
          tileId: requestedTileId,
          maxParentSteps: 4,
        );

        expect(result, isA<BaseMapTileFallbackParent>());
        final parent = result as BaseMapTileFallbackParent;
        expect(_markerOf(parent.geometry), 4);
        expect(parent.tileId, ancestorId);
        expect(parent.stepsUp, 2);
      },
    );

    test(
      'an ancestor beyond maxParentFallbackSteps is still evicted (the '
      'lower bound does not turn into unlimited retention)',
      () {
        final cache = BaseMapTileCache(
          maxEntries: 100,
          maxParentFallbackSteps: 2,
        );
        const tooDeepAncestorId = CanonicalTileId(z: 1, x: 0, y: 0);
        cache.put(
          sourceInstanceId: 'a',
          tileId: tooDeepAncestorId,
          geometry: _geometry(1),
          token: cache.beginDecode(),
        );

        cache.noteActiveZoom(6);

        expect(
          cache.get(sourceInstanceId: 'a', tileId: tooDeepAncestorId),
          isNull,
          reason: 'z=1 is below activeZoom(6) - maxParentFallbackSteps(2) = 4',
        );
      },
    );
  });

  group('eviction (capacity, LRU)', () {
    test('without an intervening get(), evicts in pure insertion order '
        '(baseline contrast for the LRU tests below)', () {
      final cache = BaseMapTileCache(maxEntries: 2, maxParentFallbackSteps: 1);
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

    test(
      'a get() hit protects an entry from eviction even though it was '
      'inserted first (the regression scenario found in review: '
      'maxEntries=3, put A,B -> get A(hit) -> put C,D)',
      () {
        final cache = BaseMapTileCache(
          maxEntries: 3,
          maxParentFallbackSteps: 1,
        );
        const tileA = CanonicalTileId(z: 5, x: 0, y: 0);
        const tileB = CanonicalTileId(z: 5, x: 1, y: 0);
        const tileC = CanonicalTileId(z: 5, x: 2, y: 0);
        const tileD = CanonicalTileId(z: 5, x: 3, y: 0);

        cache
          ..put(
            sourceInstanceId: 'a',
            tileId: tileA,
            geometry: _geometry(1),
            token: cache.beginDecode(),
          )
          ..put(
            sourceInstanceId: 'a',
            tileId: tileB,
            geometry: _geometry(2),
            token: cache.beginDecode(),
          );

        // Aを直近使用にする(1回もgetされていないBより新しく触れる)。
        final hit = cache.get(sourceInstanceId: 'a', tileId: tileA);
        expect(hit, isNotNull);

        cache
          ..put(
            sourceInstanceId: 'a',
            tileId: tileC,
            geometry: _geometry(3),
            token: cache.beginDecode(),
          )
          ..put(
            sourceInstanceId: 'a',
            tileId: tileD,
            geometry: _geometry(4),
            token: cache.beginDecode(),
          );

        // maxEntries=3で4件目(D)を入れたので1件evictされる。get()で
        // recencyが更新されていれば、直近使用したAではなく一度も
        // getされていないBが破棄される。
        expect(
          cache.get(sourceInstanceId: 'a', tileId: tileA),
          isNotNull,
          reason: 'A was touched by get() and must survive',
        );
        expect(
          cache.get(sourceInstanceId: 'a', tileId: tileB),
          isNull,
          reason: 'B was never touched and must be the one evicted',
        );
        expect(cache.get(sourceInstanceId: 'a', tileId: tileC), isNotNull);
        expect(cache.get(sourceInstanceId: 'a', tileId: tileD), isNotNull);
      },
    );

    test(
      'without a get() in between, the same put sequence evicts the '
      'first-inserted entry instead (contrast with the test above)',
      () {
        final cache = BaseMapTileCache(
          maxEntries: 3,
          maxParentFallbackSteps: 1,
        );
        const tileA = CanonicalTileId(z: 5, x: 0, y: 0);
        const tileB = CanonicalTileId(z: 5, x: 1, y: 0);
        const tileC = CanonicalTileId(z: 5, x: 2, y: 0);
        const tileD = CanonicalTileId(z: 5, x: 3, y: 0);

        cache
          ..put(
            sourceInstanceId: 'a',
            tileId: tileA,
            geometry: _geometry(1),
            token: cache.beginDecode(),
          )
          ..put(
            sourceInstanceId: 'a',
            tileId: tileB,
            geometry: _geometry(2),
            token: cache.beginDecode(),
          )
          // ここでAをgetしない(上のtestとの唯一の違い)。
          ..put(
            sourceInstanceId: 'a',
            tileId: tileC,
            geometry: _geometry(3),
            token: cache.beginDecode(),
          )
          ..put(
            sourceInstanceId: 'a',
            tileId: tileD,
            geometry: _geometry(4),
            token: cache.beginDecode(),
          );

        expect(
          cache.get(sourceInstanceId: 'a', tileId: tileA),
          isNull,
          reason: 'without a get() touch, A is the oldest and is evicted',
        );
        expect(cache.get(sourceInstanceId: 'a', tileId: tileB), isNotNull);
        expect(cache.get(sourceInstanceId: 'a', tileId: tileC), isNotNull);
        expect(cache.get(sourceInstanceId: 'a', tileId: tileD), isNotNull);
      },
    );
  });

  group('incarnation token', () {
    test('put is dropped once the token has been cancelled', () {
      final cache = BaseMapTileCache(maxEntries: 10, maxParentFallbackSteps: 1);
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
      final cache = BaseMapTileCache(maxEntries: 10, maxParentFallbackSteps: 1);
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
      final cache = BaseMapTileCache(maxEntries: 10, maxParentFallbackSteps: 1);
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
        final cache = BaseMapTileCache(
          maxEntries: 10,
          maxParentFallbackSteps: 1,
        );
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
        final cache = BaseMapTileCache(
          maxEntries: 10,
          maxParentFallbackSteps: 1,
        );
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
      final cache = BaseMapTileCache(maxEntries: 10, maxParentFallbackSteps: 1);
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
      final cache = BaseMapTileCache(maxEntries: 10, maxParentFallbackSteps: 1);
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
        final cache = BaseMapTileCache(
          maxEntries: 10,
          maxParentFallbackSteps: 1,
        );
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
      final cache = BaseMapTileCache(maxEntries: 10, maxParentFallbackSteps: 1);
      final result = cache.lookupWithFallback(
        sourceInstanceId: 'a',
        tileId: const CanonicalTileId(z: 5, x: 2, y: 2),
        maxParentSteps: 3,
      );

      expect(result, isA<BaseMapTileFallbackMiss>());
    });
  });
}
