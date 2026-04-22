import 'dart:async';

import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/general_notification_settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('通知設定')),
      body: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(generalNotificationSettingsProvider);

    return Skeletonizer(
      enabled: settingsAsync.isLoading,
      child: ListView(
        children: [
          const SettingsSectionHeader(text: '全般'),
          _GeneralSettingsSection(
            settings: settingsAsync.value ??
                const GeneralNotificationSettings(
                  tsunamiEnabled: true,
                  trainingEnabled: false,
                ),
          ),
          if (settingsAsync.hasError)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                '設定の読み込みに失敗しました',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          const Divider(height: 1),
          const SettingsSectionHeader(text: '詳細設定'),
          ListTile(
            title: const Text('緊急地震速報 (EEW)'),
            leading: const Icon(Icons.warning_amber_outlined),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async => const EewSettingsRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('地震情報'),
            leading: const Icon(Icons.place_outlined),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async =>
                const EarthquakeSettingsRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('揺れ検知'),
            leading: const Icon(Icons.vibration),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async =>
                const ShakeDetectionSettingsRoute().push<void>(context),
          ),
        ],
      ),
    );
  }
}

class _GeneralSettingsSection extends ConsumerWidget {
  const _GeneralSettingsSection({required this.settings});

  final GeneralNotificationSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveState = ref.watch(
      GeneralNotificationSettingsNotifier.saveMutation,
    );
    final isSaving = saveState is MutationPending;

    return Column(
      children: [
        AppSwitchListTile(
          title: '津波情報の通知',
          subtitle: '津波に関する通知を受け取ります',
          value: settings.tsunamiEnabled,
          onChanged: isSaving
              ? null
              : (value) {
                  unawaited(
                    GeneralNotificationSettingsNotifier.saveMutation.run(
                      ref,
                      (tsx) async {
                        await tsx
                            .get(generalNotificationSettingsProvider.notifier)
                            .save(
                              tsunamiEnabled: value,
                              trainingEnabled: settings.trainingEnabled,
                            );
                      },
                    ),
                  );
                },
        ),
        AppSwitchListTile(
          title: '訓練報・試験報の通知',
          subtitle: '訓練・試験目的の通知を受け取ります',
          value: settings.trainingEnabled,
          onChanged: isSaving
              ? null
              : (value) {
                  unawaited(
                    GeneralNotificationSettingsNotifier.saveMutation.run(
                      ref,
                      (tsx) async {
                        await tsx
                            .get(generalNotificationSettingsProvider.notifier)
                            .save(
                              tsunamiEnabled: settings.tsunamiEnabled,
                              trainingEnabled: value,
                            );
                      },
                    ),
                  );
                },
        ),
      ],
    );
  }
}
