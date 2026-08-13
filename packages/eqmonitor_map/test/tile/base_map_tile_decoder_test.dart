// Fixture(実tileの.mvt)はここでは使わない。
// `test/tile/mvt/fixtures/*.mvt`は`utils/map_converter/data/pmtiles/
// earthquake_tsunami_all.pmtiles`(layer名: AreaForecastLocalE/
// AreaForecastLocalEEW/AreaInformationCity_quake/AreaTsunami)から抽出した
// もので、`docs/map_spec_v3.md`が定義する本番ベースマップのsource layer名
// (countries/areaForecastLocalE/areaForecastLocalEew/
// areaInformationCityQuake、大文字小文字も異なる)とは別系統のdatasetである
// (このdocの「同梱PMTilesのメタデータには...同じ大文字・小文字で含まれて
// いなければならない」という前提を満たさない)。そのため本ファイルでは
// `../mvt/support/mvt_fixture_builder.dart`(Task 3のtestが使うMVT protobuf
// builder)で`baseMapLayerSpecs`のsource layer名どおりの合成tileを組み立て、
// layer名の取り違えを避ける。
import 'dart:typed_data';

import 'package:eqmonitor_map/src/mesh/fill_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_limits.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mvt/support/mvt_fixture_builder.dart';

const _builder = MvtFixtureBuilder();

const _limits = BaseMapTileDecodeLimits(
  mvtLimits: MvtDecodeLimits(
    maxLayers: 16,
    maxFeaturesPerLayer: 64,
    maxRingsPerFeature: 16,
    maxVerticesPerRing: 256,
    maxCommandsPerFeature: 1024,
    maxLayerNameBytes: 64,
  ),
  fillLimits: FillMeshBuilderLimits(
    maxHolesPerPolygon: 16,
    maxVerticesPerFeature: 4096,
    maxVerticesPerSegment: 65536,
  ),
  lineLimits: LineMeshBuilderLimits(maxVerticesPerSegment: 65536),
  lineMiterLimit: 4,
);

/// (0,0)→(10,0)→(0,10)の直角三角形。shoelace公式の符号付き面積2倍は
/// `0*0-10*0 + 10*10-0*0 + 0*0-0*10 = 100 > 0`であり、
/// `FillMeshBuilder._signedAreaTwice`の規約(正なら外形)どおり外形になる。
Uint8List _buildFeatureTriangle() {
  return _builder.buildFeature(
    geomType: MvtFixtureBuilder.geomTypePolygon,
    rawCommands: [
      ..._builder.moveTo([(0, 0)]),
      ..._builder.lineTo([(10, 0), (-10, 10)]),
      ..._builder.closePath(),
    ],
  );
}

/// (0,0)→(20,0)の2点LineString(`ClosePath`を使わない、開いたline)。
Uint8List _buildFeatureOpenLine() {
  return _builder.buildFeature(
    geomType: MvtFixtureBuilder.geomTypeLineString,
    rawCommands: [
      ..._builder.moveTo([(0, 0)]),
      ..._builder.lineTo([(20, 0)]),
    ],
  );
}

