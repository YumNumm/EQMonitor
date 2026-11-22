import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/ui/action/intensity_fill_layer_action.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_layer_builder.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 市区町村別最大震度マップ用の震度 fill レイヤー Widget。
///
/// `areaInformationCityQuake` を市区町村ごとの観測史上最大震度で塗り分ける。
/// 市区町村ポリゴンは全ズームのタイルに存在するので、低ズーム用の代替レイヤーは
/// 持たない。
///
/// 塗りと選択中の輪郭線は別々の `useEffect` で管理する。塗りは全国 ~1900
/// 市区町村分の `match` 式を持つので入れ替えが重く、市区町村をタップするたびに
/// 作り直すと塗りが消えたように見える。輪郭線も style・配色ごとに 1 度だけ
/// 追加し、選択の変更は filter の更新で反映する。相対順序は style が持つ
/// アンカーで決まるので、effect を分けても順序は入れ替わらない。
class const IntensityFillLayer({
  required final List<CityMaxIntensityEntry>? items,
  super.key,
}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorSet = ref.watch(activeColorSetProvider);
    final colorModel = colorSet.intensity;
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = colorScheme.brightness == .dark;

    final selectedCityCode = ref.watch(
      intensityHistoryControllerProvider.select(
        (state) => state.selectedCity?.code,
      ),
    );

    final enqueue = useMapOperationQueue();
    final action = ref.watch(intensityFillLayerActionProvider);
    const builder = IntensityFillLayerBuilder();

    // 塗りを作り直す契機を「震度データの実体が変わったとき」だけに絞るための
    // リビジョン。
    //
    // `CityMaxIntensity` には `aggregated_at` が含まれ、SWR の再検証が走るたびに
    // 新しいインスタンスになる。モデルや `items` をそのまま依存に置くと、震度が
    // 1 件も変わっていない再検証でも ~1900 分岐の `match` 式を持つ塗りを丸ごと
    // 作り直してしまう（`List` の `==` は同一性判定なので `select` でも防げない）。
    final itemsRevision = useRef(0);
    final lastItems = useRef<List<CityMaxIntensityEntry>?>(null);
    if (!listEquals(lastItems.value, items)) {
      lastItems.value = items;
      itemsRevision.value++;
    }
    // effect の依存には入れず、実行時に最新値を読むための参照。
    final latestItems = useRef(items);
    latestItems.value = items;

    useEffect(
      () {
        final controller = styleController;
        final currentItems = latestItems.value;
        if (controller == null || currentItems == null) {
          return null;
        }

        final layers = builder.buildFill(
          cityMaxIntensities: currentItems,
          colorModel: colorModel,
        );

        unawaited(
          enqueue(
            () => action.replace(
              styleController: controller,
              layerIds: IntensityFillLayerBuilder.fillLayerIds,
              layers: layers,
            ),
          ),
        );

        return () {
          unawaited(
            enqueue(
              () => action.removeAll(
                styleController: controller,
                layerIds: IntensityFillLayerBuilder.fillLayerIds,
              ),
            ),
          );
        };
      },
      [styleController, itemsRevision.value, colorModel, enqueue, action],
    );

    final latestSelectedCityCode = useRef(selectedCityCode);
    latestSelectedCityCode.value = selectedCityCode;

    useEffect(
      () {
        final controller = styleController;
        if (controller == null) {
          return null;
        }

        final lineColor = colorScheme.primary.toHexStringRGB();
        final haloColor = isDarkMode ? '#000000' : '#FFFFFF';

        unawaited(
          enqueue(
            () => action.replace(
              styleController: controller,
              layerIds: IntensityFillLayerBuilder.selectedCityLineLayerIds,
              layers: builder.buildSelectedCityLine(
                selectedCityCode: latestSelectedCityCode.value,
                lineColor: lineColor,
                haloColor: haloColor,
              ),
            ),
          ),
        );

        return () {
          unawaited(
            enqueue(
              () => action.removeAll(
                styleController: controller,
                layerIds: IntensityFillLayerBuilder.selectedCityLineLayerIds,
              ),
            ),
          );
        };
      },
      [styleController, colorScheme.primary, isDarkMode, enqueue, action],
    );

    useEffect(
      () {
        final controller = styleController;
        if (controller == null) {
          return null;
        }

        unawaited(
          enqueue(
            () => action.updateFilter(
              styleController: controller,
              layerIds: IntensityFillLayerBuilder.selectedCityLineLayerIds,
              filter: builder.selectedCityFilter(latestSelectedCityCode.value),
            ),
          ),
        );
        return null;
      },
      [styleController, selectedCityCode, enqueue, action],
    );

    return const SizedBox.shrink();
  }
}
