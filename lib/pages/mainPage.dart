import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
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

  final DateFormat df = DateFormat('yyyy/MM/dd HH:mm頃');
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Obx(
                                () => AutoSizeText(
                                  earthQuake.msg.value,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                margin: const EdgeInsets.all(2),
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
                                        '${earthQuake.lastUpdateTimeString.value}\n観測点: ${earthQuake.numberOfAnalyzedPoint.value}点\n倍率: ${earthQuake.zoomLevel.value.toStringAsFixed(1)}',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SfMaps(
                          layers: <MapLayer>[
                            MapShapeLayer(
                              source: MapData.dataSource,
                              zoomPanBehavior: earthQuake.mapZoomPanBehavior,
                              initialMarkersCount:
                                  earthQuake.analyzedPoint.length,
                              loadingBuilder: (context) => const Center(
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 5,
                                ),
                              ),
                              markerBuilder: (BuildContext context, int index) {
                                final iconSize = earthQuake.iconSize.value;
                                return MapMarker(
                                  latitude: earthQuake.analyzedPoint[index].lat,
                                  longitude:
                                      earthQuake.analyzedPoint[index].lon,
                                  child: (earthQuake.zoomLevel > 20)
                                      ? Stack(
                                          children: [
                                            Align(
                                              child: Container(
                                                width:
                                                    earthQuake.iconSize.value,
                                                height:
                                                    earthQuake.iconSize.value,
                                                decoration: (earthQuake
                                                            .analyzedPoint[
                                                                index]
                                                            .shindo ==
                                                        null)
                                                    ? const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.grey,
                                                      )
                                                    : BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: earthQuake
                                                            .analyzedPoint[
                                                                index]
                                                            .color,
                                                      ),
                                              ),
                                            ),
                                            Align(
                                              child: Text(
                                                (earthQuake.analyzedPoint[index]
                                                            .shindo ==
                                                        null)
                                                    ? earthQuake
                                                        .analyzedPoint[index]
                                                        .name
                                                    : '${earthQuake.analyzedPoint[index].name}\n震度: ${earthQuake.analyzedPoint[index].shindo}',
                                              ),
                                            )
                                          ],
                                        )
                                      : Container(
                                          width: earthQuake.iconSize.value,
                                          height: earthQuake.iconSize.value,
                                          decoration: (earthQuake
                                                      .analyzedPoint[index]
                                                      .shindo ==
                                                  null)
                                              ? BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                  ),
                                                )
                                              : BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: earthQuake
                                                      .analyzedPoint[index]
                                                      .color,
                                                ),
                                        ),
                                );
                              },
                              controller: earthQuake.mapShapeLayerController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
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
                              child: Image.asset(
                                'assets/nied_jma_s_w_scale.gif',
                                height: context.height * 0.2,
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
                    decoration: const BoxDecoration(),
                    child: ListTile(
                      onTap: () async {
                        await Get.dialog<void>(
                          AlertDialog(
                            title: Text(df.format(eqLog.time)),
                            content: Row(
                              children: [
                                Image.asset(
                                  'assets/intensity/${(eqLog.maxIntensity == "---") ? "unknown" : eqLog.maxIntensity}.PNG',
                                  fit: BoxFit.scaleDown,
                                  height: context.height * 0.1,
                                ),
                                SizedBox(width: context.width * 0.05),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('M${eqLog.magunitude}'),
                                    Text('震源地: ${eqLog.place}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        child: Image.asset(
                          'assets/intensity/${(eqLog.maxIntensity == "---") ? "unknown" : eqLog.maxIntensity}.PNG',
                        ),
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
