import 'dart:async';

import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_layer_builder.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地域別最大震度マップ用の震度 fill レイヤー Widget。
///
/// - Lv1(全国): `areaForecastLocalE` に都道府県最高震度の match 式で塗り分け。
/// - Lv2(都道府県フォーカス): `areaInformationCityQuake` に市区町村最高震度で
///   塗り分け + フォーカス外の都道府県を半透明黒でディム。
///
/// 全レイヤーを 1 つの `useEffect` でまとめて置き換える。レイヤーごとに
/// `useEffect` を分けると、依存の異なる effect が別々に再実行された際に
/// 追加順が入れ替わり、Lv1 の塗りが Lv2 の塗り・ディムを覆ってしまう。
class IntensityFillLayer extends HookConsumerWidget {
  const IntensityFillLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(activeColorSetProvider).intensity;
    final state = ref.watch(intensityHistoryControllerProvider);
    final isDarkMode = Theme.brightnessOf(context) == Brightness.dark;

    final prefectures = ref
        .watch(parameterSetProvider)
        .valueOrPrevious
        ?.earthquake
        .prefectures;
    final prefectureHighest = ref
        .watch(prefectureHighestProvider)
        .valueOrPrevious;

    final focusedPrefectureCode = switch (state) {
      IntensityHistoryStateCity(:final prefectureCode) => prefectureCode,
      IntensityHistoryStatePrefecture() => null,
    };
    final cityHighest = focusedPrefectureCode == null
        ? null
        : ref.watch(cityHighestProvider(focusedPrefectureCode)).valueOrPrevious;

    final enqueue = useMapOperationQueue();
    const builder = IntensityFillLayerBuilder();

    useEffect(
      () {
        if (styleController == null ||
            prefectures == null ||
            prefectureHighest == null) {
          return null;
        }

        final layers = builder.build(
          state: state,
          prefectureHighest: prefectureHighest,
          cityHighest: cityHighest ?? const <HighestIntensityEntry>[],
          prefectures: prefectures,
          colorModel: colorModel,
          isDarkMode: isDarkMode,
        );

        unawaited(
          enqueue(() async {
            try {
              await MapStyleLayerReplacer.replace(
                styleController: styleController,
                layerIds: IntensityFillLayerBuilder.layerIds,
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
              for (final id in IntensityFillLayerBuilder.layerIds.reversed) {
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
        prefectureHighest,
        cityHighest,
        state,
        colorModel,
        isDarkMode,
        enqueue,
      ],
    );

    return const SizedBox.shrink();
  }
}
