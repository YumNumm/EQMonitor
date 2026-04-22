import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/provider/debug_device_settings_providers.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/model/push_notification_log.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification/data/provider/notification_token_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugDeviceSettingsPage extends HookConsumerWidget {
  const DebugDeviceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(debugDeviceSessionProvider);
    final historyAsync = ref.watch(debugNotificationHistoryProvider);

    Future<void> onRefresh() async {
      ref.invalidate(debugDeviceSessionProvider);
      ref.invalidate(debugNotificationHistoryProvider);
      await ref.read(debugDeviceSessionProvider.future);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('デバイス・通知'),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            switch (sessionAsync) {
              AsyncData(:final value) => _DeviceSettingsSliverList(
                  snapshot: value,
                  historyAsync: historyAsync,
                ),
              AsyncError(:final error, :final stackTrace) => SliverFillRemaining(
                  child: _LoadErrorBody(
                    message: error.toString(),
                    stackTrace: stackTrace,
                    onRetry: onRefresh,
                  ),
                ),
              _ => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator.adaptive()),
                ),
            },
          ],
        ),
      ),
    );
  }
}

class _LoadErrorBody extends StatelessWidget {
  const _LoadErrorBody({
    required this.message,
    required this.stackTrace,
    required this.onRetry,
  });

  final String message;
  final StackTrace stackTrace;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: scheme.error),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: scheme.onSurface),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () async => onRetry(),
            icon: const Icon(Icons.refresh),
            label: const Text('再試行'),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(text: '$message\n\n$stackTrace'),
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('エラーをクリップボードにコピーしました')),
                );
              }
            },
            child: const Text('詳細をコピー'),
          ),
        ],
      ),
    );
  }
}

class _DeviceSettingsSliverList extends ConsumerWidget {
  const _DeviceSettingsSliverList({
    required this.snapshot,
    required this.historyAsync,
  });

  final DebugDeviceSessionSnapshot snapshot;
  final AsyncValue<List<PushNotificationLogEntry>> historyAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenAsync = ref.watch(notificationTokenStreamProvider);
    final token = tokenAsync.value;

    return SliverList.list(
      children: [
        const SizedBox(height: 8),
        _SectionCard(
          title: 'デバイス',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _KeyValueRow(label: 'Device ID', value: snapshot.deviceId),
              const Divider(height: 24),
              _KeyValueRow(
                label: 'サーバー上の ID',
                value: snapshot.device.id,
              ),
              _KeyValueRow(
                label: 'ユーザー',
                value: snapshot.device.userId ?? '未登録',
              ),
              _KeyValueRow(
                label: '種別',
                value: snapshot.device.platform.displayLabel,
              ),
            ],
          ),
        ),
        _SectionCard(
          title: 'ローカルのプッシュトークン',
          subtitle: '表示されているトークンはサーバーへ同期済みです（画面表示時）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TokenChip(
                label: 'FCM',
                isPresent: _hasNonEmptyText(token?.fcmToken),
              ),
              const SizedBox(height: 8),
              _TokenChip(
                label: 'APNs（通知）',
                isPresent: _hasNonEmptyText(token?.apnsToken),
              ),
              const SizedBox(height: 8),
              _TokenChip(
                label: 'Push to Start',
                isPresent: _hasNonEmptyText(token?.apnsPushToStartToken),
              ),
            ],
          ),
        ),
        _NotificationSettingsSection(snapshot: snapshot),
        _TestNotificationSection(deviceId: snapshot.deviceId),
        _HistorySection(historyAsync: historyAsync),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _NotificationSettingsSection extends HookConsumerWidget {
  const _NotificationSettingsSection({required this.snapshot});

  final DebugDeviceSessionSnapshot snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusy = useState(false);
    final tsunami = useState(snapshot.notificationSettings.tsunamiEnabled);
    final training = useState(snapshot.notificationSettings.trainingEnabled);

    Future<void> submit() async {
      if (isBusy.value) {
        return;
      }
      isBusy.value = true;
      final messenger = ScaffoldMessenger.of(context);
      final notificationRepository = await ref.read(pushNotificationRepositoryProvider.future);
      final result = await notificationRepository.patchNotificationSettings(
        deviceId: snapshot.deviceId,
        settings: GeneralNotificationSettings(
          tsunamiEnabled: tsunami.value,
          trainingEnabled: training.value,
        ),
      );
      isBusy.value = false;
      if (!context.mounted) {
        return;
      }
      switch (result) {
        case Success():
          ref.invalidate(debugDeviceSessionProvider);
          messenger.showSnackBar(
            const SnackBar(content: Text('通知設定を更新しました')),
          );
        case Failure(:final exception):
          messenger.showSnackBar(
            SnackBar(
              content: Text('更新に失敗しました: $exception'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
      }
    }

    return _SectionCard(
      title: '全般通知設定',
      child: Column(
        children: [
          AppSwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: '津波情報の通知',
            subtitle: 'training / 訓練報とは別の津波関連通知',
            value: tsunami.value,
            onChanged: isBusy.value
                ? null
                : (v) {
                    tsunami.value = v;
                  },
          ),
          AppSwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: '訓練報・試験報の通知',
            value: training.value,
            onChanged: isBusy.value
                ? null
                : (v) {
                    training.value = v;
                  },
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: isBusy.value
                  ? null
                  : () async {
                      await submit();
                    },
              child: isBusy.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('設定をサーバーに反映'),
            ),
          ),
        ],
      ),
    );
  }
}

