import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../utils/auth.dart';

final AuthStateUtils authStateUtils = Get.find<AuthStateUtils>();
final Logger logger = Get.find<Logger>();
final RxBool isDarkMode = Get.isDarkMode.obs;
bool isDarkmode = Get.isDarkMode;
Widget topSettingPage() {
  return SettingsList(
    shrinkWrap: false,
    sections: [
      SettingsSection(
        //title: const Text(''),
        tiles: <AbstractSettingsTile>[
          SettingsTile.navigation(
            title: const Text('アカウント設定'),
            leading: const Icon(Icons.person),
            value: Obx(
              () => (authStateUtils.isLoggedin.value)
                  ? Text('ログイン済み (${authStateUtils.user.value!.displayName}さん)')
                  : const Text('ログインしていません'),
            ),
            onPressed: (e) {
              Get.toNamed<void>(
                '/setting/?page=0&isAuthed=${authStateUtils.isLoggedin.value}',
              );
            },
          ),
          SettingsTile.navigation(
            title: const Text('通知設定'),
            leading: const Icon(Icons.notifications_rounded),
            onPressed: (context) async {
              await Get.toNamed<void>('/setting/?page=1');
            },
          ),
          SettingsTile.navigation(
            title: const Text('アプリについて'),
            leading: const Icon(Icons.account_balance),
            onPressed: (e) async {
              await Get.toNamed<void>('/setting/?page=2');
            },
          ),
          SettingsTile(
            title: const Text('ダークモード'),
            onPressed: (_) {
              Get.changeThemeMode(
                (Get.isDarkMode) ? ThemeMode.light : ThemeMode.dark,
              );
              isDarkMode.value = !Get.isDarkMode;
            },
            trailing: Obx(
              () => Switch(
                value: isDarkMode.value,
                onChanged: (bool e) async {
                  Get.changeThemeMode(
                    (Get.isDarkMode) ? ThemeMode.light : ThemeMode.dark,
                  );
                  isDarkMode.value = !Get.isDarkMode;
                },
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
