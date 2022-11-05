// ignore_for_file: lines_longer_than_80_chars

import 'package:eqmonitor/ui/view/setting/component/custom_switch.dart';
import 'package:eqmonitor/ui/view/setting/component/setting_section.dart';
import 'package:eqmonitor/ui/view/setting/notification_setting.viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/init/shared_preferences.dart';
import '../../../provider/setting/developer_mode.dart';
import '../../../provider/setting/notification_settings.dart';
import '../../theme/jma_intensity.dart';
import 'component/background_widget.dart';

class NotificationSettingPage extends HookConsumerWidget {
  const NotificationSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = NotificationSettingViewModel(ref);
    final isDeveloper = ref.watch(developerModeProvider).isDeveloper;

    final notificationSetting = ref.watch(notificationSettingsProvider);
    const descriptionTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    const titleTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
    final t = Theme.of(context);
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
                Card(
                  margin: const EdgeInsets.all(12),
                  color: t.colorScheme.secondaryContainer.withOpacity(0.4),
                  elevation: 0,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                        child: Text(
                          '以下の条件のうちのいずれかに合致した場合に通知します',
                          style: descriptionTextStyle,
                        ),
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
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
                              : '${notificationSetting.intensityThreshold.longName}以上',
                        ),
                        onTap: () async => viewModel.onIntensityTap(context),
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
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
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    '精度の低い緊急地震速報を通知する',
                    style: titleTextStyle,
                  ),
                  subtitle: const Text(
                    '1点観測点による緊急地震速報や、仮定震源要素を用いた緊急地震速報のことを指します\n'
                    '高度利用者向けの緊急地震速報に関する十分な知識がある方のみ有効にしてください',
                    style: descriptionTextStyle,
                  ),
                  trailing: CustomSwitch(
                    onChanged: (_) => viewModel.toggleLowPrecision(),
                    value: notificationSetting.lowPrecision,
                  ),
                  onTap: () async => viewModel.toggleLowPrecision(),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: const Text(
                    '地震・津波に関する情報を通知する',
                    style: titleTextStyle,
                  ),
                  subtitle: const Text(
                    '地震・津波の試験・訓練配信のお知らせ、自治体震度データの入電停止等のお知らせ等を通知します',
                    style: descriptionTextStyle,
                  ),
                  onTap: viewModel.toggleVzse40,
                  trailing: CustomSwitch(
                    onChanged: (_) => viewModel.toggleVzse40(),
                    value: notificationSetting.isRecieveVzse40,
                  ),
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
                    '通知の際に、地震情報を合成音声で読み上げます',
                    style: descriptionTextStyle,
                  ),
                  trailing: CustomSwitch(
                    onChanged: (_) => viewModel.toggleUseTts(),
                    value: notificationSetting.useTts,
                  ),
                  onTap: () async => viewModel.toggleUseTts(),
                ),
              ],
            ),
            if (isDeveloper || kDebugMode) ...[
              const Divider(),
              SettingsSection(
                title: 'Developer Mode',
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    title: const Text(
                      'テスト報を受信',
                      style: titleTextStyle,
                    ),
                    subtitle: const Text(
                      '再起動後から有効になります',
                      style: descriptionTextStyle,
                    ),
                    onTap: viewModel.toggleTestNotification,
                    trailing: CustomSwitch(
                      onChanged: (_) => viewModel.toggleTestNotification(),
                      value: notificationSetting.isRecieveTraining,
                    ),
                  ),
                  const BackgroundWidget(),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
