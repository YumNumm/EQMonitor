import 'dart:async';

import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/region_code_mapping.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_expression.dart';
import 'package:eqmonitor/feature/map/data/model/base_map_tile_spec.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地域別最大震度マップ用の震度 fill レイヤー Widget。
///
/// - Lv1(都道府県): `areaForecastLocalE` に都道府県最高震度の match 式で塗り分け。
/// - Lv2(市区町村): `areaInformationCityQuake` に市区町村最高震度で塗り分け +
///   非選択都道府県を半透明黒でディム。
///
/// `earthquake_history_fill_layer.dart` / `earthquake_history_region_intensity_layer.dart`
/// の構造に倣い、`useEffect` でレイヤー追加・dispose でレイヤー除去。
class IntensityFillLayer extends HookConsumerWidget {
  const IntensityFillLayer({super.key});

  // --- Layer ID 定数 ---
  static const _lv1FillLayerId = 'intensity-history-lv1-fill';
  static const _lv2FillLayerId = 'intensity-history-lv2-city-fill';
  static const _selectedCityDimLayerId =
      'intensity-history-lv2-selected-city-dim';
  static const _dimFillLayerId = 'intensity-history-lv2-dim-fill';
  static const _selectedCityLineLayerId =
      'intensity-history-lv2-selected-city-line';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(activeColorSetProvider).intensity;
    final state = ref.watch(intensityHistoryControllerProvider);
    final isDarkMode = Theme.brightnessOf(context) == Brightness.dark;

    // --- パラメーター (AsyncValue) ---
    final parameterAsync = ref.watch(parameterSetProvider);
    final prefectures = parameterAsync.valueOrPrevious?.earthquake.prefectures;

    // --- Lv1: 都道府県最高震度 ---
    final prefectureHighestAsync = ref.watch(prefectureHighestProvider);
    final prefectureHighest = prefectureHighestAsync.valueOrPrevious;

    // --- Lv2: 市区町村最高震度 (City 状態のときのみ) ---
    final selectedPrefCode = state is IntensityHistoryStateCity
        ? state.prefectureCode
        : null;
    final selectedCityCode = state is IntensityHistoryStateCity
        ? state.selectedCityCode
        : null;
    final cityHighestAsync = selectedPrefCode != null
        ? ref.watch(cityHighestProvider(selectedPrefCode))
        : null;
    final cityHighest = cityHighestAsync?.valueOrPrevious;

    final enqueue = useMapOperationQueue();

