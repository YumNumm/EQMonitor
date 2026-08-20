import 'dart:async';

import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
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
/// 作り直すと塗りが消えたように見える。相対順序はアンカー（細分区域の境界線の
/// 下 / 上）で決まるので、effect を分けても順序は入れ替わらない。
class IntensityFillLayer extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(activeColorSetProvider).intensity;
    final isDarkMode = Theme.brightnessOf(context) == Brightness.dark;

    final items = ref.watch(
      cityMaxIntensityProvider.select(
        (value) => value.valueOrPrevious?.items,
      ),
    );
    final selectedCityCode = ref.watch(
      intensityHistoryControllerProvider.select(
        (state) => state.selectedCity?.code,
      ),
    );

    final enqueue = useMapOperationQueue();
    const builder = IntensityFillLayerBuilder();

    // 塗りを作り直す契機を「震度データの実体が変わったとき」だけに絞るための
    // リビジョン。
    //
    // `CityMaxIntensity` には `response_at` が含まれ、SWR の再検証が走るたびに
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
        if (controller == null) {
          return null;
        }

        final layers = builder.buildFill(
          cityMaxIntensities: latestItems.value ?? const [],
          colorModel: colorModel,
        );

        unawaited(
          enqueue(
            () => _replace(
              styleController: controller,
              layerIds: IntensityFillLayerBuilder.fillLayerIds,
              layers: layers,
            ),
          ),
        );

        return () {
          unawaited(
            enqueue(
              () => _removeAll(
                styleController: controller,
                layerIds: IntensityFillLayerBuilder.fillLayerIds,
              ),
            ),
          );
        };
      },
      [styleController, itemsRevision.value, colorModel, enqueue],
    );

    useEffect(
      () {
        final controller = styleController;
        if (controller == null) {
          return null;
        }

        final layers = builder.buildSelectedCityLine(
          selectedCityCode: selectedCityCode,
          isDarkMode: isDarkMode,
        );

        unawaited(
          enqueue(
            () => _replace(
              styleController: controller,
              layerIds: IntensityFillLayerBuilder.selectedCityLineLayerIds,
              layers: layers,
            ),
          ),
        );

        return () {
          unawaited(
            enqueue(
              () => _removeAll(
                styleController: controller,
                layerIds: IntensityFillLayerBuilder.selectedCityLineLayerIds,
              ),
            ),
          );
        };
      },
      [styleController, selectedCityCode, isDarkMode, enqueue],
    );

    return const SizedBox.shrink();
  }
}

/// レイヤーの入れ替え。失敗しても後続の操作を止めない。
///
/// `on Exception` ではなく `Object` を捕まえる。`addLayer` が
/// `Exception` 以外（`TypeError` など）で落ちた場合に、削除だけ済んで追加が
/// 行われないまま原因も分からない状態になるのを避ける。
Future<void> _replace({
  required StyleController styleController,
  required Iterable<String> layerIds,
  required Iterable<MapStyleLayerEntry> layers,
}) async {
  try {
    await MapStyleLayerReplacer.replace(
      styleController: styleController,
      layerIds: layerIds,
      layers: layers,
    );
  } on Object catch (e, st) {
    talker.handle(
      e,
      st,
      'IntensityFillLayer: failed to add ${layerIds.join(', ')}',
    );
  }
}

Future<void> _removeAll({
  required StyleController styleController,
  required Iterable<String> layerIds,
}) async {
  for (final id in layerIds.toList().reversed) {
    try {
      await styleController.removeLayer(id);
    } on Object catch (e, st) {
      talker.handle(e, st, 'IntensityFillLayer: failed to remove $id');
    }
  }
}