class _TestNotificationSection extends HookConsumerWidget {
  const _TestNotificationSection({required this.deviceId});

  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingKind = useState<TestNotificationKind?>(null);

    Future<void> send(TestNotificationKind kind) async {
      pendingKind.value = kind;
      final messenger = ScaffoldMessenger.of(context);
      final notificationRepository = await ref.read(pushNotificationRepositoryProvider.future);
      final result = await notificationRepository.sendTestNotification(
        deviceId: deviceId,
        kind: kind,
      );
      pendingKind.value = null;
      if (!context.mounted) {
        return;
      }
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
              content: Text('送信に失敗: $exception'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
      }
    }

    return _SectionCard(
      title: 'テスト通知',
      subtitle: 'サイレント・通常・クリティカルをサーバー経由で送信します',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          TestNotificationKind.silent,
          TestNotificationKind.normal,
          TestNotificationKind.critical,
        ].map((kind) {
          final isPending = pendingKind.value == kind;
          return FilledButton.tonal(
            onPressed: pendingKind.value != null && !isPending
                ? null
                : () async {
                    await send(kind);
                  },
            child: isPending
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                  )
                : Text(kind.displayLabel),
          );
        }).toList(),
      ),
    );
  }
}

class _HistorySection extends ConsumerWidget {
  const _HistorySection({required this.historyAsync});

  final AsyncValue<List<PushNotificationLogEntry>> historyAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _SectionCard(
      title: '通知履歴',
      trailing: IconButton(
        tooltip: '更新',
        onPressed: () {
          ref.invalidate(debugNotificationHistoryProvider);
        },
        icon: const Icon(Icons.refresh),
      ),
      child: switch (historyAsync) {
        AsyncData(:final value) when value.isEmpty => Text(
            '履歴はまだありません',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        AsyncData(:final value) => ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = value[index];
              return _NotificationHistoryTile(item: item);
            },
          ),
        AsyncError(:final error) => Text(
            '履歴の取得に失敗: $error',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        _ => const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
      },
    );
  }
}

class _NotificationHistoryTile extends StatelessWidget {
  const _NotificationHistoryTile({required this.item});

  final PushNotificationLogEntry item;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ok = item.result == PushNotificationDeliveryResult.ok;
    final resultColor = ok ? scheme.primary : scheme.error;
    final subtitle = [
      item.framework.displayLabel,
      item.result.displayLabel,
      if (item.title != null) item.title,
      if (item.body != null) item.body,
      if (item.errorMessage != null) item.errorMessage,
    ].join(' · ');

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        _formatCreatedAt(item.createdAtIso),
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        subtitle,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(
        ok ? Icons.check_circle_outline : Icons.error_outline,
        color: resultColor,
      ),
    );
  }

  String _formatCreatedAt(String raw) {
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) {
      return raw;
    }
    final local = parsed.toLocal();
    return '${local.year}/${local.month.toString().padLeft(2, '0')}/${local.day.toString().padLeft(2, '0')} '
        '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 0,
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.65),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ],
                      ],
                    ),
                  ),
                  ?trailing,
                ],
              ),
              const SizedBox(height: 12),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _TokenChip extends StatelessWidget {
  const _TokenChip({required this.label, required this.isPresent});

  final String label;
  final bool isPresent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(
          isPresent ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 20,
          color: isPresent ? scheme.primary : scheme.outline,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            isPresent ? '$label: 取得済み' : '$label: 未取得',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

bool _hasNonEmptyText(String? value) => value != null && value.isNotEmpty;
