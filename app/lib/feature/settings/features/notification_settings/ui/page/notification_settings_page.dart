import 'package:app_settings/app_settings.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/general_notification_settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
          const Divider(height: 1),
          const SettingsSectionHeader(text: 'ツール'),
          ListTile(
            title: const Text('通知履歴'),
            subtitle: const Text('最近受信した通知の一覧を確認できます'),
            leading: const Icon(Icons.history),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async =>
                const NotificationHistoryRoute().push<void>(context),
          ),
          const _TestNotificationTile(),
          const _AndroidNotificationSettingsTile(),
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
              : (value) async {
                  await GeneralNotificationSettingsNotifier.saveMutation.run(
                    ref,
                    (tsx) async {
                      await tsx
                          .get(generalNotificationSettingsProvider.notifier)
                          .save(
                            tsunamiEnabled: value,
                            trainingEnabled: settings.trainingEnabled,
                          );
                    },
                  );
                },
        ),
        AppSwitchListTile(
          title: '訓練報・試験報の通知',
          subtitle: '訓練・試験目的の通知を受け取ります',
          value: settings.trainingEnabled,
          onChanged: isSaving
              ? null
              : (value) async {
                  await GeneralNotificationSettingsNotifier.saveMutation.run(
                    ref,
                    (tsx) async {
                      await tsx
                          .get(generalNotificationSettingsProvider.notifier)
                          .save(
                            tsunamiEnabled: settings.tsunamiEnabled,
                            trainingEnabled: value,
                          );
                    },
                  );
                },
        ),
      ],
    );
  }
}

class _TestNotificationTile extends HookConsumerWidget {
  const _TestNotificationTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingKind = useState<TestNotificationKind?>(null);

    Future<void> send(TestNotificationKind kind) async {
      pendingKind.value = kind;
      final messenger = ScaffoldMessenger.of(context);
      final deviceId = await ref.read(deviceIdProvider.future);
      final repo = await ref.read(pushNotificationRepositoryProvider.future);
      final result = await repo.sendTestNotification(
        deviceId: deviceId,
        kind: kind,
      );
      if (!context.mounted) {
        return;
      }
      pendingKind.value = null;
      switch (result) {
        case Success(:final value):
          messenger.showSnackBar(
            SnackBar(
              content: Text(
                '送信しました（${value.framework.displayLabel}）: ${value.message}',
              ),
            ),
          );
        case Failure(:final exception):
          messenger.showSnackBar(
            SnackBar(
              content: Text('送信に失敗しました: $exception'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
      }
    }

    return ListTile(
      title: const Text('テスト通知を送信'),
      subtitle: const Text('通知が正しく届くか確認できます'),
      leading: const Icon(Icons.send_outlined),
      onTap: pendingKind.value != null
          ? null
          : () async {
              await showModalBottomSheet<void>(
                context: context,
                builder: (context) => SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'テスト通知',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '送信する通知の種類を選んでください',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: TestNotificationKind.values.map((kind) {
                            return FilledButton.tonal(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await send(kind);
                              },
                              child: Text(kind.displayLabel),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
      trailing: pendingKind.value != null
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
            )
          : const Icon(Icons.chevron_right),
    );
  }
}

class _AndroidNotificationSettingsTile extends StatelessWidget {
  const _AndroidNotificationSettingsTile();

  @override
  Widget build(BuildContext context) {
    // iOS では Android のチャンネル設定は不要
    if (Theme.of(context).platform != TargetPlatform.android) {
      return const SizedBox.shrink();
    }
    return ListTile(
      title: const Text('Android 通知チャンネル設定'),
      subtitle: const Text('チャンネルごとに音・バイブなどをカスタマイズできます'),
      leading: const Icon(Icons.tune_outlined),
      trailing: const Icon(Icons.open_in_new),
      onTap: () async => AppSettings.openAppSettings(
        type: AppSettingsType.notification,
      ),
    );
  }
}
