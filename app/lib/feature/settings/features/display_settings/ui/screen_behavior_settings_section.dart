import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/screen_behavior/data/notifier/screen_behavior_settings_notifier.dart';
import 'package:eqmonitor/core/screen_behavior/data/provider/screen_behavior_platform.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class ScreenBehaviorSettingsSection extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(screenBehaviorSettingsProvider);
    final keepAwakeMutation = ref.watch(
      ScreenBehaviorSettingsNotifier.keepScreenAwakeMutation,
    );
    final lockScreenMutation = ref.watch(
      ScreenBehaviorSettingsNotifier.showWhenLockedMutation,
    );
    final busy =
        settings.isLoading ||
        settings.hasError ||
        keepAwakeMutation is MutationPending ||
        lockScreenMutation is MutationPending;
    return Column(
      crossAxisAlignment: .start,
      children: [
        const SettingsSectionHeader(text: '画面の動作'),
        AppSwitchListTile(
          title: '画面の点灯を維持',
          subtitle: 'アプリを表示している間、画面が自動で消灯しないようにします',
          value: settings.value?.keepScreenAwake ?? false,
          onChanged: busy
              ? null
              : (enabled) async => ScreenBehaviorSettingsNotifier
                    .keepScreenAwakeMutation
                    .run(ref, (tsx) async {
                      await tsx
                          .get(screenBehaviorSettingsProvider.notifier)
                          .setKeepScreenAwake(enabled: enabled);
                    })
                    .onError((error, stackTrace) {
                      talker.error(
                        'Failed to save screen wake lock setting',
                        error,
                        stackTrace,
                      );
                    }),
        ),
        if (ref.watch(supportsLockScreenDisplayProvider))
          AppSwitchListTile(
            title: 'ロック画面上に表示',
            subtitle: '端末のロック中もアプリ画面を表示し、表示時に画面を点灯します',
            value: settings.value?.showWhenLocked ?? true,
            onChanged: busy
                ? null
                : (enabled) async => ScreenBehaviorSettingsNotifier
                      .showWhenLockedMutation
                      .run(ref, (tsx) async {
                        await tsx
                            .get(screenBehaviorSettingsProvider.notifier)
                            .setShowWhenLocked(enabled: enabled);
                      })
                      .onError((error, stackTrace) {
                        talker.error(
                          'Failed to save lock screen display setting',
                          error,
                          stackTrace,
                        );
                      }),
          ),
        if (settings.hasError)
          ListTile(
            title: const Text('画面の設定を読み込めませんでした'),
            subtitle: const Text('タップして再読み込み'),
            onTap: () => ref.invalidate(screenBehaviorSettingsProvider),
          ),
        if (keepAwakeMutation is MutationError ||
            lockScreenMutation is MutationError)
          const ListTile(
            title: Text('設定を保存できませんでした。もう一度お試しください。'),
          ),
      ],
    );
  }
}
