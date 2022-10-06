import 'package:eqmonitor/provider/init/shared_preferences.dart';
import 'package:eqmonitor/provider/setting/notification_settings.dart';
import 'package:eqmonitor/ui/theme/jma_intensity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        onPressed: () {
          ref
              .read(notificationSettingsProvider.notifier)
              .save()
              .then((_) => ref.read(sharedPreferencesProvder).reload());
          Fluttertoast.showToast(msg: '保存しました');
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.save),
        label: const Text('保存'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('通知条件(緊急地震速報)'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: const Text('予想最大震度'),
                description: const Text('予想最大震度が指定した値以上の場合に通知します'),
                leading: const Icon(Icons.emoji_events),
                value: Text(
                  (notificationSetting.intensityThreshold == JmaIntensity.Int0)
                      ? '全て'
                      : notificationSetting.intensityThreshold.name,
                ),
                // ポップアップ
              ),
            ],
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
