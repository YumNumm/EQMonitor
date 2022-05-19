import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eqmonitor/pages/eq_history_page.dart';
import 'package:eqmonitor/pages/notification_history_page.dart';
import 'package:eqmonitor/utils/eq_history/eq_history_lib.dart';
import 'package:eqmonitor/utils/map/customZoomPanBehavior.dart';
import 'package:eqmonitor/utils/updater/appUpdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../utils/earthquake.dart';
import '../utils/map.dart';
import '../utils/messaging.dart';
import '../utils/svir/svir.dart';
import '../widget/map.dart';
import '../widget/on_eew.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  final Logger logger = Get.find<Logger>();
  final EarthQuake earthQuake = Get.find<EarthQuake>();
  final Svir svir = Get.find<Svir>();
  final EqHistoryLib eqHistory = Get.find<EqHistoryLib>();
  final AppUpdate appUpdate = Get.find<AppUpdate>();
  final CustomZoomPanBehavior zoomPanBehavior =
      Get.find<CustomZoomPanBehavior>();
  final Messaging messaging = Get.find<Messaging>();
  final PackageInfo packageInfo = Get.find<PackageInfo>();
  final Key mapKey = const Key('mapKey');
  final MapData mapData = Get.find<MapData>();
  final RxInt page = 0.obs;
  final RxInt selectedIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EQMonitor (Build${packageInfo.buildNumber})'),
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
                                await launchUrlString(
                                  appUpdate.updateApi.assetUrl,
                                );
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
        () => NavigationBar(
          elevation: 10,
          selectedIndex: page.value,
          onDestinationSelected: (int value) {
            page.value = value;
            HapticFeedback.mediumImpact();
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'リアルタイム震度',
            ),
            NavigationDestination(
              icon: Icon(Icons.history),
              label: '地震履歴',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_active),
              label: '通知履歴',
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
                        ? RealtimeIntensityMap()
                        : const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                  ),
                  Obx(
                    () => (svir.svirResponse.value != null )
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Obx(
                                () => OnEEWWidget(
                                  eew: svir.svirResponse.value,
                                  now: DateTime.now(),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
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
              EqHistoryPage(),
              NotificationHistoryPage(),
            ],
          ),
        ),
      ),
    );
  }
}
