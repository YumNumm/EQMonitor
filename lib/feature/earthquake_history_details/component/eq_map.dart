import 'package:eqmonitor/core/component/map/base_map.dart';
import 'package:eqmonitor/core/component/map/map_touch_handler_widget.dart';
import 'package:eqmonitor/core/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/eq_hypocenter_painter.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/eq_region_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';

class EarthquakeHistoryMap extends HookConsumerWidget {
  const EarthquakeHistoryMap({required this.item, super.key});
  final EarthquakeHistoryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    // 地図データがない場合はローディング

    final mapKey = useMemoized(
      () => GlobalKey(debugLabel: 'eq-history-map-${item.eventId}'),
    );
    final moveController = useAnimationController();
    final scaleController = useAnimationController();
    final globalPointAndZoomLevelController = useAnimationController();
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          final renderBox =
              mapKey.currentContext!.findRenderObject()! as RenderBox;
          // Widgetのサイズを登録
          ref.read(mapViewModelProvider(mapKey).notifier)
            ..registerRenderBox(
              renderBox,
            )
            ..registerAnimationControllers(
              moveController: moveController,
              scaleController: scaleController,
              globalPointAndZoomLevelController:
                  globalPointAndZoomLevelController,
            )
            ..fitBounds(
              _getShowBounds(item),
            )
            ..applyBounds();
          //  ..fitBounds(
          //  _getShowBounds(item, ref.read(mapDataProvider).data!),
          //);
        });
        return null;
      },
      [mapKey],
    );
    return ClipRRect(
      child: Stack(
        children: [
          ClipRRect(
            key: mapKey,
            child: Stack(
              children: [
                BaseMapWidget.polygon(mapKey),
                if (item.earthquake.intensity != null)
                  EarthquakeIntensityMapWidget(
                    intensity: item.earthquake.intensity!,
                    mapKey: mapKey,
                    showIntensityIcon: true,
                  ),
                BaseMapWidget.polyline(mapKey),
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
) {
  if (item.earthquake.intensity != null) {
    //final map = mapData.jmaMap[MapDataType.areaForecastLoadlE]!;
    //final result = <LatLng>[];
    //if (item.earthquake.intensity!.maxInt > JmaIntensity.four) {
    //  for (final region in item.earthquake.intensity!.regions
    //      .where((element) => element.maxInt! > JmaIntensity.four)) {
    //    final e = map.firstWhere((e) => e.properties.code == region.code);
    //    result.addAll([e.boundary.northEast, e.boundary.southWest]);
    //  }
    //  return result;
    //}
    //for (final region in item.earthquake.intensity!.regions) {
    //  final e = map.firstWhere((e) => e.properties.code == region.code);
    //  result.addAll([e.boundary.northEast, e.boundary.southWest]);
    //}
    //return result;
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
