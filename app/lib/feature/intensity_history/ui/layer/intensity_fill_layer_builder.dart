import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_expression.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:maplibre/maplibre.dart';

/// 市区町村別最大震度マップの fill/line レイヤーを組み立てる。
///
/// `areaInformationCityQuake` は全ズームのタイルに存在する
/// (`BaseMapTileSpec.cityMinZoom` = 0) ため、ズーム帯で塗る対象を切り替える
/// 必要はなく、市区町村の塗り 1 枚 + 選択中の輪郭線だけで済む。
///
/// 2 枚を必ず 1 回の [build] で「下 → 上」の順に返す。レイヤーごとに個別の
/// `useEffect` で追加すると、片方だけが再実行された際に追加順が入れ替わり
/// 輪郭線が塗りに潜り込む。
class IntensityFillLayerBuilder {
  const new();

  static const sourceId = 'eqmonitor_map';
  static const citySourceLayerId = 'areaInformationCityQuake';

  /// 市区町村の塗り。
  static const cityFillLayerId = 'intensity-history-city-fill';

  /// 選択中の市区町村の輪郭線。
  static const selectedCityLineLayerId = 'intensity-history-selected-city-line';

  /// [build] が生成しうる全レイヤー ID。除去時にも利用する。
  static const layerIds = [cityFillLayerId, selectedCityLineLayerId];

  static const cityFillOpacity = 0.8;

  List<MapStyleLayerEntry> build({
    required IntensityHistoryState state,
    required List<CityMaxIntensityEntry> cityMaxIntensities,
    required IntensityColors colorModel,
    required bool isDarkMode,
  }) {
    final entries = <MapStyleLayerEntry>[];

    if (cityMaxIntensities.isNotEmpty) {
      // areaInformationCityQuake のフィーチャ照合プロパティは `regioncode`。
      // (earthquake_history_fill_layer.dart の cityCodeFilter 参照)
      entries.add(
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
      );
    }

    if (state.selectedCity case final selectedCity?) {
      entries.add((
        layer: LineStyleLayer(
          id: selectedCityLineLayerId,
          sourceId: sourceId,
          sourceLayerId: citySourceLayerId,
          filter: <Object>[
            '==',
            <Object>['get', 'regioncode'],
            selectedCity.code,
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
      ));
    }

    return entries;
  }

  /// 細分区域の境界線より下に挿入する。
  ///
  /// [MapStyleLayerReplacer.replace] は与えられた順に「同じアンカーの直下」へ挿入する
  /// ため、先に渡したものが下、後に渡したものが上になる。
  MapStyleLayerEntry belowRegionLine(StyleLayer layer) => (
    layer: layer,
    belowLayerId: BaseLayer.areaForecastLocalELine.name,
    aboveLayerId: null,
    atIndex: null,
  );
}