void main() {
  group('baseMapLayerSpecs', () {
    test(
      'matches the draw order and layer names from docs/map_spec_v3.md',
      () {
        expect(
          baseMapLayerSpecs
              .map(
                (spec) => (spec.styleLayerId, spec.kind, spec.sourceLayerName),
              )
              .toList(),
          [
            ('background', BaseMapLayerKind.background, null),
            ('countriesFill', BaseMapLayerKind.fill, 'countries'),
            ('countriesLine', BaseMapLayerKind.line, 'countries'),
            (
              'areaForecastLocalEFill',
              BaseMapLayerKind.fill,
              'areaForecastLocalE',
            ),
            (
              'areaForecastLocalEewLine',
              BaseMapLayerKind.line,
              'areaForecastLocalEew',
            ),
            (
              'areaForecastLocalELine',
              BaseMapLayerKind.line,
              'areaForecastLocalE',
            ),
            (
              'areaInformationCityQuakeLine',
              BaseMapLayerKind.line,
              'areaInformationCityQuake',
            ),
          ],
        );
      },
    );
  });

  group('decodeBaseMapTileSync', () {
    test('preserves each source layer extent on every derived style layer', () {
      final tile = _builder.buildTile(
        layers: [
          _builder.buildLayer(
            name: 'countries',
            extent: 2048,
            features: [_buildFeatureTriangle()],
          ),
          _builder.buildLayer(
            name: 'areaForecastLocalE',
            extent: 8192,
            features: [_buildFeatureTriangle()],
          ),
        ],
      );

      final geometry = decodeBaseMapTileSync(tile, _limits);
      final extents = {
        for (final layer in geometry.layers) layer.styleLayerId: layer.extent,
      };

      expect(extents, {
        'countriesFill': 2048,
        'countriesLine': 2048,
        'areaForecastLocalEFill': 8192,
        'areaForecastLocalEewLine': null,
        'areaForecastLocalELine': 8192,
        'areaInformationCityQuakeLine': null,
      });
    });

    test('produces one entry per non-background spec, in spec order', () {
      final tile = _builder.buildTile(
        layers: [
          _builder.buildLayer(
            name: 'countries',
            features: [_buildFeatureTriangle()],
          ),
          _builder.buildLayer(
            name: 'areaForecastLocalEew',
            features: [_buildFeatureOpenLine()],
          ),
          // areaForecastLocalE / areaInformationCityQuakeは意図的に含めない
          // (sparse archiveの欠損、またはareaInformationCityQuakeのz6未満
          // 相当を模す)。
        ],
      );

      final geometry = decodeBaseMapTileSync(tile, _limits);

      expect(geometry.layers.map((l) => l.styleLayerId).toList(), [
        'countriesFill',
        'countriesLine',
        'areaForecastLocalEFill',
        'areaForecastLocalEewLine',
        'areaForecastLocalELine',
        'areaInformationCityQuakeLine',
      ]);
    });

    test('Fill picks the polygon feature and keeps its coordinates as-is', () {
      final tile = _builder.buildTile(
        layers: [
          _builder.buildLayer(
            name: 'countries',
            features: [_buildFeatureTriangle()],
          ),
        ],
      );

      final geometry = decodeBaseMapTileSync(tile, _limits);
      final fill =
          geometry.layers.singleWhere(
                (l) => l.styleLayerId == 'countriesFill',
              )
              as BaseMapTileFillLayerGeometry;

      expect(fill.meshes, hasLength(1));
      final mesh = fill.meshes.single;
      expect(mesh.vertexCount, 3);
      expect(mesh.positions, Float32List.fromList([0, 0, 10, 0, 0, 10]));
      // 三角形1枚なので、3個のindexは0,1,2の並び替えのはず(どの並びに
      // triangulateされてもこの3点だけの三角形しか作りようがない)。
      expect(mesh.indices.toSet(), {0, 1, 2});
      expect(mesh.indices, hasLength(3));
    });

    test(
      'Line closes the polygon ring so the boundary forms a closed loop',
      () {
        final tile = _builder.buildTile(
          layers: [
            _builder.buildLayer(
              name: 'countries',
              features: [_buildFeatureTriangle()],
            ),
          ],
        );

        final geometry = decodeBaseMapTileSync(tile, _limits);
        final line =
            geometry.layers.singleWhere(
                  (l) => l.styleLayerId == 'countriesLine',
                )
                as BaseMapTileLineLayerGeometry;

        expect(line.meshes, hasLength(1));
        final mesh = line.meshes.single;
        // 3点のringが閉路として扱われれば3segment(closed loop)になり、
        // 頂点は plus/minus の2倍で6、indexは segment毎6個×3=18になる。
        // ringが閉じられず開いたlineとして解釈された場合は2segmentにしか
        // ならず、頂点4・index12になるため、この2値の違いがclose処理の
        // 有無を検出する。
        expect(mesh.vertexCount, 6);
        expect(mesh.indices, hasLength(18));
      },
    );

    test(
      'Line uses a LineString feature as-is without closing it',
      () {
        final tile = _builder.buildTile(
          layers: [
            _builder.buildLayer(
              name: 'areaForecastLocalEew',
              features: [_buildFeatureOpenLine()],
            ),
          ],
        );

        final geometry = decodeBaseMapTileSync(tile, _limits);
        final line =
            geometry.layers.singleWhere(
                  (l) => l.styleLayerId == 'areaForecastLocalEewLine',
                )
                as BaseMapTileLineLayerGeometry;

        expect(line.meshes, hasLength(1));
        final mesh = line.meshes.single;
        // 2点の開いたlineは1segmentのみ(頂点4、index6)。3点閉路のケースと
        // 数値が異なることで、closing処理を誤って全typeへ適用していないか
        // (LineStringにまで閉路化を適用していないか)を検出する。
        expect(mesh.vertexCount, 4);
        expect(mesh.indices, hasLength(6));
      },
    );

    test('missing source layer yields an empty mesh list, not an error', () {
      final tile = _builder.buildTile(layers: []);

      final geometry = decodeBaseMapTileSync(tile, _limits);

      for (final layer in geometry.layers) {
        expect(
          switch (layer) {
            BaseMapTileFillLayerGeometry(:final meshes) => meshes,
            BaseMapTileLineLayerGeometry(:final meshes) => meshes,
          },
          isEmpty,
          reason: '${layer.styleLayerId} should be empty, not throw',
        );
      }
    });

    test(
      'Fill ignores a LineString feature sharing the same source layer as '
      'the polygon',
      () {
        final tile = _builder.buildTile(
          layers: [
            _builder.buildLayer(
              name: 'countries',
              features: [_buildFeatureTriangle(), _buildFeatureOpenLine()],
            ),
          ],
        );

        final geometry = decodeBaseMapTileSync(tile, _limits);
        final fill =
            geometry.layers.singleWhere(
                  (l) => l.styleLayerId == 'countriesFill',
                )
                as BaseMapTileFillLayerGeometry;
        final line =
            geometry.layers.singleWhere(
                  (l) => l.styleLayerId == 'countriesLine',
                )
                as BaseMapTileLineLayerGeometry;

        // FillはPolygon featureだけを見るので、三角形1枚ぶんの頂点(3)のまま。
        expect(fill.meshes.single.vertexCount, 3);
        // Lineは変換済みpolygon(closed loop、頂点6)とLineStringそのまま
        // (頂点4)の両方を1つのsegmentへまとめるので、合計10頂点になる。
        expect(line.meshes.single.vertexCount, 10);
      },
    );
  });

  group('BaseMapTileDecoder.decode', () {
    test('the Isolate.run wrapper matches the sync core', () async {
      final tile = _builder.buildTile(
        layers: [
          _builder.buildLayer(
            name: 'countries',
            features: [_buildFeatureTriangle()],
          ),
        ],
      );

      const decoder = BaseMapTileDecoder();
      final geometry = await decoder.decode(tileBytes: tile, limits: _limits);
      final fill =
          geometry.layers.singleWhere(
                (l) => l.styleLayerId == 'countriesFill',
              )
              as BaseMapTileFillLayerGeometry;

      expect(fill.meshes.single.vertexCount, 3);
    });
  });
}
