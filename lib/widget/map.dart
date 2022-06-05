import 'package:eqmonitor/utils/KyoshinMonitorlib/kyoshinMonitorlibTime.dart';
import 'package:eqmonitor/utils/image_cache/image_cache.dart';
import 'package:eqmonitor/utils/map/customZoomPanBehavior.dart';
import 'package:eqmonitor/utils/map/marker_builder.dart';
import 'package:eqmonitor/utils/svir/svir.dart';
import 'package:eqmonitor/utils/updater/appUpdate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../utils/earthquake.dart';
import '../utils/map.dart';
import '../utils/messaging.dart';

class RealtimeIntensityMap extends StatelessWidget {
  RealtimeIntensityMap({super.key, required this.backgroundColor});

  final Color? backgroundColor;
  final Logger logger = Get.find<Logger>();
  final EarthQuake earthQuake = Get.find<EarthQuake>();
  final AppUpdate appUpdate = Get.find<AppUpdate>();
  final CustomZoomPanBehavior zoomPanBehavior =
      Get.find<CustomZoomPanBehavior>();
  final Messaging messaging = Get.find<Messaging>();
  final PackageInfo packageInfo = Get.find<PackageInfo>();
  final Key mapKey = const Key('mapKey');
  final MapData mapData = Get.find<MapData>();
  final AssetImageCache aic = Get.find<AssetImageCache>();
  final Svir svir = Get.find<Svir>();
  final KyoshinMonitorlibTime kmoniTime = Get.find<KyoshinMonitorlibTime>();

  @override
  Widget build(BuildContext context) {
    return SfMaps(
      layers: <MapLayer>[
        MapShapeLayer(
          source: MapData.dataSource,
          color: backgroundColor,
          zoomPanBehavior: earthQuake.mapZoomPanBehavior,
          initialMarkersCount: earthQuake.analyzedPoint.length +
              earthQuake.eewAnalyzedPoint.length,
          loadingBuilder: (context) => const Center(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 5,
            ),
          ),
          markerBuilder: (
            context,
            index,
          ) =>
              markerBuilder(
            context,
            index,
            earthQuake,
            aic,
            svir,
            kmoniTime,
          ),
          controller: earthQuake.mapShapeLayerController,
        ),
      ],
    );
  }
}
