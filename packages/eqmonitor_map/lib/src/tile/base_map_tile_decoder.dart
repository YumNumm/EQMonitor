import 'dart:isolate';
import 'dart:ui';

import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh_builder.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/tile/earthquake_area_tile_geometry.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_limits.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decoder.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_tile.dart';
import 'package:eqmonitor_map/src/tile/mvt/polygon_boundary_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_map_tile_decoder.freezed.dart';

/// [BaseMapLayerSpec]がFill/Lineのどちらとしてtileを解釈するかを表す。
///
/// [background]はMVT layerを持たないtheme背景色であり、`docs/map_spec_v3.md`
/// の描画順表に載る最下段(`background`)の位置だけを保持するために
/// [baseMapLayerSpecs]へ含める。tile decodeの対象ではない
/// ([BaseMapTileDecoder.decode]は`sourceLayerName == null`のspecを読み飛ばす)。
enum BaseMapLayerKind { background, fill, line }

/// `docs/map_spec_v3.md`「ベースレイヤー構成 (下から上の順)」表の1行。
///
/// [styleLayerId]と[sourceLayerName]は同表の「ID (`BaseLayer`)」列と
/// 「ソースレイヤー」列をそのまま転記したもの。同じ[sourceLayerName]
/// (`countries`、`areaForecastLocalE`)がFillとLineの2つの[styleLayerId]から
/// 参照される行があるのは、同表がそう定義しているため
/// (地図としては同じpolygon地物を塗りと境界線の両方で描く)。
@immutable
class BaseMapLayerSpec {
  const new({
    required this.styleLayerId,
    required this.kind,
    required this.color,
    this.sourceLayerName,
  }) : assert(
         kind == BaseMapLayerKind.background
             ? sourceLayerName == null
             : sourceLayerName != null,
         'sourceLayerName must be null for background and non-null '
         'otherwise.',
       );

  /// `docs/map_spec_v3.md`の「ID (`BaseLayer`)」列。
  final String styleLayerId;

  final BaseMapLayerKind kind;

  /// `docs/map_spec_v3.md`の「ソースレイヤー」列。MVT内の`MvtLayer.name`と
  /// 大文字・小文字を含め完全一致で比較する(同docの
  /// 「同梱PMTilesのメタデータには...同じ大文字・小文字で含まれていなければ
  /// ならない」)。[BaseMapLayerKind.background]のみ`null`。
  final String? sourceLayerName;

  /// この縦切りで使う仮の固定色。`docs/map_spec_v3.md`の「カラーテーマ」節が
  /// 定義する`MapColorScheme`(ライト/ダークで切り替わる可変色)はこの
  /// packageが依存しないapp層の概念であり、Task 9の範囲はFill/Line振り分け
  /// の配線であって配色の実装ではないため、判読しやすいよう役割ごとに
  /// 別の色を仮で割り当てているだけの値である(値そのものの出所は
  /// `MapColorScheme`ではない)。実配色への置き換えは本テーブルの利用側
  /// (デバッグページ)の責務とする。
  final Color color;
}

