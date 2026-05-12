import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
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
    final result = await AdaptiveAlertDialog.inputShow(
      context: context,
      title: 'apiServerUrl を編集',
      input: AdaptiveAlertDialogInput(
        placeholder: 'https://v2.api.eqmonitor.app',
        initialValue: current ?? '',
        keyboardType: TextInputType.url,
      ),
      actions: [
        AlertAction(
          title: 'キャンセル',
          style: AlertActionStyle.cancel,
          onPressed: () {},
        ),
        AlertAction(
          title: '保存',
          style: AlertActionStyle.primary,
          onPressed: () {},
        ),
      ],
    );
    if (result == null) {
      return;
    }
    final prefs = await ref.read(appGroupPreferencesProvider.future);
    await prefs.setString('apiServerUrl', result);
    ref
      ..invalidate(appGroupValuesProvider)
      ..invalidate(appGroupSettingsWriterProvider);
  }

  Future<void> setDebugMode(WidgetRef ref, {required bool value}) async {
    final prefs = await ref.read(appGroupPreferencesProvider.future);
    await prefs.setBool('debugMode', value);
    ref
      ..invalidate(appGroupValuesProvider)
      ..invalidate(appGroupSettingsWriterProvider);
  }

  Future<void> syncFromProvider(WidgetRef ref, BuildContext context) async {
    ref.invalidate(appGroupSettingsWriterProvider);
    await ref.read(appGroupSettingsWriterProvider.future);
    ref.invalidate(appGroupValuesProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('App Groups を再同期しました')),
      );
    }
  }
}
