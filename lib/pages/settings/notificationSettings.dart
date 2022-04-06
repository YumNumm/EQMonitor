// ignore_for_file: file_names

import 'package:eqmonitor/utils/settings/notificationSettings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/messaging.dart';

final PackageInfo packageInfo = Get.find<PackageInfo>();
final SharedPreferences prefs = Get.find<SharedPreferences>();
final Messaging messaging = Get.find<Messaging>();
final fcm = Get.find<FirebaseMessaging>();
final settings = Get.find<UserNotificationSettings>();

Widget notificationSettings(BuildContext context) {
  return SettingsList(
    sections: [
      SettingsSection(
        title: const Text('通知設定'),
        tiles: <AbstractSettingsTile>[
          SettingsTile(
            enabled: false,
            title: const Text('通知'),
            description: const Text('すべての通知をオフにできます。'),
            onPressed: (_) async {
              // messaging.isAllNotificationDisabled.value =
              //   !messaging.isAllNotificationDisabled.value;
            },
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
              if (!settings.notifAll.value) {
                settings
                  ..notifFirstReport.value = true
                  ..notifLastReport.value = true
                  ..notifOnUpdate.value = true
                  ..notifOnUpwardUpdate.value = true;
              }
              settings.notifAll.value = !settings.notifAll.value;
              await settings.save();
            },
            trailing: Obx(
              () => Switch(
                value: settings.notifAll.value,
                onChanged: (bool b)async {
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
                onChanged: (bool b)async {
                  settings.notifFirstReport.value = b;
                  await settings.save();
                },
              ),
            ),
          ),
          SettingsTile(
            title: const Text('最終報通知'),
            description: const Text('緊急地震速報(予報)において、最終報を通知するかどうか'),
            trailing: Obx(
              () => Switch(
                value: settings.notifLastReport.value,
                onChanged: (bool b) {
                  settings.notifLastReport.value = b;
                  settings.save();
                },
              ),
            ),
          ),
          SettingsTile(
            title: const Text('修正時に通知'),
            description: const Text('マグニチュードもしくは最大震度が変更された時に通知'),
            trailing: Obx(
              () => Switch(
                value: settings.notifOnUpdate.value,
                onChanged: (bool b) {
                  settings.notifOnUpdate.value = b;
                  if (b) {
                    settings.notifOnUpwardUpdate.value = true;
                  }

                  settings.save();
                },
              ),
            ),
          ),
          SettingsTile(
            title: const Text('上方修正時に通知'),
            description: const Text('マグニチュードもしくは最大震度が上方変更された際に通知'),
            trailing: Obx(
              () => Switch(
                value: settings.notifOnUpwardUpdate.value,
                onChanged: (bool b) {
                  settings.notifOnUpwardUpdate.value = b;
                  settings.save();
                },
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