/// `docs/map_spec_v3.md`「ベースレイヤー構成 (下から上の順)」表と同じ順序・
/// 同じlayer名で構成したtable。[BaseMapTileDecoder]はこの順序どおりに
/// [BaseMapTileGeometry.layers]を組み立てる。
const baseMapLayerSpecs = <BaseMapLayerSpec>[
  BaseMapLayerSpec(
    styleLayerId: 'background',
    kind: BaseMapLayerKind.background,
    color: Color(0xFFF5F5F0),
  ),
  BaseMapLayerSpec(
    styleLayerId: 'countriesFill',
    kind: BaseMapLayerKind.fill,
    sourceLayerName: 'countries',
    color: Color(0xFFDCD6C9),
  ),
  BaseMapLayerSpec(
    styleLayerId: 'countriesLine',
    kind: BaseMapLayerKind.line,
    sourceLayerName: 'countries',
    color: Color(0xFF9E9E8A),
  ),
  BaseMapLayerSpec(
    styleLayerId: 'areaForecastLocalEFill',
    kind: BaseMapLayerKind.fill,
    sourceLayerName: 'areaForecastLocalE',
    color: Color(0xFFE8E4D8),
  ),
  BaseMapLayerSpec(
    styleLayerId: 'areaForecastLocalEewLine',
    kind: BaseMapLayerKind.line,
    sourceLayerName: 'areaForecastLocalEew',
    color: Color(0xFFFF7043),
  ),
  BaseMapLayerSpec(
    styleLayerId: 'areaForecastLocalELine',
    kind: BaseMapLayerKind.line,
    sourceLayerName: 'areaForecastLocalE',
    color: Color(0xFFB0AA95),
  ),
  BaseMapLayerSpec(
    styleLayerId: 'areaInformationCityQuakeLine',
    kind: BaseMapLayerKind.line,
    sourceLayerName: 'areaInformationCityQuake',
    color: Color(0xFF8D8D75),
  ),
];

/// [BaseMapTileDecoder.decode]の結果。1つの[BaseMapLayerSpec](`kind`が
/// [BaseMapLayerKind.background]を除く)につき1件、[baseMapLayerSpecs]と同じ
/// 順序で並ぶ。対応するMVT layerがtileに存在しない場合(sparse、または
/// `areaInformationCityQuake`のz6未満のようにminzoom未満)は、そのspecの
/// meshが空リストになるだけで、エントリ自体は欠落しない(呼び出し側が
/// 順序に依存したzipを書けるようにするため)。
///
/// frame/tileごとに毎回生成するdecode結果であり永続化しないため、
/// `MvtTile`/`FillMesh`/`LineMesh`と同じ理由でFreezedにはしない。
@immutable
sealed class BaseMapTileLayerGeometry {
  const new({
    required this.styleLayerId,
    required this.extent,
  });

  final String styleLayerId;

  /// 対応するMVT source layerが存在する場合に、そのlayerが宣言したextent。
  ///
  /// `null`はsparse tileでsource layer自体が欠損している場合のみを表す。
  final int? extent;
}

final class BaseMapTileFillLayerGeometry extends BaseMapTileLayerGeometry {
  const new({
    required super.styleLayerId,
    required super.extent,
    required this.meshes,
  });

  final List<FillMesh> meshes;
}

final class BaseMapTileLineLayerGeometry extends BaseMapTileLayerGeometry {
  const new({
    required super.styleLayerId,
    required super.extent,
    required this.meshes,
  });

  final List<LineMesh> meshes;
}

@immutable
class BaseMapTileGeometry {
  const new({
    required this.layers,
    this.earthquakeAreas = const EarthquakeAreaTileGeometry.empty(),
  });

  /// [baseMapLayerSpecs]から[BaseMapLayerKind.background]を除いた行と
  /// 同じ順序・同じ件数。
  final List<BaseMapTileLayerGeometry> layers;

  /// 地震情報のcodeに対応する予報区・市区町村のFill geometry。
  final EarthquakeAreaTileGeometry earthquakeAreas;
}

/// [BaseMapTileDecoder.decode]が使う上限値一式。呼び出し側が明示し、
/// decoder内部に固定fallbackは置かない(`MvtDecodeLimits`と同じ運用方針)。
@freezed
abstract class BaseMapTileDecodeLimits with _$BaseMapTileDecodeLimits {
  const factory({
    required MvtDecodeLimits mvtLimits,
    required FillMeshBuilderLimits fillLimits,
    required LineMeshBuilderLimits lineLimits,
    required double lineMiterLimit,
  }) = _BaseMapTileDecodeLimits;
}

