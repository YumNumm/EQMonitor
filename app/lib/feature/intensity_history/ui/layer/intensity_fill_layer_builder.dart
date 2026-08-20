import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_expression.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:maplibre/maplibre.dart';

/// 市区町村別最大震度マップの fill/line レイヤーを組み立てる。
///
/// `areaInformationCityQuake` は全ズームのタイルに存在する
/// (`BaseMapTileSpec.cityMinZoom` = 0) ため、ズーム帯で塗る対象を切り替える
/// 必要はなく、市区町村の塗り 1 枚 + 選択中の輪郭線だけで済む。
///
/// 塗りと輪郭線をメソッドごとに分けているのは、更新契機が全く違うため。
/// 塗りは全国 ~1900 市区町村分の `match` 式を持つので入れ替えが重く、震度
/// データか配色が変わったときだけ作り直したい。輪郭線はタップごとに変わるが
/// 1 フィーチャだけで軽い。両者を 1 つの `useEffect` にまとめると、タップの
/// たびに塗りまで破棄・再追加してしまう。
///
/// 相対順序はアンカーで決まる: 塗りは細分区域の境界線の**下**、輪郭線はその
/// **上**に挿入するため、どちらを先に追加しても順序は入れ替わらない。
class IntensityFillLayerBuilder {
  const new();

  static const sourceId = 'eqmonitor_map';
  static const citySourceLayerId = 'areaInformationCityQuake';

  /// 市区町村の塗り。
  static const cityFillLayerId = 'intensity-history-city-fill';

  /// 選択中の市区町村の輪郭線。
  static const selectedCityLineLayerId = 'intensity-history-selected-city-line';

  /// [buildFill] が管理するレイヤー ID。
  static const fillLayerIds = [cityFillLayerId];

  /// [buildSelectedCityLine] が管理するレイヤー ID。
  static const selectedCityLineLayerIds = [selectedCityLineLayerId];

  static const cityFillOpacity = 0.8;

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
          paint: {
            'fill-color': IntensityMatchExpressionBuilder.build(
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
            'fill-opacity': cityFillOpacity,
          },
        ),
      ),
    ];
  }

  /// 選択中の市区町村の輪郭線。
  ///
  /// [selectedCityCode] が null なら空リストを返す（未選択）。
  List<MapStyleLayerEntry> buildSelectedCityLine({
    required String? selectedCityCode,
    required bool isDarkMode,
  }) {
    if (selectedCityCode == null) {
      return const [];
    }

    return [
      (
        layer: LineStyleLayer(
          id: selectedCityLineLayerId,
          sourceId: sourceId,
          sourceLayerId: citySourceLayerId,
          filter: <Object>[
            '==',
            <Object>['get', 'regioncode'],
            selectedCityCode,
          ],
          paint: {
            'line-color': isDarkMode ? '#FFFFFF' : '#000000',
            'line-width': 3,
            'line-opacity': 0.95,
          },
        ),
        belowLayerId: null,
        aboveLayerId: BaseLayer.areaForecastLocalELine.name,
        atIndex: null,
      ),
    ];
  }

  /// 細分区域の境界線より下に挿入する。
  MapStyleLayerEntry belowRegionLine(StyleLayer layer) => (
    layer: layer,
    belowLayerId: BaseLayer.areaForecastLocalELine.name,
    aboveLayerId: null,
    atIndex: null,
  );
}
