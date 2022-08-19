import 'package:eqmonitor/page/setting/design_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../setting/about_app.dart';
import '../setting/debug_info.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          tiles: <SettingsTile>[
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
            if (kDebugMode)
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