/// tile bytesをMVT decode→[baseMapLayerSpecs]に基づくFill/Line meshへ
/// 変換する。
///
/// # isolate機構の選択
///
/// [decode]は`Isolate.run`でUI isolate外に処理を追い出す。`compute`
/// (`package:flutter/foundation.dart`)ではなくdart:isolateの`Isolate.run`を
/// 直接使うのは、`compute`が要求する「top-level/static関数」という制約が
/// なく、`limits`のような複数引数をrecordへ包まずclosureでそのまま渡せる
/// ためだけの理由であり、性能上の差はない(Flutter 3.3以降の`compute`は
/// 内部で`Isolate.run`相当の使い捨てisolateを使っており、両者のisolate
/// 起動コストは同じ)。
///
/// `TransferableTypedData`は使わない。理由は実測値:
/// `test/tile/mvt/fixtures/earthquake_tsunami_all_z6_x59_y27.mvt`
/// (547 byte、4 layer×1 featureの最小構成)のdecode+mesh構築は約34µs、出力
/// payloadは350 byte。実データを持たないため、8000頂点の円近似polygon
/// 1 featureを合成して負荷を上げた計測でも、tile bytes 16,036 byte→
/// decode+mesh構築 約2.6ms、出力payload 111,988 byte(positions+indices)
/// という規模に留まる(計測はTask 9のreportに記載、コミットはしていない
/// 一時benchmarkによる)。`SendPort`経由のTypedDataコピーはメモリ帯域
/// (GB/s桁)で行われるため、この程度のpayload(高々数百KB)のcopyは
/// 計測誤差の範囲(1ms未満)に収まり、`TransferableTypedData`が節約できる
/// コピー時間よりゾーンコピー自体の分岐・APIの複雑さの方が上回る。
/// 根拠なく重い機構を入れない(Global Constraints)ため採用しない。
final class BaseMapTileDecoder {
  const new();

  Future<BaseMapTileGeometry> decode({
    required Uint8List tileBytes,
    required BaseMapTileDecodeLimits limits,
  }) {
    return Isolate.run(() => decodeBaseMapTileSync(tileBytes, limits));
  }
}

/// [BaseMapTileDecoder.decode]がisolate上で呼ぶ同期本体。isolate間で
/// closureとして送るため、`this`を捕捉しないtop-level関数にしている。
@visibleForTesting
BaseMapTileGeometry decodeBaseMapTileSync(
  Uint8List tileBytes,
  BaseMapTileDecodeLimits limits,
) {
  final tile = decodeMvtTile(tileBytes, limits: limits.mvtLimits);
  final fillBuilder = FillMeshBuilder(limits: limits.fillLimits);
  final lineBuilder = LineMeshBuilder(
    limits: limits.lineLimits,
    miterLimit: limits.lineMiterLimit,
  );

  final layers = <BaseMapTileLayerGeometry>[];
  for (final spec in baseMapLayerSpecs) {
    switch (spec.kind) {
      case BaseMapLayerKind.background:
        continue;
      case BaseMapLayerKind.fill:
        final sourceLayerName = spec.sourceLayerName;
        if (sourceLayerName == null) {
          throw StateError('${spec.styleLayerId} has no source layer.');
        }
        final sourceLayer = _findLayer(tile, sourceLayerName);
        layers.add(
          BaseMapTileFillLayerGeometry(
            styleLayerId: spec.styleLayerId,
            extent: sourceLayer?.extent,
            meshes: _buildFillMeshes(
              layer: sourceLayer,
              builder: fillBuilder,
            ),
          ),
        );
      case BaseMapLayerKind.line:
        final sourceLayerName = spec.sourceLayerName;
        if (sourceLayerName == null) {
          throw StateError('${spec.styleLayerId} has no source layer.');
        }
        final sourceLayer = _findLayer(tile, sourceLayerName);
        layers.add(
          BaseMapTileLineLayerGeometry(
            styleLayerId: spec.styleLayerId,
            extent: sourceLayer?.extent,
            meshes: _buildLineMeshes(
              layer: sourceLayer,
              builder: lineBuilder,
            ),
          ),
        );
    }
  }
  return BaseMapTileGeometry(
    layers: List.unmodifiable(layers),
    earthquakeAreas: EarthquakeAreaTileGeometry(
      forecastRegions: _buildEarthquakeAreaLayerGeometry(
        layer: _findLayer(tile, 'areaForecastLocalE'),
        codePropertyName: 'code',
        builder: fillBuilder,
      ),
      cities: _buildEarthquakeAreaLayerGeometry(
        layer: _findLayer(tile, 'areaInformationCityQuake'),
        codePropertyName: 'regioncode',
        builder: fillBuilder,
      ),
    ),
  );
}

