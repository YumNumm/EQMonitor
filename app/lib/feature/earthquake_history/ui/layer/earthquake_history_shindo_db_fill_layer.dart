import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_fill_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/earthquake_history_map_layer_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/shindo_db_fill_codes_calculator.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:material_ui/material_ui.dart';
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
            final fillCodes = const ShindoDbFillCodesCalculator().compute(tree);
            for (final entry in fillCodes.entries) {
              if (disposed) {
                return;
              }
              final cls = entry.key;
              final colorJmaIntensity = cls.colorJmaIntensity;
              if (colorJmaIntensity == null) {
                continue;
              }
              final color = colorModel
                  .fromJmaIntensity(colorJmaIntensity)
                  .background
                  .toHexStringRGB();
              final idPrefix = 'eq-history-shindo-db-${cls.name}';

              final cityCodes = entry.value.cityCodes;
              final regionCodesForClass = entry.value.regionCodes;

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
