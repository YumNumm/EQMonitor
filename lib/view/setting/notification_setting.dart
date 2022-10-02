import 'package:eqmonitor/provider/init/shared_preferences.dart';
import 'package:eqmonitor/provider/setting/notification_settings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

class NotificationSettingPage extends HookConsumerWidget {
  const NotificationSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationSetting = ref.watch(notificationSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('通知設定'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await ref.read(notificationSettingsProvider.notifier).save();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('保存しました'),
            ),
          );
          await ref.read(sharedPreferencesProvder).reload();
        },
        icon: const Icon(Icons.save),
        label: const Text('保存'),
      ),
      body: SettingsList(
        sections: [
          const SettingsSection(
            title: Text('通知条件'),
            tiles: <SettingsTile>[],
          ),
          SettingsSection(
            title: const Text('読み上げ'),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                title: const Text('地震情報の読み上げ'),
                leading: const Icon(Icons.speaker_notes),
                initialValue: notificationSetting.useTts,
                onToggle: (_) => ref
                    .read(notificationSettingsProvider.notifier)
                    .toggleUseTts(),

              ),
            ],
          ),
        ],
      ),
    );
  }
}
