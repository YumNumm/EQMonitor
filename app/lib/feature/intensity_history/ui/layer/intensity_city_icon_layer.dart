import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/ui/action/intensity_fill_layer_action.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:eqmonitor/feature/map/features/icon/data/provider/intensity_icon_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

class const IntensityCityIconLayer({
  required final List<CityMaxIntensityEntry>? items,
  super.key,
}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final iconData = styleController == null
        ? null
        : ref.watch(intensityIconProvider).value;
    final enqueue = useMapOperationQueue();
    final action = ref.watch(intensityFillLayerActionProvider);
    const builder = IntensityCityIconLayerBuilder();

    // 再検証で items のインスタンスだけが変わったときにレイヤーを作り直さないためのリビジョン。
    final itemsRevision = useRef(0);
    final lastItems = useRef<List<CityMaxIntensityEntry>?>(null);
    if (!listEquals(lastItems.value, items)) {
      lastItems.value = items;
      itemsRevision.value++;
    }
    final latestItems = useRef(items);
    latestItems.value = items;
    final generation = useRef<Object?>(null);

    useEffect(
      () {
        final controller = styleController;
        final currentItems = latestItems.value;
        if (controller == null || iconData == null || currentItems == null) {
          return null;
        }

        unawaited(
          enqueue(() async {
            try {
              await controller.addImages(iconData.toMapStyleImages);
            } on Object catch (error, stackTrace) {
              talker.handle(
                error,
                stackTrace,
                'IntensityCityIconLayer: failed to add images',
              );
              return;
            }
            await action.replace(
              styleController: controller,
              layerIds: IntensityCityIconLayerBuilder.layerIds,
              layers: builder.build(cityMaxIntensities: currentItems),
            );
          }),
        );

        final current = Object();
        generation.value = current;

        return () {
          if (!identical(generation.value, current)) {
            return;
          }
          unawaited(
            enqueue(
              () => action.removeAll(
                styleController: controller,
                layerIds: IntensityCityIconLayerBuilder.layerIds,
              ),
            ),
          );
        };
      },
      [styleController, iconData, itemsRevision.value, enqueue, action],
    );

    return const SizedBox.shrink();
  }
}

class const IntensityCityIconLayerBuilder() {
  static const sourceId = 'eqmonitor_map';
  static const citySourceLayerId = 'areaInformationCityQuakeLabel';
  static const minZoom = 7.0;
  static const iconSize = 0.13;

  static final layerIds = [
    for (final intensity in JmaIntensity.values) layerIdOf(intensity),
  ];

  static String layerIdOf(JmaIntensity intensity) =>
      'intensity-history-city-icon-${intensity.name}';

  List<MapStyleLayerEntry> build({
    required List<CityMaxIntensityEntry> cityMaxIntensities,
  }) {
    final maxIntensityByCode = <String, JmaIntensity>{};
    for (final entry in cityMaxIntensities) {
      final current = maxIntensityByCode[entry.cityCode];
      if (current == null || entry.intensity.index > current.index) {
        maxIntensityByCode[entry.cityCode] = entry.intensity;
      }
    }
    final codesOfLevel = <JmaIntensity, List<String>>{};
    for (final MapEntry(key: code, value: intensity)
        in maxIntensityByCode.entries) {
      codesOfLevel.putIfAbsent(intensity, () => []).add(code);
    }

    // 衝突時は後から積んだ layer が優先して配置されるため、震度の小さい順に積む。
    return [
      for (final intensity in JmaIntensity.values)
        if (codesOfLevel[intensity] case final codes?)
          (
            layer: SymbolStyleLayer(
              id: layerIdOf(intensity),
              sourceId: sourceId,
              sourceLayerId: citySourceLayerId,
              filter: .raw([
                'in',
                ['get', 'regioncode'],
                ['literal', codes],
              ]),
              minZoom: minZoom,
              iconImage: .literal(
                'JmaIntensity.${IntensityIconType.filled.name}.${intensity.name}',
              ),
              iconSize: const .literal(iconSize),
              iconAllowOverlap: const .literal(false),
              iconPadding: const .literal([0]),
            ),
            belowLayerId: BaseLayer.areaIconAnchor.name,
          ),
    ];
  }
}
