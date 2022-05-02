import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eqmonitor/utils/map/customZoomPanBehavior.dart';
import 'package:eqmonitor/utils/map/marker_builder.dart';
import 'package:eqmonitor/utils/updater/appUpdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/earthquake.dart';
import '../utils/map.dart';
import '../utils/messaging.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);
  final Logger logger = Get.find<Logger>();
  final EarthQuake earthQuake = Get.find<EarthQuake>();
  final AppUpdate appUpdate = Get.find<AppUpdate>();
  final CustomZoomPanBehavior zoomPanBehavior =
      Get.find<CustomZoomPanBehavior>();
  final Messaging messaging = Get.find<Messaging>();
  final PackageInfo packageInfo = Get.find<PackageInfo>();
  final Key mapKey = const Key('mapKey');
  final MapData mapData = Get.find<MapData>();
  final RxInt page = 0.obs;
  final RxInt selectedIndex = (-1).obs;

  final DateFormat df = DateFormat('yyyy/MM/dd HH:mm頃');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EQMonitor Ver.α (Build${packageInfo.buildNumber})'),
        actions: [
          Obx(
            () => (appUpdate.hasUpdate.value)
                ? IconButton(
                    icon: const Icon(Icons.system_update),
                    color: Colors.redAccent,
                    tooltip: 'アップデートがあります',
                    onPressed: () async {
                      await Get.dialog<void>(
                        AlertDialog(
                          title: const Text('アップデートがあります'),
                          actions: [
                            TextButton.icon(
                              onPressed: () async {
                                await launch(appUpdate.updateApi.assetUrl);
                              },
                              icon: const Icon(Icons.download),
                              label: const Text('ダウンロードする'),
                            ),
                          ],
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(appUpdate.updateApi.title),
                                SizedBox(
                                  height: context.height * 0.7,
                                  width: context.width * 0.8,
                                  child: Markdown(
                                    data: appUpdate.updateApi.body,
                                    selectable: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container(),
          ),
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
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: page.value,
            children: <Widget>[
              Stack(
                children: [
                  Obx(
                    () => (mapData.isInited.value)
                        ? Obx(
                            () => SfMaps(
                              layers: <MapLayer>[
                                MapShapeLayer(
                                  source: MapData.dataSource,
                                  selectedIndex: selectedIndex.value,
                                  onSelectionChanged: (int index) {
                                    selectedIndex.value = index;
                                  },
                                  selectionSettings: const MapSelectionSettings(
                                    color: Colors.orange,
                                    strokeWidth: 3,
                                  ),
                                  zoomPanBehavior:
                                      earthQuake.mapZoomPanBehavior,
                                  initialMarkersCount:
                                      earthQuake.analyzedPoint.length,
                                  loadingBuilder: (context) => const Center(
                                    child: CircularProgressIndicator.adaptive(
                                      strokeWidth: 5,
                                    ),
                                  ),
                                  markerBuilder: (BuildContext context,
                                          int index) =>
                                      markerBuilder(context, index, earthQuake),
                                  controller:
                                      earthQuake.mapShapeLayerController,
                                ),
                              ],
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      //! child: OnEEWWidget(),
                      child: AutoSizeText(
                        earthQuake.msg.value,
                        maxLines: 3,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () async => Get.defaultDialog(
                            backgroundColor: Colors.white.withOpacity(0.9),
                            title: '',
                            content: Image.asset(
                              'assets/nied_jma_s_w_scale.gif',
                            ),
                          ),
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
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      // child: NonEEW(),
                      // child: NonEEW(context),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.all(10),
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
                                child: AutoSizeText(
                                  '${earthQuake.lastUpdateTimeString.value}\n'
                                  '観測点: ${earthQuake.numberOfAnalyzedPoint.value}点\n'
                                  '倍率: ${earthQuake.zoomLevel.value.toStringAsFixed(1)}',
                                  maxLines: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
