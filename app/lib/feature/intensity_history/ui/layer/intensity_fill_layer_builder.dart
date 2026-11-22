import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_expression.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/painting.dart';
import 'package:maplibre/maplibre.dart';

/// 市区町村別最大震度マップの fill/line レイヤーを組み立てる。
///
/// `areaInformationCityQuake` は全ズームのタイルに存在する
/// (`BaseMapTileSpec.cityMinZoom` = 0) ため、ズーム帯で塗る対象を切り替える
/// 必要はなく、市区町村の塗り 1 枚 + 選択中の枠線（ハロー・本線）だけで済む。
///
/// 塗りと輪郭線をメソッドごとに分けているのは、更新契機が全く違うため。
/// 塗りは全国 ~1900 市区町村分の `match` 式を持つので入れ替えが重く、震度
/// データか配色が変わったときだけ作り直したい。輪郭線は style・配色ごとに
/// 1 度だけ追加し、タップでは [selectedCityFilter] で filter だけ差し替える。
///
/// 相対順序は style が持つアンカーで決まる: 塗りは細分区域の境界線の**下**、
/// 選択枠は [BaseLayer.markerBackgroundAnchor] の下に追加する。どちらを先に
/// 追加しても塗りは境界線の下に留まり、選択枠は境界線に埋もれない。
class const IntensityFillLayerBuilder() {
  static const sourceId = 'eqmonitor_map';
  static const citySourceLayerId = 'areaInformationCityQuake';

  /// 市区町村の塗り。
  static const cityFillLayerId = 'intensity-history-city-fill';

  /// 選択中の市区町村の輪郭線。
  static const selectedCityLineLayerId = 'intensity-history-selected-city-line';

  /// 選択枠のコントラスト用ハロー。
  static const selectedCityHaloLayerId = 'intensity-history-selected-city-halo';

  /// [buildFill] が管理するレイヤー ID。
  static const fillLayerIds = [cityFillLayerId];

  /// [buildSelectedCityLine] が管理するレイヤー ID。
  static const selectedCityLineLayerIds = [
    selectedCityHaloLayerId,
    selectedCityLineLayerId,
  ];

  static const cityFillOpacity = 0.8;
  static const selectedCityLineWidth = 2.5;
  static const selectedCityHaloWidth = 6.0;

  /// 市区町村ごとの観測史上最大震度の塗り。
  ///
  /// [cityMaxIntensities] が空なら空リストを返す（塗る対象が無い）。
  List<MapStyleLayerEntry> buildFill({
    required List<CityMaxIntensityEntry> cityMaxIntensities,
    required IntensityColors colorModel,
  }) {
    if (cityMaxIntensities.isEmpty) {
      return const [];
    }

    // areaInformationCityQuake のフィーチャ照合プロパティは `regioncode`。
    // (earthquake_history_fill_layer.dart の cityCodeFilter 参照)
    return [
      belowRegionLine(
        FillStyleLayer(
          id: cityFillLayerId,
          sourceId: sourceId,
          sourceLayerId: citySourceLayerId,
          color: .raw(
            IntensityMatchExpressionBuilder.build(
              cityMaxIntensities
                  .map(
                    (entry) => (
                      code: entry.cityCode,
                      intensity: entry.intensity,
                    ),
                  )
                  .toList(),
              colorModel,
              propertyKey: 'regioncode',
            ),
          ),
          opacity: const .literal(cityFillOpacity),
        ),
      ),
    ];
  }

  /// 選択中の市区町村の輪郭線（ハロー・本線）。
  ///
  /// [selectedCityCode] が null でもレイヤーは返し、filter で非表示にする。
  List<MapStyleLayerEntry> buildSelectedCityLine({
    required String? selectedCityCode,
    required Color lineColor,
    required Color haloColor,
  }) {
    final filter = Expression<bool>.raw(selectedCityFilter(selectedCityCode));

    return [
      belowMarkerBackground(
        LineStyleLayer(
          id: selectedCityHaloLayerId,
          sourceId: sourceId,
          sourceLayerId: citySourceLayerId,
          filter: filter,
          cap: const .literal(.round),
          join: const .literal(.round),
          color: .literal(haloColor),
          width: const .literal(selectedCityHaloWidth),
          opacity: const .literal(0.9),
        ),
      ),
      belowMarkerBackground(
        LineStyleLayer(
          id: selectedCityLineLayerId,
          sourceId: sourceId,
          sourceLayerId: citySourceLayerId,
          filter: filter,
          cap: const .literal(.round),
          join: const .literal(.round),
          color: .literal(lineColor),
          width: const .literal(selectedCityLineWidth),
          opacity: const .literal(1),
        ),
      ),
    ];
  }

  /// 未選択の非表示に `['==', 1, 0]` を使うと iOS で例外になるため、空集合への所属判定にする。
  List<Object> selectedCityFilter(String? selectedCityCode) => [
    'in',
    ['get', 'regioncode'],
    [
      'literal',
      [?selectedCityCode],
    ],
  ];

  MapStyleLayerEntry belowMarkerBackground(StyleLayer layer) => (
    layer: layer,
    belowLayerId: BaseLayer.markerBackgroundAnchor.name,
  );

  /// 細分区域の境界線より下に挿入する。
  MapStyleLayerEntry belowRegionLine(StyleLayer layer) => (
    layer: layer,
    belowLayerId: BaseLayer.areaForecastLocalELine.name,
  );
}
