import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/app_group_preferences.dart';
import 'package:eqmonitor/core/provider/app_group_settings_writer.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/app_group/app_group_values_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_app_group_action.g.dart';

@riverpod
DebugAppGroupAction debugAppGroupAction(Ref ref) => DebugAppGroupAction();

class DebugAppGroupAction {
  Future<void> editApiServerUrl(WidgetRef ref, BuildContext context) async {
    final current = ref.read(appGroupValuesProvider).value?.apiServerUrl;
    final controller = TextEditingController(text: current ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('apiServerUrl を編集'),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(fontFamily: FontFamily.googleSansCode),
          decoration: const InputDecoration(
            hintText: 'https://v2.api.eqmonitor.app',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.url,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text.trim());
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
    if (result == null) {
      return;
    }
    final prefs = await ref.read(appGroupPreferencesProvider.future);
    await prefs.setString(AppGroupKeys.apiServerUrl, result);
    ref
      ..invalidate(appGroupValuesProvider, asReload: true)
      ..invalidate(appGroupSettingsWriterProvider, asReload: true);
  }

  Future<void> setDebugMode(WidgetRef ref, {required bool value}) async {
    final prefs = await ref.read(appGroupPreferencesProvider.future);
    await prefs.setBool(AppGroupKeys.debugMode, value);
    ref
      ..invalidate(appGroupValuesProvider, asReload: true)
      ..invalidate(appGroupSettingsWriterProvider, asReload: true);
  }

  Future<void> syncFromProvider(WidgetRef ref, BuildContext context) async {
    ref.invalidate(appGroupSettingsWriterProvider, asReload: true);
    await ref.read(appGroupSettingsWriterProvider.future);
    ref.invalidate(appGroupValuesProvider, asReload: true);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('App Groups を再同期しました')),
      );
    }
  }
}
