import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqmonitor/core/component/map/base_map.dart';
import 'package:eqmonitor/core/component/map/data/model/mutable_projected_feature_layer.dart';
import 'package:eqmonitor/core/component/map/map_touch_handler_widget.dart';
import 'package:eqmonitor/core/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/core/provider/topology_map/provider/topology_maps.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/eq_hypocenter_painter.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/eq_region_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:topo_map/topo_map.dart';

class EarthquakeHistoryMap extends HookConsumerWidget {
  const EarthquakeHistoryMap({
    required this.item,
    required this.mapKey,
    super.key,
  });
  final EarthquakeHistoryItem item;
  final GlobalKey mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 地図データがない場合はローディング

    final mapData =
        ref.watch(zoomCachedProjectedFeatureLayerProvider).valueOrNull;
    if (mapData == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    final moveController = useAnimationController();
    final scaleController = useAnimationController();
    final globalPointAndZoomLevelController = useAnimationController();

    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          final renderBox =
              mapKey.currentContext!.findRenderObject()! as RenderBox;
          final bbox = _getShowBounds(item, mapData);

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
            ..setBounds(
              bbox,
            )
            ..resetMarkAsMoved()
            ..applyBounds(
              // 下30%
              padding: EdgeInsets.only(
                bottom: renderBox.size.height * 0.3,
              ).add(const EdgeInsets.all(8)),
            );
          //  ..fitBounds(
          //  _getShowBounds(item, ref.read(mapDataProvider).data!),
          //);
        });
        return null;
      },
      [mapKey],
    );
    return ClipRRect(
      key: mapKey,
      child: Stack(
        children: [
          if (item.earthquake.intensity != null)
            EarthquakeIntensityMapWidget(
              intensity: item.earthquake.intensity!,
              mapKey: mapKey,
              showIntensityIcon: true,
              mapData: mapData,
            ),
          RepaintBoundary(child: BaseMapWidget.polyline(mapKey)),
          if (item.earthquake.earthquake?.hypocenter.coordinate != null)
            EarthquakeHypocenterMapWidget(
              latLng: item.earthquake.earthquake!.hypocenter.coordinate!,
              mapKey: mapKey,
            ),
          MapTouchHandlerWidget(mapKey: mapKey),
        ],
      ),
    );
  }
}

List<LatLng> _getShowBounds(
  EarthquakeHistoryItem item,
  Map<LandLayerType, ZoomCachedProjectedFeatureLayer> mapData,
) {
  if (item.earthquake.intensity != null) {
    final map = mapData[LandLayerType.earthquakeInformationSubdivisionArea]!;
    final result = <LatLng>[];
    final onlyOver4 = item.earthquake.intensity!.maxInt > JmaIntensity.four;
    for (final region in item.earthquake.intensity!.regions.where(
      (element) =>
          (!onlyOver4 || element.maxInt! > JmaIntensity.four) &&
          element.maxInt != null,
    )) {
      final e = map.projectedPolygonFeatures
          .firstWhere((e) => e.code.toString() == region.code);
      result.addAll([e.bbox.northEast, e.bbox.southWest]);
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
