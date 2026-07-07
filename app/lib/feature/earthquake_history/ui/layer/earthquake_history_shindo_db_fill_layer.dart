import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_fill_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/earthquake_history_map_layer_mode.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EarthquakeHistoryShindoDbFillLayer extends HookConsumerWidget {
  const EarthquakeHistoryShindoDbFillLayer({
    required this.tree,
    required this.parameter,
    super.key,
  });

  final ShindoDbIntensityTree tree;
  final EarthquakeHistoryMapLayerParameter parameter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(activeColorSetProvider).intensity;
    final enqueue = useMapOperationQueue();
    final modeResolver = useMemoized(
      () => const EarthquakeHistoryMapLayerModeResolver(),
    );
    final builder = useMemoized(
      () => EarthquakeHistoryFillLayerBuilder(modeResolver: modeResolver),
      [modeResolver],
    );

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      final addedLayerIds = <String>[];
      var disposed = false;

      Future<void> removeAdded() async {
        for (final id in addedLayerIds.reversed) {
          try {
            await styleController.removeLayer(id);
          } on Exception catch (e) {
            talker.log(e);
          }
        }
      }

      unawaited(
        enqueue(() async {
          try {
            // region ごとの最大階級を事前計算
            final regionMaxClass = <String, ShindoDbIntensityClass>{};
            for (final entry in tree.tree.entries) {
              final cls = entry.key;
              for (final pref in entry.value) {
                for (final cityNode in pref.cities) {
                  final regionCode = cityNode.region.code;
                  final current = regionMaxClass[regionCode];
                  if (current == null || cls.orderIndex > current.orderIndex) {
                    regionMaxClass[regionCode] = cls;
                  }
                }
              }
            }

            // orderIndex 昇順(低震度→高震度)で追加し、高震度レイヤーが上に来るようにする
            final sortedClasses =
                tree.tree.keys
                    .where((cls) => cls.colorJmaIntensity != null)
                    .toList()
                  ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

            for (final cls in sortedClasses) {
              if (disposed) {
                return;
              }
              final color = colorModel
                  .fromJmaIntensity(cls.colorJmaIntensity!)
                  .background
                  .toHexStringRGB();
              final idPrefix = 'eq-history-shindo-db-${cls.name}';

              final cityCodes = <String>[];
              final regionCodesForClass = <String>[];
              final prefNodes = tree.tree[cls] ?? [];
              for (final pref in prefNodes) {
                for (final cityNode in pref.cities) {
                  cityCodes.add(cityNode.city.code);
                  final regionCode = cityNode.region.code;
                  if (regionMaxClass[regionCode] == cls &&
                      !regionCodesForClass.contains(regionCode)) {
                    regionCodesForClass.add(regionCode);
                  }
                }
              }

              // region レイヤー (auto モード相当: ズームで city に切り替わる)
              final mode = EarthquakeHistoryMapLayerMode.auto;

              if (regionCodesForClass.isNotEmpty) {
                final regionLayers = builder.buildRegionLayers(
                  idPrefix: idPrefix,
                  codes: regionCodesForClass,
                  color: color,
                  mode: mode,
                  parameter: parameter,
                );
                for (final layer in regionLayers) {
                  if (disposed) {
                    return;
                  }
                  await styleController.addLayer(
                    layer,
                    belowLayerId: BaseLayer.areaForecastLocalELine.name,
                  );
                  addedLayerIds.add(layer.id);
                }
              }

              if (cityCodes.isNotEmpty) {
                final cityLayer = builder.buildCityLayer(
                  idPrefix: idPrefix,
                  codes: cityCodes,
                  color: color,
                  mode: mode,
                  parameter: parameter,
                );
                if (disposed) {
                  return;
                }
                await styleController.addLayer(
                  cityLayer,
                  belowLayerId: BaseLayer.areaForecastLocalELine.name,
                );
                addedLayerIds.add(cityLayer.id);
              }
            }
          } on Exception catch (e) {
            talker.log(e);
          }
        }),
      );

      return () {
        disposed = true;
        unawaited(enqueue(removeAdded));
      };
    }, [styleController, tree, colorModel, parameter, builder]);

    return const SizedBox.shrink();
  }
}
