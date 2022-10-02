import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

class DebugMenuPage extends ConsumerWidget {
  const DebugMenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('デバッグメニュー'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              if (kDebugMode || ref.watch(developerModeProvider).isDeveloper)
                SettingsTile(
                  title: const Text('デバッグ情報'),
                  leading: const Icon(Icons.info),
                  onPressed: (BuildContext context) {
                    context.push('/settings/debug/info');
                  },
                ),
              SettingsTile(
                title: const Text('EEWテスト'),
                leading: const Icon(Icons.warning),
                onPressed: (BuildContext context) {
                  context.push('/settings/debug/eew_test');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
