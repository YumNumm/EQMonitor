import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/region_code_mapping.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_expression.dart';
import 'package:eqmonitor/feature/map/data/model/base_map_tile_spec.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:maplibre/maplibre.dart';

/// 地域別最大震度マップの fill/line レイヤー一式を組み立てる。
///
/// 全レイヤーを 1 回の [build] で、必ず「下 → 上」の順に返す。
/// レイヤーごとに個別の `useEffect` で追加すると、片方だけが再実行された際に
/// 追加順が入れ替わり Lv1(細分区域)の塗りが Lv2(市区町村)の塗りを覆ってしまう
/// ため、順序はこのクラスに集約する。
class IntensityFillLayerBuilder {
  const IntensityFillLayerBuilder();

  static const sourceId = 'eqmonitor_map';
  static const regionSourceLayerId = 'areaForecastLocalE';
  static const citySourceLayerId = 'areaInformationCityQuake';

  /// 全国の細分区域の塗り。Lv2 ではフォーカス中の都道府県を除外する。
  static const regionFillLayerId = 'intensity-history-region-fill';

  /// フォーカス中の都道府県の細分区域の塗り。
  static const focusedRegionFillLayerId =
      'intensity-history-focused-region-fill';

  /// フォーカス中の都道府県の市区町村の塗り。
  static const cityFillLayerId = 'intensity-history-city-fill';

  /// フォーカス中の都道府県以外を覆うディム。
  static const dimFillLayerId = 'intensity-history-dim-fill';

  /// 選択中の市区町村の輪郭線。
  static const selectedCityLineLayerId = 'intensity-history-selected-city-line';

  /// [build] が生成しうる全レイヤー ID。除去時にも利用する。
  static const layerIds = [
    regionFillLayerId,
    focusedRegionFillLayerId,
    cityFillLayerId,
    dimFillLayerId,
    selectedCityLineLayerId,
  ];

  static const regionFillOpacity = 0.7;
  static const cityFillOpacity = 0.8;
  static const dimFillOpacity = 0.45;

  List<MapStyleLayerEntry> build({
    required IntensityHistoryState state,
    required List<HighestIntensityEntry> prefectureHighest,
    required List<HighestIntensityEntry> cityHighest,
    required List<EarthquakeParameterPrefectureItem> prefectures,
    required IntensityColors colorModel,
    required bool isDarkMode,
  }) {
    final focusedPrefectureCode = switch (state) {
      IntensityHistoryStateCity(:final prefectureCode) => prefectureCode,
      IntensityHistoryStatePrefecture() => null,
    };
    final selectedCityCode = switch (state) {
      IntensityHistoryStateCity(:final selectedCityCode) => selectedCityCode,
      IntensityHistoryStatePrefecture() => null,
    };
    final focusedRegionCodes = focusedPrefectureCode == null
        ? const <String>[]
        : RegionCodeMapping.regionCodesOfPrefecture(
            focusedPrefectureCode,
            prefectures,
          );
    final hasCityFill = focusedPrefectureCode != null && cityHighest.isNotEmpty;

    final entries = <MapStyleLayerEntry>[];

    final regionPairs = regionIntensityPairs(
      prefectureHighest: prefectureHighest,
      prefectures: prefectures,
    );
    if (regionPairs.isNotEmpty) {
      final fillColor = IntensityMatchExpressionBuilder.build(
        regionPairs,
        colorModel,
      );
      entries.add(
        belowRegionLine(
          FillStyleLayer(
            id: regionFillLayerId,
            sourceId: sourceId,
            sourceLayerId: regionSourceLayerId,
            filter: focusedRegionCodes.isEmpty
                ? null
                : <Object>['!', regionCodeFilter(focusedRegionCodes)],
            paint: {'fill-color': fillColor, 'fill-opacity': regionFillOpacity},
          ),
        ),
      );

      if (focusedRegionCodes.isNotEmpty) {
        // 市区町村ポリゴンは cityMinZoom 未満のタイルに存在しないため、その帯では
        // 細分区域の塗りを可視表現として残す。市区町村の塗りが出るズームでは
        // 半透明の重なりによる混色を避けるため透明にする。
        entries.add(
          belowRegionLine(
            FillStyleLayer(
              id: focusedRegionFillLayerId,
              sourceId: sourceId,
              sourceLayerId: regionSourceLayerId,
              filter: regionCodeFilter(focusedRegionCodes),
              paint: {
                'fill-color': fillColor,
                'fill-opacity': hasCityFill
                    ? <Object>[
                        'step',
                        <Object>['zoom'],
                        regionFillOpacity,
                        BaseMapTileSpec.cityMinZoom,
                        0.0,
                      ]
                    : regionFillOpacity,
              },
            ),
          ),
        );
      }
    }

    if (hasCityFill) {
      // areaInformationCityQuake のフィーチャ照合プロパティは `regioncode`。
      // (earthquake_history_fill_layer.dart の cityCodeFilter 参照)
      final fillColor = IntensityMatchExpressionBuilder.build(
        cityHighest
            .map((entry) => (code: entry.code, intensity: entry.intensity))
            .toList(),
        colorModel,
        propertyKey: 'regioncode',
      );
      entries.add(
        belowRegionLine(
          FillStyleLayer(
            id: cityFillLayerId,
            sourceId: sourceId,
            sourceLayerId: citySourceLayerId,
            paint: {
              'fill-color': fillColor,
              'fill-opacity': <Object>[
                'step',
                <Object>['zoom'],
                0.0,
                BaseMapTileSpec.cityMinZoom,
                cityFillOpacity,
              ],
            },
          ),
        ),
      );
    }

    if (focusedRegionCodes.isNotEmpty) {
      entries.add(
        belowRegionLine(
          FillStyleLayer(
            id: dimFillLayerId,
            sourceId: sourceId,
            sourceLayerId: regionSourceLayerId,
            filter: <Object>['!', regionCodeFilter(focusedRegionCodes)],
            paint: const {
              'fill-color': '#000000',
              'fill-opacity': dimFillOpacity,
            },
          ),
        ),
      );
    }

    if (selectedCityCode != null) {
      entries.add((
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
      ));
    }

    return entries;
  }

  /// 都道府県ごとの最高震度を、配下の細分区域コードへ展開する。
  ///
  /// `areaForecastLocalE` のフィーチャは細分区域コードを持つため、
  /// 都道府県コードのままでは 1 区域も一致しない。
  List<({String code, JmaIntensity intensity})> regionIntensityPairs({
    required List<HighestIntensityEntry> prefectureHighest,
    required List<EarthquakeParameterPrefectureItem> prefectures,
  }) => [
    for (final entry in prefectureHighest)
      for (final code in RegionCodeMapping.regionCodesOfPrefecture(
        entry.code,
        prefectures,
      ))
        (code: code, intensity: entry.intensity),
  ];

  List<Object> regionCodeFilter(List<String> codes) => <Object>[
    'in',
    <Object>['get', 'code'],
    <Object>['literal', codes],
  ];

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
