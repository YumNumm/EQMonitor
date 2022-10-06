import 'package:eqmonitor/provider/theme_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../utils/extension/theme_mode.dart';

class DesignSettingsPage extends ConsumerWidget {
  const DesignSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode =
        ref.watch(themeProvider.select((value) => value.themeMode));
    return Scaffold(
      appBar: AppBar(
        title: const Text('デザイン設定'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.design_services),
                title: const Text('テーマ設定'),
                description: Text(currentThemeMode.title),
                onPressed: (context) => context.push('/settings/design/theme'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.color_lens),
                title: const Text('震度配色'),
                onPressed: (context) =>
                    context.push('/settings/design/intensity'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
