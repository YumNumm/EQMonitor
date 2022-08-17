import '../setting/about_app.dart';
import '../setting/debug_info.dart';
import '../setting/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

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
              leading: const Icon(Icons.light_mode),
              title: const Text('テーマ設定'),
              onPressed: (context) => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const ThemeChoicePage(),
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
