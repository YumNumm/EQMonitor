import 'dart:async';

import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_layer_builder.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 市区町村別最大震度マップ用の震度 fill レイヤー Widget。
///
/// `areaInformationCityQuake` を市区町村ごとの観測史上最大震度で塗り分ける。
/// 市区町村ポリゴンは全ズームのタイルに存在するので、低ズーム用の代替レイヤーは
/// 持たない。
///
/// 全レイヤーを 1 つの `useEffect` でまとめて置き換える。レイヤーごとに
/// `useEffect` を分けると、依存の異なる effect が別々に再実行された際に
/// 追加順が入れ替わり、選択中の輪郭線が塗りに潜り込む。
class IntensityFillLayer extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(activeColorSetProvider).intensity;
    final state = ref.watch(intensityHistoryControllerProvider);
    final isDarkMode = Theme.brightnessOf(context) == Brightness.dark;

    final cityMaxIntensity = ref
        .watch(cityMaxIntensityProvider)
        .valueOrPrevious;

    final enqueue = useMapOperationQueue();
    const builder = IntensityFillLayerBuilder();

    useEffect(
      () {
        if (styleController == null || cityMaxIntensity == null) {
          return null;
        }

        final layers = builder.build(
          state: state,
          cityMaxIntensities: cityMaxIntensity.items,
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
        cityMaxIntensity,
        state,
        colorModel,
        isDarkMode,
        enqueue,
      ],
    );

    return const SizedBox.shrink();
  }
}
