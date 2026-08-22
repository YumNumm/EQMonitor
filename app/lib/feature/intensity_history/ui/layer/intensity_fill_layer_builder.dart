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
/// 必要はなく、市区町村の塗り 1 枚 + 選択中の枠線（ハロー・本線）だけで済む。
///
/// 塗りと輪郭線をメソッドごとに分けているのは、更新契機が全く違うため。
/// 塗りは全国 ~1900 市区町村分の `match` 式を持つので入れ替えが重く、震度
/// データか配色が変わったときだけ作り直したい。輪郭線はタップごとに変わるが
/// 1 フィーチャだけで軽い。両者を 1 つの `useEffect` にまとめると、タップの
/// たびに塗りまで破棄・再追加してしまう。
///
/// 相対順序はアンカーと追加順で決まる: 塗りは細分区域の境界線の**下**、
/// 選択枠はスタイルの最前面に追加する。どちらを先に追加しても塗りは境界線の
/// 下に留まり、選択枠は他レイヤーに埋もれない。
class IntensityFillLayerBuilder {
  const new();

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
  static const selectedCityLineWidth = 3.0;
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
  /// ハローと本線の 2 枚を最前面に置き、塗りや細分区域境界に埋もれないようにする。
  List<MapStyleLayerEntry> buildSelectedCityLine({
    required String? selectedCityCode,
    required String lineColor,
    required String haloColor,
  }) {
    if (selectedCityCode == null) {
      return const [];
    }

    final filter = <Object>[
      '==',
      <Object>['get', 'regioncode'],
      selectedCityCode,
    ];
    const layout = <String, Object>{
      'line-cap': 'round',
      'line-join': 'round',
    };

    return [
      (
        layer: LineStyleLayer(
          id: selectedCityHaloLayerId,
          sourceId: sourceId,
          sourceLayerId: citySourceLayerId,
          filter: filter,
          layout: layout,
          paint: {
            'line-color': haloColor,
            'line-width': selectedCityHaloWidth,
            'line-opacity': 0.9,
          },
        ),
        belowLayerId: null,
        aboveLayerId: null,
        atIndex: null,
      ),
      (
        layer: LineStyleLayer(
          id: selectedCityLineLayerId,
          sourceId: sourceId,
          sourceLayerId: citySourceLayerId,
          filter: filter,
          layout: layout,
          paint: {
            'line-color': lineColor,
            'line-width': selectedCityLineWidth,
            'line-opacity': 1,
          },
        ),
        belowLayerId: null,
        aboveLayerId: null,
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
