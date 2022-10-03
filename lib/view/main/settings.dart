import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.notifications),
                title: const Text('通知設定'),
                onPressed: (context) => context.push('/settings/notification'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.design_services),
                title: const Text('デザイン設定'),
                onPressed: (context) => context.push('/settings/design'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.info),
                title: const Text('アプリ情報'),
                onPressed: (context) => context.push('/settings/appinfo'),
              ),
              if (kDebugMode || ref.watch(developerModeProvider).isDeveloper)
                SettingsTile.navigation(
                  leading: const Icon(Icons.bug_report),
                  title: const Text('デバッグメニュー'),
                  onPressed: (context) => context.push('/settings/debug'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
