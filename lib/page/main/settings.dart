import 'package:eqmonitor/page/setting/notification_setting.dart';
import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

import '../setting/about_app.dart';
import '../setting/debug_info.dart';
import '../setting/design_settings.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsList(
      sections: [
        SettingsSection(
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.notifications),
              title: const Text('通知設定'),
              onPressed: (context) => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const NotificationSettingPage(),
                ),
              ),
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.design_services),
              title: const Text('デザイン設定'),
              onPressed: (context) => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const DesignSettingsPage(),
                ),
              ),
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.info),
              title: const Text('アプリ情報'),
              onPressed: (context) => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const AboutAppPage(),
                ),
              ),
            ),
            if (kDebugMode || ref.watch(developerModeProvider).isDeveloper)
              SettingsTile.navigation(
                leading: const Icon(Icons.bug_report),
                title: const Text('デバッグ情報'),
                onPressed: (context) => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const DebugInfoPage(),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
