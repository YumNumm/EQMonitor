import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../utils/earthquake.dart';
import '../utils/map.dart';
import '../utils/messaging.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);
  final Logger logger = Get.find<Logger>();
  final EarthQuake earthQuake = Get.find<EarthQuake>();
  final Messaging messaging = Get.find<Messaging>();
  final MapData mapData = Get.find<MapData>();
  final PackageInfo packageInfo = Get.find<PackageInfo>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 0,
        child: const Icon(Icons.swipe_vertical),
        onPressed: () {
          if (earthQuake.solidController.isOpened) {
            earthQuake.solidController.hide();
          } else {
            earthQuake.solidController.show();
          }
        },
      ),
      appBar: AppBar(
        title: Text('EQMonitor (Build${packageInfo.buildNumber})'),
        actions: [
          IconButton(
            onPressed: () async {
              await Get.toNamed<void>('/setting');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      bottomSheet: SolidBottomSheet(
        controller: earthQuake.solidController,
        smoothness: Smoothness.high,
        elevation: 0,
        body: Obx(
          () => ListView.builder(
            itemCount: earthQuake.eqLog.length - 1,
            itemBuilder: (context, index) {
              final eq = earthQuake.eqLog[index + 1];
              final dt = DateFormat('yyyy/MM/dd HH:mm').format(eq.time);
              return ListTile(
                title: Text('${index + 1}: ${eq.place}'),
                subtitle: Text('M${eq.magunitude}, $dt頃'),
                trailing: Text('震度${eq.maxIntensity}'),
              );
            },
          ),
        ),
        headerBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              child: const Text(
                '直近の地震',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              tileColor: Colors.transparent,
              hoverColor: Colors.transparent,
              title: Obx(
                () => Text(
                  earthQuake.eqLog[0].place,
                  style: context.textTheme.titleLarge!
                      .apply(backgroundColor: Colors.transparent),
                ),
              ),
              subtitle: Obx(
                () => Text(
                  'M${earthQuake.eqLog[0].magunitude} '
                  '${DateFormat("yyyy/MM/dd HH:mm").format(earthQuake.eqLog[0].time)}頃',
                ),
              ),
              trailing:
                  Obx(() => Text('震度${earthQuake.eqLog[0].maxIntensity}')),
            ),
            const Divider(),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SfMaps(
              layers: <MapLayer>[
                MapShapeLayer(
                  source: MapData.dataSource,
                  showDataLabels: false,
                  zoomPanBehavior: earthQuake.mapZoomPanBehavior,
                  initialMarkersCount: earthQuake.analyzedPoint.length,
                  markerBuilder: (BuildContext context, int index) {
                    final iconSize = earthQuake.iconSize.value;
                    return MapMarker(
                      latitude: earthQuake.analyzedPoint[index].lat,
                      longitude: earthQuake.analyzedPoint[index].lon,
                      iconColor: earthQuake.analyzedPoint[index].color,
                      iconType: MapIconType.circle,
                      size: (earthQuake.zoomLevel > 30)
                          ? null
                          : Size(
                              iconSize,
                              iconSize,
                            ),
                      child: (earthQuake.zoomLevel > 30)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: earthQuake.analyzedPoint[index].color,
                                  size: 24,
                                ),
                                Text(
                                  '${earthQuake.analyzedPoint[index].name}\n震度: ${earthQuake.analyzedPoint[index].shindo}',
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 12),
                                )
                              ],
                            )
                          : null,
                    );
                  },
                  controller: earthQuake.mapShapeLayerController,
                  sublayers: [
                    MapCircleLayer(
                      circles: List<MapCircle>.generate(
                        mapData.circles.length,
                        (index) => MapCircle(
                          center: mapData.circles[index],
                          radius: 30,
                        ),
                      ).toSet(),
                    )
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white.withOpacity(0.15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            '${earthQuake.lastUpdateTimeString.value}\n倍率: ${earthQuake.zoomLevel.value} ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white.withOpacity(0.15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Image.network(
                          'http://www.kmoni.bosai.go.jp/data/map_img/ScaleImg/nied_jma_s_w_scale.gif',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
