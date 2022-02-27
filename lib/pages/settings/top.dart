import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:status_alert/status_alert.dart';

import '../../utils/auth.dart';

final AuthStateUtils authStateUtils = Get.find<AuthStateUtils>();
final Logger logger = Get.find<Logger>();

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
            value: const Text('震度0以上'),
            onPressed: (context) {
              StatusAlert.show(
                context,
                duration: const Duration(milliseconds: 2000),
                title: '未実装だよ～～ん',
                subtitle: 'ｳｯﾋｮｯﾋｮﾋｮ',
                configuration: const IconConfiguration(
                  icon: Icons.no_encryption,
                ),
              );
            },
          ),
          SettingsTile.navigation(
            title: const Text('アプリについて'),
            leading: const Icon(Icons.account_balance),
            onPressed: (e) async {
              await Get.toNamed<void>('/setting/?page=2');
            },
          ),
          SettingsTile.switchTile(
            initialValue: Get.isDarkMode,
            onToggle: (bool b) async {
              Get.changeThemeMode(b ? ThemeMode.dark : ThemeMode.light);
              return b;
            },
            title: const Text('ダークモード'),
          ),
        ],
      ),
    ],
  );
}
