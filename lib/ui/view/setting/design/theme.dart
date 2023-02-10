import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../provider/theme_providers.dart';
import '../../../../utils/extension/theme_mode.dart';

class ThemeChoicePage extends HookConsumerWidget {
  const ThemeChoicePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode =
        ref.watch(themeProvider.select((value) => value.themeMode));
    return Scaffold(
      appBar: AppBar(
        title: const Text('テーマ設定'),
      ),
      body: SafeArea(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: ThemeMode.values.length,
          itemBuilder: (context, index) {
            final themeMode = ThemeMode.values[index];
            return RadioListTile(
              title: Text(themeMode.title),
              subtitle: Text(themeMode.description),
              value: themeMode.name,
              selected: themeMode.name == currentThemeMode.name,
              groupValue: currentThemeMode.name,
              onChanged: (_) {
                ref.read(themeProvider.notifier).setTheme(themeMode);
              },
            );
          },
        ),
      ),
    );
  }
}
