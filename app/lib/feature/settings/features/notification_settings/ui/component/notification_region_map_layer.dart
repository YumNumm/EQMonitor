import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/notification_region_map_filter.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_map_selection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_region_map_selection_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

const notificationRegionFocusLayerId = 'notification-region-focus-line';
const notificationRegionCityLayerId = 'notification-region-city-line';
const notificationSelectedCityLayerId = 'notification-selected-city-line';

class NotificationRegionMapLayer extends HookConsumerWidget {
  const NotificationRegionMapLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();
    final selection = ref.watch(
      notificationRegionMapSelectionControllerProvider,
    );
    final filterBuilder = ref.watch(notificationRegionMapFilterProvider);
    final colorSet = ref.watch(activeColorSetProvider);
    final focusColor = colorSet.primary.toHexStringRGB();
    final boundaryColor = colorSet.mapColors.japanLine.toHexStringRGB();
    final region = switch (selection) {
      NotificationRegionMapNationwide() => null,
      NotificationRegionMapFocused(:final region) => region,
      NotificationRegionMapCitySelected(:final region) => region,
    };
    final cityCode = switch (selection) {
      NotificationRegionMapCitySelected(:final city) => city.code,
      _ => null,
    };
    final regionCityCodes =
        region?.cities.map((city) => city.code).toList() ?? const <String>[];

    useEffect(() {
      if (style == null) {
        return null;
      }
      unawaited(
        enqueue(() async {
          try {
            await style.updateFilter(
              id: BaseLayer.areaInformationCityQuakeLine.name,
              filter: filterBuilder.buildMatchNothing('regioncode'),
            );
            await MapStyleLayerReplacer.replace(
              styleController: style,
              layerIds: const [
                notificationRegionFocusLayerId,
                notificationRegionCityLayerId,
                notificationSelectedCityLayerId,
              ],
              layers: [
                (
                  layer: LineStyleLayer(
                    id: notificationRegionFocusLayerId,
                    sourceId: 'eqmonitor_map',
                    sourceLayerId: 'areaForecastLocalEew',
                    filter: filterBuilder.buildRegion(region?.code),
                    paint: {
                      'line-color': focusColor,
                      'line-width': 3,
                      'line-opacity': 1,
                    },
                  ),
                  belowLayerId: null,
                  aboveLayerId: null,
                  atIndex: null,
                ),
                (
                  layer: LineStyleLayer(
                    id: notificationRegionCityLayerId,
                    sourceId: 'eqmonitor_map',
                    sourceLayerId: 'areaInformationCityQuake',
                    minZoom: 6,
                    filter: filterBuilder.buildRegionCities(regionCityCodes),
                    paint: {
                      'line-color': boundaryColor,
                      'line-width': 1.2,
                      'line-opacity': 0.85,
                    },
                  ),
                  belowLayerId: null,
                  aboveLayerId: null,
                  atIndex: null,
                ),
                (
                  layer: LineStyleLayer(
                    id: notificationSelectedCityLayerId,
                    sourceId: 'eqmonitor_map',
                    sourceLayerId: 'areaInformationCityQuake',
                    minZoom: 6,
                    filter: filterBuilder.buildSelectedCity(cityCode),
                    paint: {
                      'line-color': focusColor,
                      'line-width': 4,
                      'line-opacity': 1,
                    },
                  ),
                  belowLayerId: null,
                  aboveLayerId: null,
                  atIndex: null,
                ),
              ],
            );
          } on Exception catch (error, stackTrace) {
            talker.handle(error, stackTrace);
          }
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            try {
              await style.updateFilter(
                id: BaseLayer.areaInformationCityQuakeLine.name,
                filter: null,
              );
            } on Exception catch (error, stackTrace) {
              talker.handle(error, stackTrace);
            }
            for (final id in const [
              notificationSelectedCityLayerId,
              notificationRegionCityLayerId,
              notificationRegionFocusLayerId,
            ]) {
              try {
                await style.removeLayer(id);
              } on Exception catch (error, stackTrace) {
                talker.handle(error, stackTrace);
              }
            }
          }),
        );
      };
    }, [style, enqueue, filterBuilder, focusColor, boundaryColor]);

    useEffect(() {
      if (style == null) {
        return null;
      }
      unawaited(
        enqueue(() async {
          try {
            await style.updateFilter(
              id: notificationRegionFocusLayerId,
              filter: filterBuilder.buildRegion(region?.code),
            );
            await style.updateFilter(
              id: notificationRegionCityLayerId,
              filter: filterBuilder.buildRegionCities(regionCityCodes),
            );
            await style.updateFilter(
              id: notificationSelectedCityLayerId,
              filter: filterBuilder.buildSelectedCity(cityCode),
            );
          } on Exception catch (error, stackTrace) {
            talker.handle(error, stackTrace);
          }
        }),
      );
      return null;
    }, [style, enqueue, filterBuilder, selection]);

    return const SizedBox.shrink();
  }
}
