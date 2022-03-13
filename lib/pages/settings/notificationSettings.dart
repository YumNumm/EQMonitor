// ignore_for_file: file_names

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
Widget notificationSettings(BuildContext context) {
  return SettingsList(
    sections: [
      SettingsSection(
        title: const Text('通知設定'),
        tiles: <AbstractSettingsTile>[
          SettingsTile(
            title: const Text('通知'),
            description: const Text('すべての通知をオフにできます。'),
            onPressed: (_) async {
              messaging.isAllNotificationDisabled.value =
                  !messaging.isAllNotificationDisabled.value;
            },
            trailing: Obx(
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
            ),
          ),
        ],
      ),
    ],
  );
}
