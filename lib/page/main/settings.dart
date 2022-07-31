import 'package:eqmonitor/page/setting/about_app.dart';
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
                MaterialPageRoute(builder: (context) => const AboutAppPage()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
