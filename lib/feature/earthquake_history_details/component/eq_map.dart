import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:eqapi_schema/model/telegram_v3.dart';
import 'package:eqmonitor/common/component/map/map.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viemwodel.dart';
import 'package:eqmonitor/common/feature/map/model/map_type.dart';
import 'package:eqmonitor/common/feature/map/model/state/map_data_state.dart';
import 'package:eqmonitor/common/feature/map/provider/map_data_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/eq_hypocenter_painter.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/eq_region_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryMap extends HookConsumerWidget {
  const EarthquakeHistoryMap({required this.item, super.key});
  final EarthquakeHistoryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapKey = useMemoized(
      () => GlobalKey(debugLabel: 'eq-history-map-${item.eventId}'),
    );
    final moveController = useAnimationController();
    final scaleController = useAnimationController();
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          ref.read(mapViewModelProvider(mapKey).notifier)
            ..registerWidgetSize(
              context.size!,
            )
            ..registerAnimationControllers(
              moveController: moveController,
              scaleController: scaleController,
            )
            ..fitBounds(
              _getShowBounds(item, ref.read(mapDataProvider).data!),
            );
        });
        return null;
      },
      [mapKey],
    );
    final brightness = Theme.of(context).brightness;
    if (ref.watch(mapDataProvider).projectedData == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return ClipRRect(
      child: Stack(
        children: [
          // background
          Container(
            color: Color.lerp(
              Theme.of(context).colorScheme.background,
              Colors.blue,
              brightness == Brightness.light ? 0.3 : 0.15,
            ),
          ),
          ClipRRect(
            child: Stack(
              children: [
                BaseMapWidget(mapKey: mapKey),
                if (item.earthquake.intensity != null)
                  EarthquakeIntensityMapWidget(
                    intensity: item.earthquake.intensity!,
                    mapKey: mapKey,
                    showIntensityIcon: true,
                  ),
                BaseMapWidget(
                  mapKey: mapKey,
                  onlyBorder: true,
                ),
                if (item.earthquake.earthquake?.hypocenter.coordinate != null)
                  EarthquakeHypocenterMapWidget(
                    latLng: item.earthquake.earthquake!.hypocenter.coordinate!,
                    mapKey: mapKey,
                  ),
              ],
            ),
          ),
          MapTouchHandlerWidget(mapKey: mapKey),
        ],
      ),
    );
  }
}

List<LatLng> _getShowBounds(
  EarthquakeHistoryItem item,
  MapDataFromSource mapData,
) {
  if (item.earthquake.intensity != null) {
    final map = mapData.jmaMap[MapDataType.areaForecastLoadlE]!;
    final result = <LatLng>[];
    if (item.earthquake.intensity!.maxInt > JmaIntensity.four) {
      for (final region in item.earthquake.intensity!.regions
          .where((element) => element.maxInt! > JmaIntensity.four)) {
        final e = map.firstWhere((e) => e.properties.code == region.code);
        result.addAll([e.boundary.northEast, e.boundary.southWest]);
      }
      return result;
    }
    for (final region in item.earthquake.intensity!.regions) {
      final e = map.firstWhere((e) => e.properties.code == region.code);
      result.addAll([e.boundary.northEast, e.boundary.southWest]);
    }
    return result;
  }
  if (item.earthquake.earthquake != null &&
      item.earthquake.earthquake!.hypocenter.coordinate != null) {
    return [
      LatLng(
        item.earthquake.earthquake!.hypocenter.coordinate!.lat,
        item.earthquake.earthquake!.hypocenter.coordinate!.lon,
      ),
    ];
  }
  return [
    const LatLng(45.3, 145.1),
    const LatLng(30, 128.8),
  ];
}
