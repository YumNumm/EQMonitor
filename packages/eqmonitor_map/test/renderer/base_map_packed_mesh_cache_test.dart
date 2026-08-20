import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh_cache.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:flutter_test/flutter_test.dart';

/// 先頭頂点のxへ[marker]を入れた三角形1枚。cacheがどのmeshを返したかを
/// marker値で判定できるようにしている(packerはindexが頂点範囲に収まる
/// 非空のtriangle listしか受け付けないため、頂点3個の実三角形にしている)。
FillMesh _fillMesh(double marker) => FillMesh(
  positions: Float32List.fromList([marker, 0, marker + 1, 0, marker, 1]),
  indices: Uint16List.fromList([0, 1, 2]),
  vertexCount: 3,
);

LineMesh _lineMesh(double marker) => LineMesh(
  positions: Float32List.fromList([marker, 0, marker + 1, 0, marker, 1]),
  extrudes: Float32List.fromList([0, 1, 0, 1, 0, 1]),
  indices: Uint16List.fromList([0, 1, 2]),
  vertexCount: 3,
);

/// fill 1 layer(marker付きmesh [markers]件)だけを持つtile geometry。
BaseMapTileGeometry _fillGeometry(List<double> markers) => BaseMapTileGeometry(
  layers: [
    BaseMapTileFillLayerGeometry(
      styleLayerId: 'countriesFill',
      extent: 4096,
      meshes: [for (final marker in markers) _fillMesh(marker)],
    ),
  ],
);

/// packed meshの先頭頂点のx。fill(stride 8)/line(stride 16)いずれも
/// offset 0がpositionのxであるためどちらでも読める。
double _markerOf(MapPackedMesh mesh) =>
    ByteData.sublistView(mesh.vertexBytes).getFloat32(0, Endian.little);

