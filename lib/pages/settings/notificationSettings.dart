// ignore_for_file: file_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eqmonitor/utils/settings/notificationSettings.dart';
import 'package:eqmonitor/utils/settings/volumeController.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/messaging.dart';

final PackageInfo packageInfo = Get.find<PackageInfo>();
final SharedPreferences prefs = Get.find<SharedPreferences>();
final Messaging messaging = Get.find<Messaging>();
final VolumeController vc = Get.find<VolumeController>();
final Logger logger = Get.find<Logger>();
final flutterTts = FlutterTts();

final fcm = Get.find<FirebaseMessaging>();
final settings = Get.find<UserNotificationSettings>();

Widget notificationSettings(BuildContext context) {
  return SettingsList(
    sections: [
      SettingsSection(
        title: const Text('通知設定'),
        tiles: <AbstractSettingsTile>[
          SettingsTile(
            title: const Text('通知設定を開く'),
            description: const Text('OSの通知設定を開きます'),
            onPressed: (_) async =>
                await AwesomeNotifications().showNotificationConfigPage(),
            /*trailing: Obx(
              () => Switch(
                value: messaging.isAllNotificationDisabled.value,
                onChanged: (_) async {
                  final i = 0.obs;
                  await Get.showOverlay(
                    loadingWidget: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator.adaptive(),
                          Obx(
                            () => Text(
                              '処理中....(${i.value})',
                              style: context.textTheme.displaySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    asyncFunction: () async {
                      if (messaging.isAllNotificationDisabled.value) {
                        for (final e in Topics.values) {
                          i.value++;
                          await fcm.unsubscribeFromTopic(e.name);
                        }
                      } else {
                        // 有効にする
                        for (final e in Topics.values) {
                          i.value++;
                          await fcm.subscribeToTopic(e.name);
                        }
                      }
                    },
                  );
                  messaging.isAllNotificationDisabled.value =
                      !messaging.isAllNotificationDisabled.value;
                },
              ),
            ),*/
          ),
        ],
      ),
      SettingsSection(
        title: const Text('EEW通知条件設定'),
        tiles: <AbstractSettingsTile>[
          SettingsTile(
            title: const Text('すべて通知'),
            description: const Text('緊急地震速報(予報)をすべて通知'),
            onPressed: (_) async {
              settings.notifAll.value = !settings.notifAll.value;
              if (settings.notifAll.value) {
                settings
                  ..notifFirstReport.value = true
                  ..notifLastReport.value = true
                  ..notifOnUpdate.value = true
                  ..notifOnUpwardUpdate.value = true;
              }
              await settings.save();
            },
            trailing: Obx(
              () => Switch(
                value: settings.notifAll.value,
                onChanged: (bool b) async {
                  settings.notifAll.value = b;
                  if (b) {
                    settings
                      ..notifFirstReport.value = true
                      ..notifLastReport.value = true
                      ..notifOnUpdate.value = true
                      ..notifOnUpwardUpdate.value = true;
                  }
                  await settings.save();
                },
              ),
            ),
          ),
          SettingsTile(
            title: const Text('第1報通知'),
            description: const Text('緊急地震速報(予報)において、第1報を通知するかどうか'),
            onPressed: (_) async {
              settings.notifFirstReport.value =
                  !settings.notifFirstReport.value;
              await settings.save();
            },
            trailing: Obx(
              () => Switch(
                value: settings.notifFirstReport.value,
                onChanged: (bool b) async {
                  settings.notifFirstReport.value = b;
                  await settings.save();
                },
              ),
            ),
          ),
          SettingsTile(
            title: const Text('最終報通知'),
            description: const Text('緊急地震速報(予報)において、最終報を通知するかどうか'),
            onPressed: (_) async {
              settings.notifLastReport.value = !settings.notifLastReport.value;
              await settings.save();
            },
            trailing: Obx(
              () => Switch(
                value: settings.notifLastReport.value,
                onChanged: (bool b) async {
                  settings.notifLastReport.value = b;
                  await settings.save();
                },
              ),
            ),
          ),
          SettingsTile(
            title: const Text('修正時に通知'),
            description: const Text('マグニチュードもしくは最大震度が変更された時に通知'),
            onPressed: (_) async {
              settings.notifOnUpdate.value = !settings.notifOnUpdate.value;
              if (settings.notifOnUpdate.value) {
                settings.notifOnUpwardUpdate.value = true;
              }
              await settings.save();
            },
            trailing: Obx(
              () => Switch(
                value: settings.notifOnUpdate.value,
                onChanged: (bool b) async {
                  settings.notifOnUpdate.value = b;
                  if (b) {
                    settings.notifOnUpwardUpdate.value = true;
                  }
                  await settings.save();
                },
              ),
            ),
          ),
          SettingsTile(
            title: const Text('上方修正時に通知'),
            description: const Text('マグニチュードもしくは最大震度が上方変更された際に通知'),
            onPressed: (_) async {
              settings.notifOnUpwardUpdate.value =
                  !settings.notifOnUpwardUpdate.value;
              await settings.save();
            },
            trailing: Obx(
              () => Switch(
                value: settings.notifOnUpwardUpdate.value,
                onChanged: (bool b) async {
                  settings.notifOnUpwardUpdate.value = b;
                  await settings.save();
                },
              ),
            ),
          ),
        ],
      ),
      SettingsSection(
        title: const Text('通知読み上げ設定'),
        tiles: <AbstractSettingsTile>[
          /*SettingsTile.navigation(
            title: const Text('通知音量の設定'),
            value: Obx(
              () => Text('${(vc.volume.value * 100).toStringAsFixed(0)}%'),
            ),
          ),*/

          SettingsTile(
            title: const Text('通知読み上げ設定'),
            description: const Text('通知時に内容をTTSで読み上げるかどうか'),
            onPressed: (_) async {
              settings.useTTS.value = !settings.useTTS.value;
              await settings.save();
            },
            trailing: Obx(
              () => Switch(
                value: settings.useTTS.value,
                onChanged: (bool b) async {
                  settings.useTTS.value = b;
                  await settings.save();
                },
              ),
            ),
          ),
          SettingsTile.navigation(
            title: const Text('通知テスト'),
            trailing: const Icon(Icons.speaker_phone),
            onPressed: (_) async {
              await flutterTts.setLanguage('ja-JP');
              final engine = (await flutterTts.getDefaultEngine).toString();
              await AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: 0,
                  channelKey: 'fromdev',
                  title: '[テスト通知]',
                  body: 'これはテスト通知です\n$engine',
                  backgroundColor: Color.fromARGB(255, 255, 0, 0),
                  criticalAlert: true,
                  category: NotificationCategory.Social,
                ),
              );
              if (settings.useTTS.value) await flutterTts.speak('これはテスト通知です');
            },
          ),
        ],
      ),
    ],
  );
}
