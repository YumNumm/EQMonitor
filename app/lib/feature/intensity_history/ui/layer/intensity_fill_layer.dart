import 'dart:async';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/region_code_mapping.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_expression.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:flutter/widgets.dart';
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
  static const _dimFillLayerId = 'intensity-history-lv2-dim-fill';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(intensityColorProvider);
    final state = ref.watch(intensityHistoryControllerProvider);

    // --- パラメーター (AsyncValue) ---
    final parameterAsync = ref.watch(parameterSetProvider);
    final prefectures = parameterAsync.whenOrNull(
      data: (p) => p.earthquake.prefectures,
    );

    // --- Lv1: 都道府県最高震度 ---
    final prefectureHighestAsync = ref.watch(prefectureHighestProvider);
    final prefectureHighest = prefectureHighestAsync.whenOrNull(data: (v) => v);

    // --- Lv2: 市区町村最高震度 (City 状態のときのみ) ---
    final selectedPrefCode = state is IntensityHistoryStateCity
        ? state.prefectureCode
        : null;
    final cityHighestAsync = selectedPrefCode != null
        ? ref.watch(cityHighestProvider(selectedPrefCode))
        : null;
    final cityHighest = cityHighestAsync?.whenOrNull(data: (v) => v);

    // --- Lv1 fill effect ---
    useEffect(
      () {
        if (styleController == null || prefectures == null) {
          return null;
        }
        if (prefectureHighest == null || prefectureHighest.isEmpty) {
          return null;
        }

        var disposed = false;

        unawaited(() async {
          try {
            // 都道府県コード → 配下の細分区域コード(areaForecastLocalE)に展開
            final pairs = <({String code, JmaIntensity intensity})>[];
            for (final entry in prefectureHighest) {
              final regionCodes = regionCodesOfPrefecture(
                entry.code,
                prefectures,
              );
              for (final code in regionCodes) {
                pairs.add(
                  (code: code, intensity: entry.intensity.toJmaIntensity),
                );
              }
            }

            final fillColor = buildIntensityMatchExpression(pairs, colorModel);

            if (disposed) {
              return;
            }
            await styleController.addLayer(
              FillStyleLayer(
                id: _lv1FillLayerId,
                sourceId: 'eqmonitor_map',
                sourceLayerId: 'areaForecastLocalE',
                paint: {
                  'fill-color': fillColor,
                  'fill-opacity': 0.7,
                },
              ),
              belowLayerId: BaseLayer.areaForecastLocalELine.name,
            );
          } on Exception catch (e) {
            talker.log(e);
          }
        }());

        return () {
          disposed = true;
          unawaited(() async {
            try {
              await styleController.removeLayer(_lv1FillLayerId);
            } on Exception catch (e) {
              talker.log(e);
            }
          }());
        };
      },
      [styleController, prefectures, prefectureHighest, colorModel],
    );

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

        var disposed = false;

        unawaited(() async {
          try {
            // 市区町村 code → 最高震度 pairs (api.JmaIntensity → app.JmaIntensity 変換)
            final pairs = cityHighest
                .map(
                  (e) => (code: e.code, intensity: e.intensity.toJmaIntensity),
                )
                .toList();
            // areaInformationCityQuake のフィーチャ照合プロパティは `regioncode`。
            // (earthquake_history_fill_layer.dart の cityCodeFilter 参照)
            final fillColor = buildIntensityMatchExpression(
              pairs,
              colorModel,
              propertyKey: 'regioncode',
            );

            if (disposed) {
              return;
            }

            // Lv2 市区町村 fill
            await styleController.addLayer(
              FillStyleLayer(
                id: _lv2FillLayerId,
                sourceId: 'eqmonitor_map',
                sourceLayerId: 'areaInformationCityQuake',
                paint: {
                  'fill-color': fillColor,
                  'fill-opacity': 0.8,
                },
              ),
              belowLayerId: BaseLayer.areaForecastLocalELine.name,
            );

            if (disposed) {
              return;
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

            await styleController.addLayer(
              FillStyleLayer(
                id: _dimFillLayerId,
                sourceId: 'eqmonitor_map',
                sourceLayerId: 'areaForecastLocalE',
                filter: dimFilter,
                paint: const {
                  'fill-color': '#000000',
                  'fill-opacity': 0.45,
                },
              ),
              belowLayerId: BaseLayer.areaForecastLocalELine.name,
            );
          } on Exception catch (e) {
            talker.log(e);
          }
        }());

        return () {
          disposed = true;
          unawaited(() async {
            for (final id in [_lv2FillLayerId, _dimFillLayerId]) {
              try {
                await styleController.removeLayer(id);
              } on Exception catch (e) {
                talker.log(e);
              }
            }
          }());
        };
      },
      [
        styleController,
        prefectures,
        selectedPrefCode,
        cityHighest,
        colorModel,
      ],
    );

    return const SizedBox.shrink();
  }
}
