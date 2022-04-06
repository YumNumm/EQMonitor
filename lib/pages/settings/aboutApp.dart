// ignore_for_file: file_names

import 'package:eqmonitor/utils/earthquake.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/messaging.dart';

final PackageInfo packageInfo = Get.find<PackageInfo>();
final Logger logger = Get.find<Logger>();
final EarthQuake eq = Get.find<EarthQuake>();
final SharedPreferences prefs = Get.find<SharedPreferences>();
final fcm = Get.find<FirebaseMessaging>();
final Messaging messaging = Get.find<Messaging>();
final RxInt devCounter = 0.obs;
Widget aboutThisApp(BuildContext context) {
  return SettingsList(
    sections: [
      SettingsSection(
        tiles: [
          // Package Name

          SettingsTile.navigation(
            title: const Text('アプリ名'),
            description: Text(
              '${packageInfo.appName} (Build ${packageInfo.version} - ${packageInfo.buildNumber})',
            ),
          ),
          SettingsTile.navigation(
            title: const Text('パッケージ名'),
            description: Text(packageInfo.packageName),
          ),
          // FCM Token
          SettingsTile.navigation(
            title: const Text('FCMトークン'),
            description: Text(messaging.token.toString()),
            onPressed: (BuildContext context) async {
              logger.d(messaging.token.toString());
              await Clipboard.setData(
                ClipboardData(
                  text: messaging.token.toString(),
                ),
              );
              Get.showSnackbar(
                const GetSnackBar(
                  title: 'コピーしました。',
                  message: 'クリップボードにコピーしました。',
                  duration: Duration(milliseconds: 1500),
                ),
              );
            },
          ),
          SettingsTile.navigation(
            title: const Text('ライセンス情報'),
            onPressed: (BuildContext context) async => showLicensePage(
              context: context,
              applicationIcon: const FlutterLogo(),
              applicationVersion: packageInfo.version,
              applicationName: packageInfo.appName,
              applicationLegalese: 'MIT 2022 Onoue Ryotaro',
            ),
          ),
          SettingsTile.navigation(
            title: const Text('Special Thanks'),
            onPressed: (BuildContext context) => Get.dialog<void>(
              AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('Chromium_Linux氏'),
                        subtitle: const Text('起動画面・アプリアイコン'),
                        onTap: () =>
                            launch('https://twitter.com/Chromium_Linux'),
                      ),
                      ListTile(
                        title: const Text('soshi1822氏'),
                        subtitle: const Text('緊急地震速報(EEW)'),
                        onTap: () => launch(
                          'https://svir.jp/',
                        ),
                      ),
                      ListTile(
                        title: const Text('ingen084氏'),
                        subtitle: const Text('強震モニタ画像解析手法'),
                        onTap: () => launch(
                          'https://github.com/ingen084/KyoshinMonitorLib',
                        ),
                      ),
                      ListTile(
                        title: const Text('Shion氏'),
                        subtitle: const Text('通知・効果音'),
                        onTap: () => launch(
                          'https://twitter.com/Shion30227499',
                        ),
                      ),
                      const Divider(
                        height: 5,
                        color: Colors.grey,
                      ),
                      ListTile(
                        title: const Text('国立研究開発法人 防災科学技術研究所'),
                        subtitle: const Text('リアルタイム震度データ\n緊急地震速報(EEW)'),
                        onTap: () => launch(
                          'https://www.kyoshin.bosai.go.jp/kyoshin/docs/new_kyoshinmonitor.html',
                        ),
                      ),
                      ListTile(
                        title: const Text('Project DM-D.S.S'),
                        subtitle: const Text('過去の地震データ\n地震・津波情報'),
                        onTap: () => launch(
                          'https://dmdata.jp/',
                        ),
                      ),
                      const Divider(
                        height: 5,
                        color: Colors.grey,
                      ),
                      ListTile(
                        title: const Text('国土交通省 気象庁'),
                        onTap: () => launch(
                          'https://www.jma.go.jp/jma/kishou/info/coment.html',
                        ),
                      ),
                    ],
                  ),
                ),
                title: const Text('Special Thanks'),
                contentPadding: const EdgeInsets.all(30),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          SettingsTile(
            title: const Text('開発者向けオプション'),
            onPressed: (_) async {
              devCounter.value++;
              if (devCounter.value >= 10) {
                if (!Get.isDialogOpen!) {
                  Get.showSnackbar(
                    const GetSnackBar(
                      title: 'Now you are a developer!',
                      message: '^_^',
                      duration: Duration(milliseconds: 1500),
                    ),
                  );
                  final isSubscribedToDev =
                      (prefs.getStringList('topics') ?? []).contains('dev').obs;
                  await Get.dialog<void>(
                    AlertDialog(
                      title: const Text('Developer Menu'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('Dev Topicの購読'),
                              subtitle: const Text('開発中の通知が飛んできます。'),
                              trailing: Obx(
                                () => Switch(
                                  value: isSubscribedToDev.value,
                                  onChanged: (bool b) async {
                                    await Get.showOverlay(
                                      loadingWidget: const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      ),
                                      asyncFunction: () async {
                                        if (b) {
                                          // 有効にする～～
                                          await fcm.subscribeToTopic('dev');
                                        } else {
                                          await fcm.unsubscribeFromTopic('dev');
                                        }
                                      },
                                    );
                                    isSubscribedToDev.value = b;
                                  },
                                ),
                              ),
                            ),
                            ListTile(
                              title: const Text('Widgetの震度を設定'),
                              onTap: () async {
                                final l = [
                                  '0',
                                  '1',
                                  '2',
                                  '3',
                                  '4',
                                  '5-',
                                  '5+',
                                  '6-',
                                  '6+',
                                  '7'
                                ];
                                await Get.dialog<void>(
                                  AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List<Widget>.generate(
                                        l.length,
                                        (index) => ListTile(
                                          title: Text('震度${l[index]}'),
                                          onTap: () async {
                                            await HomeWidget.saveWidgetData<
                                                String>(
                                              'max_intensity',
                                              l[index].toString(),
                                            );
                                            await HomeWidget.saveWidgetData<
                                                String>('magnitude', 'M9.1');
                                            await HomeWidget.saveWidgetData<
                                                String>(
                                              'time',
                                              DateFormat(
                                                'yyyy/MM/dd HH:mm:ss.SSS',
                                              ).format(DateTime.now()),
                                            );
                                            await HomeWidget.saveWidgetData<
                                                String>('place', 'テスト');
                                            await HomeWidget.updateWidget(
                                              androidName: 'latestwidget',
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: const Text('Widgetをリセット'),
                              onTap: () async {
                                await Get.showOverlay(
                                  loadingWidget: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  asyncFunction: () async {
                                    await eq.updateEQLog();
                                    await HomeWidget.updateWidget(
                                      androidName: 'latestwidget',
                                    );
                                  },
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
            },
          ),
          SettingsTile.navigation(
            title: const Text('ソースコード'),
            trailing: const Icon(Icons.open_in_browser),
            description: const Text('https://github.com/EQMonitor/EQMonitor'),
            onPressed: (BuildContext context) => launch(
              'https://github.com/EQMonitor/EQMonitor',
            ),
          ),
        ],
      ),
    ],
  );
}
