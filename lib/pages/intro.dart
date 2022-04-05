import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../utils/earthquake.dart';
import '../utils/map.dart';
import '../utils/messaging.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);
  final Logger logger = Get.find<Logger>();
  final EarthQuake earthQuake = Get.find<EarthQuake>();
  final Messaging messaging = Get.find<Messaging>();
  final PackageInfo packageInfo = Get.find<PackageInfo>();
  final MapData mapData = Get.find<MapData>();
  final RxInt page = 0.obs;

  final DateFormat df = DateFormat('yyyy/MM/dd hh:mm頃');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EQMonitor Ver.α (Build${packageInfo.buildNumber})'),
        actions: [
          IconButton(
            onPressed: () async {
              await Get.toNamed<void>('/setting');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          elevation: 10,
          currentIndex: page.value,
          onTap: (int value) => page.value = value,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'リアルタイム震度',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: '地震履歴',
            ),
          ],
        ),
      ),
      /*bottomSheet: SolidBottomSheet(
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
      ),*/
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: page.value,
            children: <Widget>[
              Stack(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: earthQuake.analyzedPoint[index].color,
                                  size: earthQuake.iconSize.value,
                                ),
                                Text(
                                  (earthQuake.zoomLevel > 20)
                                      ? '${earthQuake.analyzedPoint[index].name}\n震度: ${earthQuake.analyzedPoint[index].shindo}'
                                      : '',
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 12),
                                )
                              ],
                            ),
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
                                  '${earthQuake.lastUpdateTimeString.value}\n観測点: ${earthQuake.analyzedPoint.length}点\n倍率: ${earthQuake.zoomLevel.value.toStringAsFixed(1)}',
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
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                     // child: NonEEW(),
                      // child: NonEEW(context),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                itemCount: earthQuake.eqLog.length,
                itemBuilder: (BuildContext context, int i) {
                  final eqLog = earthQuake.eqLog[i];

                  return Container(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: (earthQuake.eqLog[i+1] != null)
                            ? BorderSide.none
                            : (earthQuake.eqLog[i + 1].time.day !=
                                    eqLog.time.day)
                                ? const BorderSide()
                                : BorderSide.none,
                      ),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/intensity/${(eqLog.maxIntensity == "---") ? "unknown" : eqLog.maxIntensity}.PNG',
                      ),
                      title: Text(
                        df.format(eqLog.time),
                      ),
                      subtitle: Text('${eqLog.place} M${eqLog.magunitude}'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