EarthquakeAreaTileLayerGeometry _buildEarthquakeAreaLayerGeometry({
  required MvtLayer? layer,
  required String codePropertyName,
  required FillMeshBuilder builder,
}) {
  if (layer == null) {
    return const EarthquakeAreaTileLayerGeometry(extent: null, features: []);
  }

  final meshesByCode = <String, List<FillMesh>>{};
  var missingOrInvalidCodeCount = 0;
  for (final feature in layer.features) {
    if (feature.type != MvtGeometryType.polygon) {
      continue;
    }
    final code = feature.properties[codePropertyName];
    if (code == null || code.trim().isEmpty) {
      missingOrInvalidCodeCount++;
      continue;
    }
    meshesByCode.putIfAbsent(code, () => []).addAll(builder.build([feature]));
  }

  return EarthquakeAreaTileLayerGeometry(
    extent: layer.extent,
    missingOrInvalidCodeCount: missingOrInvalidCodeCount,
    features: List.unmodifiable([
      for (final MapEntry(:key, :value) in meshesByCode.entries)
        CodedFillGeometry(code: key, meshes: List.unmodifiable(value)),
    ]),
  );
}

MvtLayer? _findLayer(MvtTile tile, String name) {
  for (final layer in tile.layers) {
    if (layer.name == name) {
      return layer;
    }
  }
  return null;
}

List<FillMesh> _buildFillMeshes({
  required MvtLayer? layer,
  required FillMeshBuilder builder,
}) {
  if (layer == null) {
    // sparse archiveの欠損、または`areaInformationCityQuake`のz6未満のように
    // このzoomにそのsource layerが存在しない場合。空meshで表現し、
    // エラーにはしない(`docs/map_spec_v3.md`「タイル側のズーム制約」節)。
    return const [];
  }
  final polygonFeatures = layer.features.where(
    (feature) => feature.type == MvtGeometryType.polygon,
  );
  if (polygonFeatures.isEmpty) {
    return const [];
  }
  return builder.build(polygonFeatures);
}

List<LineMesh> _buildLineMeshes({
  required MvtLayer? layer,
  required LineMeshBuilder builder,
}) {
  if (layer == null) {
    return const [];
  }
  final lineFeatures = <MvtFeature?>[
    for (final feature in layer.features)
      switch (feature.type) {
        // LineStringはそのまま使う(`areaForecastLocalEew`/
        // `areaInformationCityQuake`のように、そもそも境界線として
        // 生成されたsource layer)。
        MvtGeometryType.lineString => feature,
        // Polygonは各ringを閉じたline pathへ変換して使う。`countries`/
        // `areaForecastLocalE`はFillとLineの両方から参照される同じ
        // polygon地物であり(`baseMapLayerSpecs`参照)、その境界線は
        // polygonの外形・穴ringそのものを線として描く(MapLibre GLの
        // line rendererがPolygon地物をline layerでも描画できるのと同じ
        // 挙動)。
        MvtGeometryType.polygon => const PolygonBoundaryBuilder().build(
          feature: feature,
        ),
        // Pointは線として描けないため読み飛ばす。
        MvtGeometryType.point => null,
      },
  ].whereType<MvtFeature>().toList(growable: false);
  if (lineFeatures.isEmpty) {
    return const [];
  }
  return builder.build(lineFeatures);
}
