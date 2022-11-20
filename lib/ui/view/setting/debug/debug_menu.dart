import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:eqmonitor/ui/view/setting/component/setting_section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugMenuPage extends ConsumerWidget {
  const DebugMenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('デバッグメニュー'),
      ),
      body: SettingsSection(
        title: 'デバッグメニュー',
        children: [
          if (kDebugMode || ref.watch(developerModeProvider).isDeveloper)
            ListTile(
              title: const Text('デバッグ情報'),
              leading: const Icon(Icons.info),
              onTap: () {
                context.push('/settings/debug/info');
              },
            ),
          ListTile(
            title: const Text('EEWテスト'),
            leading: const Icon(Icons.warning),
            onTap: () {
              context.push('/settings/debug/eew_test');
            },
          ),
          ListTile(
            title: const Text('ログ'),
            leading: const Icon(Icons.logo_dev),
            onTap: () {
              context.push('/settings/debug/log');
            },
          ),
        ],
      ),
    );
  }
}