    // --- Lv1 fill effect ---
    useEffect(() {
      if (styleController == null || prefectures == null) {
        return null;
      }
      if (prefectureHighest == null || prefectureHighest.isEmpty) {
        return null;
      }

      unawaited(
        enqueue(() async {
          try {
            // 都道府県コード → 配下の細分区域コード(areaForecastLocalE)に展開
            final pairs = <({String code, JmaIntensity intensity})>[];
            for (final entry in prefectureHighest) {
              final regionCodes = regionCodesOfPrefecture(
                entry.code,
                prefectures,
              );
              for (final code in regionCodes) {
                pairs.add((code: code, intensity: entry.intensity));
              }
            }

            final fillColor = buildIntensityMatchExpression(pairs, colorModel);

            await replaceMapStyleLayers(
              styleController: styleController,
              layerIds: const [_lv1FillLayerId],
              layers: [
                (
                  layer: FillStyleLayer(
                    id: _lv1FillLayerId,
                    sourceId: 'eqmonitor_map',
                    sourceLayerId: 'areaForecastLocalE',
                    paint: {'fill-color': fillColor, 'fill-opacity': 0.7},
                  ),
                  belowLayerId: BaseLayer.areaForecastLocalELine.name,
                  aboveLayerId: null,
                  atIndex: null,
                ),
              ],
            );
          } on Exception catch (e) {
            talker.log(e);
          }
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            try {
              await styleController.removeLayer(_lv1FillLayerId);
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );
      };
    }, [styleController, prefectures, prefectureHighest, colorModel]);

    // --- Lv2 city fill + dim effect ---
    useEffect(
      () {
        if (styleController == null ||
            prefectures == null ||
            selectedPrefCode == null) {
          return null;
        }
        if (cityHighest == null || cityHighest.isEmpty) {
          return null;
        }

        unawaited(
          enqueue(() async {
            try {
              // 市区町村 code → 最高震度 pairs (api.JmaIntensity → app.JmaIntensity 変換)
              final pairs = cityHighest
                  .map((e) => (code: e.code, intensity: e.intensity))
                  .toList();
              // areaInformationCityQuake のフィーチャ照合プロパティは `regioncode`。
              // (earthquake_history_fill_layer.dart の cityCodeFilter 参照)
              final fillColor = buildIntensityMatchExpression(
                pairs,
                colorModel,
                propertyKey: 'regioncode',
              );

              final layers = <MapStyleLayerEntry>[
                (
                  layer: FillStyleLayer(
                    id: _lv2FillLayerId,
                    sourceId: 'eqmonitor_map',
                    sourceLayerId: 'areaInformationCityQuake',
                    paint: {
                      'fill-color': fillColor,
                      // 市区町村ポリゴンは cityMinZoom 未満のタイルに存在しないため、
                      // その帯では Lv1 (細分区域) の塗りつぶしが可視表現になる。
                      'fill-opacity': <Object>[
                        'step',
                        <Object>['zoom'],
                        0.0,
                        BaseMapTileSpec.cityMinZoom,
                        0.8,
                      ],
                    },
                  ),
                  belowLayerId: BaseLayer.areaForecastLocalELine.name,
                  aboveLayerId: null,
                  atIndex: null,
                ),
              ];

              final dimAnchorLayerId = selectedCityCode == null
                  ? _lv2FillLayerId
                  : _selectedCityDimLayerId;

              if (selectedCityCode != null) {
                final selectedCityCodes = cityCodesOfPrefecture(
                  selectedPrefCode,
                  prefectures,
                );
                layers.add((
                  layer: FillStyleLayer(
                    id: _selectedCityDimLayerId,
                    sourceId: 'eqmonitor_map',
                    sourceLayerId: 'areaInformationCityQuake',
                    filter: <Object>[
                      'all',
                      <Object>[
                        'in',
                        <Object>['get', 'regioncode'],
                        <Object>['literal', selectedCityCodes],
                      ],
                      <Object>[
                        '!=',
                        <Object>['get', 'regioncode'],
                        selectedCityCode,
                      ],
                    ],
                    paint: const {
                      'fill-color': '#000000',
                      'fill-opacity': 0.55,
                    },
                  ),
                  belowLayerId: null,
                  aboveLayerId: _lv2FillLayerId,
                  atIndex: null,
                ));
              }

              // ディムオーバーレイ: 選択都道府県の細分区域コードを除外した全エリアを半透明黒で覆う
              final selectedRegionCodes = regionCodesOfPrefecture(
                selectedPrefCode,
                prefectures,
              );
              final dimFilter = <Object>[
                '!',
                <Object>[
                  'in',
                  <Object>['get', 'code'],
                  <Object>['literal', selectedRegionCodes],
                ],
              ];

              layers.add((
                layer: FillStyleLayer(
                  id: _dimFillLayerId,
                  sourceId: 'eqmonitor_map',
                  sourceLayerId: 'areaForecastLocalE',
                  filter: dimFilter,
                  paint: const {'fill-color': '#000000', 'fill-opacity': 0.45},
                ),
                belowLayerId: null,
                aboveLayerId: dimAnchorLayerId,
                atIndex: null,
              ));

              if (selectedCityCode != null) {
                layers.add((
                  layer: LineStyleLayer(
                    id: _selectedCityLineLayerId,
                    sourceId: 'eqmonitor_map',
                    sourceLayerId: 'areaInformationCityQuake',
                    filter: <Object>[
                      '==',
                      <Object>['get', 'regioncode'],
                      selectedCityCode,
                    ],
                    paint: {
                      'line-color': isDarkMode ? '#FFFFFF' : '#000000',
                      'line-width': 4,
                      'line-opacity': 0.95,
                    },
                  ),
                  belowLayerId: null,
                  aboveLayerId: BaseLayer.areaForecastLocalELine.name,
                  atIndex: null,
                ));
              }

              await replaceMapStyleLayers(
                styleController: styleController,
                layerIds: const [
                  _lv2FillLayerId,
                  _selectedCityDimLayerId,
                  _dimFillLayerId,
                  _selectedCityLineLayerId,
                ],
                layers: layers,
              );
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );

        return () {
          unawaited(
            enqueue(() async {
              for (final id in [
                _lv2FillLayerId,
                _selectedCityDimLayerId,
                _dimFillLayerId,
                _selectedCityLineLayerId,
              ]) {
                try {
                  await styleController.removeLayer(id);
                } on Exception catch (e) {
                  talker.log(e);
                }
              }
            }),
          );
        };
      },
      [
        styleController,
        prefectures,
        selectedPrefCode,
        selectedCityCode,
        cityHighest,
        colorModel,
        isDarkMode,
      ],
    );

    return const SizedBox.shrink();
  }
}
