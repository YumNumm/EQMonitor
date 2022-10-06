import 'package:eqmonitor/provider/init/shared_preferences.dart';
import 'package:eqmonitor/provider/setting/notification_settings.dart';
import 'package:eqmonitor/ui/theme/jma_intensity.dart';
import 'package:eqmonitor/ui/view/setting/notification_setting.viewmodel.dart';
import 'package:eqmonitor/ui/view/widget/setting/custom_switch.dart';
import 'package:eqmonitor/ui/view/widget/setting/setting_section.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationSettingPage extends HookConsumerWidget {
  const NotificationSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = NotificationSettingViewModel(ref);

    final notificationSetting = ref.watch(notificationSettingsProvider);
    const descriptionTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    const titleTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsSection(
              title: '通知条件(緊急地震速報)',
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  child: Text(
                    '以下の条件のうちのいずれかに合致した場合に通知します',
                    style: descriptionTextStyle,
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    '予想最大震度のしきい値',
                    style: titleTextStyle,
                  ),
                  subtitle: const Text(
                    '予想最大震度がこの値以上のときに通知します',
                    style: descriptionTextStyle,
                  ),
                  trailing: Text(
                    (notificationSetting.intensityThreshold ==
                            JmaIntensity.Int0)
                        ? '全て'
                        : notificationSetting.intensityThreshold.longName,
                  ),
                  onTap: () async => viewModel.onIntensityTap(context),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    'マグニチュードのしきい値',
                    style: titleTextStyle,
                  ),
                  subtitle: const Text(
                    'マグニチュードがこの値以上のときに通知します',
                    style: descriptionTextStyle,
                  ),
                  trailing: Text(
                    (notificationSetting.magnitudeThreshold == 0)
                        ? '全て'
                        : 'M${notificationSetting.magnitudeThreshold}以上',
                  ),
                  onTap: () async => viewModel.onMagnitudeTap(context),
                ),
              ],
            ),
            const Divider(),
            SettingsSection(
              title: '読み上げ設定',
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    'TTSによる読み上げ',
                    style: titleTextStyle,
                  ),
                  subtitle: const Text(
                    '通知の際に、地震情報を合成音声でお知らせします',
                    style: descriptionTextStyle,
                  ),
                  trailing: CustomSwitch(
                    onChanged: (_) => viewModel.onTtsSwitchChanged(),
                    value: notificationSetting.useTts,
                  ),
                  onTap: () async => viewModel.onTtsSwitchChanged(),
                ),
              ],
            ),
          ],
        ),
      ),
      // body: SettingsList(
      //   sections: [
      //     SettingsSection(
      //       title: const Text('通知条件(緊急地震速報)'),
      //       tiles: <SettingsTile>[
      //         SettingsTile.navigation(
      //           title: const Text('予想最大震度'),
      //           description: const Text('予想最大震度が指定した値以上の場合に通知します'),
      //           leading: const Icon(Icons.upcoming),
      //           value: Text(
      //             (notificationSetting.intensityThreshold == JmaIntensity.Int0)
      //                 ? '全て'
      //                 : notificationSetting.intensityThreshold.name,
      //           ),
      //           // ポップアップ
      //
      //         ),
      //       ],
      //     ),
      //     SettingsSection(
      //       title: const Text('読み上げ'),
      //       tiles: <SettingsTile>[
      //         SettingsTile.switchTile(
      //           title: const Text('地震情報の読み上げ'),
      //           leading: const Icon(Icons.speaker_notes),
      //           initialValue: notificationSetting.useTts,
      //           onToggle: (_) => ref
      //               .read(notificationSettingsProvider.notifier)
      //               .toggleUseTts(),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