void main() {
  const tileId = CanonicalTileId(z: 5, x: 3, y: 4);

  group('construction', () {
    test('maxEntries must be positive', () {
      expect(
        () => BaseMapPackedMeshCache(maxEntries: 0),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => BaseMapPackedMeshCache(maxEntries: -1),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('a fresh cache holds no entries', () {
      expect(BaseMapPackedMeshCache(maxEntries: 4).length, 0);
    });
  });

  group('identity stability', () {
    test(
      'the same sourceInstanceId+tileId keeps returning identical '
      'MapPackedMesh instances',
      () {
        final cache = BaseMapPackedMeshCache(maxEntries: 4);
        final geometry = _fillGeometry([1, 2]);

        final first = cache.getOrBuild(
          sourceInstanceId: 'a',
          tileId: tileId,
          geometry: geometry,
        );
        final second = cache.getOrBuild(
          sourceInstanceId: 'a',
          tileId: tileId,
          geometry: geometry,
        );

        expect(cache.length, 1);
        expect(second['countriesFill']!.length, 2);
        expect(second['countriesFill']![0], same(first['countriesFill']![0]));
        expect(second['countriesFill']![1], same(first['countriesFill']![1]));
      },
    );

    test('a hit does not re-pack even when a newer geometry is passed', () {
      final cache = BaseMapPackedMeshCache(maxEntries: 4);
      final first = cache.getOrBuild(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: _fillGeometry([1]),
      );
      final second = cache.getOrBuild(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: _fillGeometry([99]),
      );

      expect(
        second['countriesFill']!.single,
        same(first['countriesFill']!.single),
      );
      expect(_markerOf(second['countriesFill']!.single), 1);
    });
  });

  group('layer contents', () {
    test('every mesh segment becomes one packed mesh in the source order', () {
      final cache = BaseMapPackedMeshCache(maxEntries: 4);

      final packed = cache.getOrBuild(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: _fillGeometry([10, 20, 30]),
      );

      expect(packed['countriesFill']!.map(_markerOf), [10, 20, 30]);
    });

    test('fill layers use the fill layout and line layers the line layout', () {
      final cache = BaseMapPackedMeshCache(maxEntries: 4);

      final packed = cache.getOrBuild(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: BaseMapTileGeometry(
          layers: [
            BaseMapTileFillLayerGeometry(
              styleLayerId: 'countriesFill',
              extent: 4096,
              meshes: [_fillMesh(1)],
            ),
            BaseMapTileLineLayerGeometry(
              styleLayerId: 'countriesLine',
              extent: 4096,
              meshes: [_lineMesh(2)],
            ),
          ],
        ),
      );

      expect(packed.keys, ['countriesFill', 'countriesLine']);
      expect(
        packed['countriesFill']!.single.layout,
        same(baseMapFillPackedMeshLayout),
      );
      expect(
        packed['countriesLine']!.single.layout,
        same(baseMapLinePackedMeshLayout),
      );
    });

    test(
      'a layer without meshes keeps its styleLayerId with an empty list',
      () {
        final cache = BaseMapPackedMeshCache(maxEntries: 4);

        final packed = cache.getOrBuild(
          sourceInstanceId: 'a',
          tileId: tileId,
          geometry: const BaseMapTileGeometry(
            layers: [
              BaseMapTileFillLayerGeometry(
                styleLayerId: 'countriesFill',
                extent: null,
                meshes: [],
              ),
              BaseMapTileLineLayerGeometry(
                styleLayerId: 'countriesLine',
                extent: null,
                meshes: [],
              ),
            ],
          ),
        );

        expect(packed.keys, ['countriesFill', 'countriesLine']);
        expect(packed['countriesFill'], isEmpty);
        expect(packed['countriesLine'], isEmpty);
      },
    );

    test('a tile whose layers are all empty is still a cached entry', () {
      final cache = BaseMapPackedMeshCache(maxEntries: 4);
      const geometry = BaseMapTileGeometry(
        layers: [
          BaseMapTileFillLayerGeometry(
            styleLayerId: 'countriesFill',
            extent: null,
            meshes: [],
          ),
        ],
      );

      final first = cache.getOrBuild(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: geometry,
      );
      final second = cache.getOrBuild(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: geometry,
      );

      expect(cache.length, 1);
      expect(second, same(first));
    });
  });

  group('cache key', () {
    test('a different sourceInstanceId is a different entry', () {
      final cache = BaseMapPackedMeshCache(maxEntries: 4);

      final fromA = cache.getOrBuild(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: _fillGeometry([1]),
      );
      final fromB = cache.getOrBuild(
        sourceInstanceId: 'b',
        tileId: tileId,
        geometry: _fillGeometry([2]),
      );

      expect(cache.length, 2);
      expect(
        fromB['countriesFill']!.single,
        isNot(same(fromA['countriesFill']!.single)),
      );
      expect(_markerOf(fromA['countriesFill']!.single), 1);
      expect(_markerOf(fromB['countriesFill']!.single), 2);
    });

    test('a different tileId is a different entry', () {
      final cache = BaseMapPackedMeshCache(maxEntries: 4);

      cache.getOrBuild(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: _fillGeometry([1]),
      );
      final other = cache.getOrBuild(
        sourceInstanceId: 'a',
        tileId: const CanonicalTileId(z: 6, x: 3, y: 4),
        geometry: _fillGeometry([2]),
      );

      expect(cache.length, 2);
      expect(_markerOf(other['countriesFill']!.single), 2);
    });
  });

  group('eviction', () {
    test('entries beyond maxEntries are dropped', () {
      final cache = BaseMapPackedMeshCache(maxEntries: 2);

      for (var x = 0; x < 5; x++) {
        cache.getOrBuild(
          sourceInstanceId: 'a',
          tileId: CanonicalTileId(z: 5, x: x, y: 0),
          geometry: _fillGeometry([x.toDouble()]),
        );
      }

      expect(cache.length, 2);
    });

    test(
      'a re-requested entry survives: the least recently used one is evicted, '
      'not the oldest inserted one',
      () {
        final cache = BaseMapPackedMeshCache(maxEntries: 2);
        const oldest = CanonicalTileId(z: 5, x: 0, y: 0);
        const middle = CanonicalTileId(z: 5, x: 1, y: 0);
        const newest = CanonicalTileId(z: 5, x: 2, y: 0);

        final oldestFirst = cache.getOrBuild(
          sourceInstanceId: 'a',
          tileId: oldest,
          geometry: _fillGeometry([0]),
        );
        final middleFirst = cache.getOrBuild(
          sourceInstanceId: 'a',
          tileId: middle,
          geometry: _fillGeometry([1]),
        );
        // 挿入順で最古のentryを再要求してmost-recently-used側へ移す。
        cache.getOrBuild(
          sourceInstanceId: 'a',
          tileId: oldest,
          geometry: _fillGeometry([0]),
        );
        cache.getOrBuild(
          sourceInstanceId: 'a',
          tileId: newest,
          geometry: _fillGeometry([2]),
        );

        expect(cache.length, 2);
        // 再要求したoldestはinstance identityを保ったまま生き残る。
        expect(
          cache
              .getOrBuild(
                sourceInstanceId: 'a',
                tileId: oldest,
                geometry: _fillGeometry([0]),
              )['countriesFill']!
              .single,
          same(oldestFirst['countriesFill']!.single),
        );
        // 一度も再要求しなかったmiddleが捨てられ、詰め直しになる。
        expect(
          cache
              .getOrBuild(
                sourceInstanceId: 'a',
                tileId: middle,
                geometry: _fillGeometry([1]),
              )['countriesFill']!
              .single,
          isNot(same(middleFirst['countriesFill']!.single)),
        );
      },
    );
  });

  group('clear', () {
    test('clear drops every entry and the next call re-packs', () {
      final cache = BaseMapPackedMeshCache(maxEntries: 4);
      final first = cache.getOrBuild(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: _fillGeometry([1]),
      );

      cache.clear();

      expect(cache.length, 0);
      final second = cache.getOrBuild(
        sourceInstanceId: 'a',
        tileId: tileId,
        geometry: _fillGeometry([1]),
      );
      expect(cache.length, 1);
      expect(
        second['countriesFill']!.single,
        isNot(same(first['countriesFill']!.single)),
      );
    });
  });
}
