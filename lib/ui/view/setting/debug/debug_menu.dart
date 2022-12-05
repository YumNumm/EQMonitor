import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../provider/setting/developer_mode.dart';
import '../../../route.dart';
import '../component/setting_section.dart';

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
              onTap: () => DeveloperDebugRoute().push(context),
            ),
          ListTile(
            title: const Text('EEWテスト'),
            leading: const Icon(Icons.warning),
            onTap: () => EewTestRoute().push(context),
          ),
          ListTile(
            title: const Text('ログ'),
            leading: const Icon(Icons.logo_dev),
            onTap: () => LogRoute().push(context),
          ),
        ],
      ),
    );
  }
}
