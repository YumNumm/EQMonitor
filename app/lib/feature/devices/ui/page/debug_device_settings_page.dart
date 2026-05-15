import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/devices/data/retry/retry_controller.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/model/push_notification_log.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_device_settings_page.g.dart';

class DebugDeviceSettingsPage extends HookConsumerWidget {
  const DebugDeviceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceIdAsync = ref.watch(deviceIdProvider);
    final syncSnapshot = ref.watch(pushTokenSyncProvider);

    Future<void> onRefresh() async {
      ref.invalidate(deviceProvisioningProvider);
      ref.invalidate(pushTokenSyncProvider);
      await ref.read(deviceProvisioningProvider.future);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('デバイス・通知')),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList.list(
              children: [
                const SizedBox(height: 8),
                _ProvisioningStartupSection(deviceIdAsync: deviceIdAsync),
                _DeviceInfoSection(deviceIdAsync: deviceIdAsync),
                const _NotificationPermissionSection(),
                _TokenSection(syncSnapshot: syncSnapshot),
                if (deviceIdAsync.hasValue)
                  _NotificationSettingsSection(
                    deviceId: deviceIdAsync.requireValue,
                  ),
                if (deviceIdAsync.hasValue)
                  _TestNotificationSection(
                    deviceId: deviceIdAsync.requireValue,
                  ),
                if (deviceIdAsync.hasValue)
                  _HistorySection(deviceId: deviceIdAsync.requireValue),
                const SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── プロビジョニング起動状態セクション ──────────────────────────────────────

class _ProvisioningStartupSection extends ConsumerStatefulWidget {
  const _ProvisioningStartupSection({required this.deviceIdAsync});

  final AsyncValue<String> deviceIdAsync;

  @override
  ConsumerState<_ProvisioningStartupSection> createState() =>
      _ProvisioningStartupSectionState();
}

class _ProvisioningStartupSectionState
    extends ConsumerState<_ProvisioningStartupSection> {
  Timer? _timer;
  RetryControllerState _retryState = const RetryIdle();
  Duration _waitRemaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        _tick();
      }
    });
  }

  void _tick() {
    final rs = ref.read(deviceProvisioningProvider.notifier).retryState;
    setState(() {
      _retryState = rs;
      if (rs is RetryWaiting) {
        final diff = rs.resumeAt.difference(DateTime.now());
        _waitRemaining = diff.isNegative ? Duration.zero : diff;
      } else {
        _waitRemaining = Duration.zero;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provisionStatus = ref.watch(deviceProvisioningProvider);
    final provisionMutation =
        ref.watch(DeviceProvisioningNotifier.provisionMutation);
    final isProvisioned = ref.watch(_isProvisionedProvider);
    final legacyId = ref.watch(_legacyDeviceIdProvider);

    final isLoading = provisionMutation is MutationPending;
    final scheme = Theme.of(context).colorScheme;

    final statusText = switch (provisionStatus) {
      AsyncData(:final value) =>
        value == DeviceProvisioningStatus.notRequired ? '登録済み' : '未登録',
      AsyncError(:final error) => 'エラー: $error',
      _ => '取得中…',
    };

    final retryChip = switch (_retryState) {
      RetryIdle() => _StatusChip(
        label: 'アイドル',
        color: scheme.secondaryContainer,
        textColor: scheme.onSecondaryContainer,
      ),
      RetryRunning(:final attempt) => _StatusChip(
        label: '実行中 (試行 ${attempt + 1})',
        color: scheme.tertiaryContainer,
        textColor: scheme.onTertiaryContainer,
        icon: Icons.sync,
      ),
      RetryWaiting(:final attempt) => _StatusChip(
        label: '待機中 (試行 ${attempt + 1}, ${_waitRemaining.inSeconds}s後)',
        color: scheme.secondaryContainer,
        textColor: scheme.onSecondaryContainer,
        icon: Icons.schedule,
      ),
      RetryExhausted(:final lastError) => _StatusChip(
        label: '失敗: ${lastError.userMessage}',
        color: scheme.errorContainer,
        textColor: scheme.onErrorContainer,
        icon: Icons.error_outline,
      ),
    };

    final needsProvision =
        provisionStatus.value == DeviceProvisioningStatus.required ||
        _retryState is RetryExhausted;

    return _SectionCard(
      title: '起動時プロビジョニング',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _KeyValueRow(
            label: 'Device ID',
            value: widget.deviceIdAsync.value ?? '…',
          ),
          _KeyValueRow(
            label: '保存済みフラグ',
            value: isProvisioned ? '登録済み (true)' : '未登録 (false)',
          ),
          _KeyValueRow(label: 'サーバー状態', value: statusText),
          _KeyValueRow(
            label: 'レガシーID',
            value: legacyId != null ? '存在 → 移行対象' : 'なし',
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                'リトライ状態: ',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 4),
              retryChip,
            ],
          ),
          if (_retryState is RetryWaiting) ...[
            const SizedBox(height: 4),
            Text(
              (_retryState as RetryWaiting).lastError.userMessage,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
          if (isLoading) ...[
            const SizedBox(height: 12),
            const Row(
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                ),
                SizedBox(width: 8),
                Text('プロビジョニング中…'),
              ],
            ),
          ] else if (needsProvision) ...[
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {
                ref.read(deviceProvisioningProvider.notifier).reset();
                unawaited(
                  DeviceProvisioningNotifier.provisionMutation.run(
                    ref,
                    (tsx) async =>
                        tsx.get(deviceProvisioningProvider.notifier).provision(),
                  ),
                );
              },
              icon: const Icon(Icons.cloud_upload_outlined, size: 18),
              label: const Text('プロビジョニング実行'),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.color,
    required this.textColor,
    this.icon,
  });

  final String label;
  final Color color;
  final Color textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: textColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ── OS通知許可セクション ──────────────────────────────────────────────────────

class _NotificationPermissionSection extends ConsumerWidget {
  const _NotificationPermissionSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permAsync = ref.watch(_osNotificationPermissionProvider);
    final scheme = Theme.of(context).colorScheme;

    return _SectionCard(
      title: '通知許可状態（OS）',
      trailing: IconButton(
        tooltip: '再取得',
        icon: const Icon(Icons.refresh),
        onPressed: () => ref.invalidate(_osNotificationPermissionProvider),
      ),
      child: switch (permAsync) {
        AsyncData(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _KeyValueRow(
              label: '許可状態',
              value: _authLabel(value.authorizationStatus),
            ),
            _KeyValueRow(
              label: 'アラート',
              value: _appleLabel(value.alert),
            ),
            _KeyValueRow(label: 'バッジ', value: _appleLabel(value.badge)),
            _KeyValueRow(label: 'サウンド', value: _appleLabel(value.sound)),
            if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) ...[
              _KeyValueRow(
                label: '通知センター',
                value: _appleLabel(value.notificationCenter),
              ),
              _KeyValueRow(
                label: 'ロック画面',
                value: _appleLabel(value.lockScreen),
              ),
              _KeyValueRow(
                label: 'クリティカル',
                value: _appleLabel(value.criticalAlert),
              ),
              _KeyValueRow(
                label: '時間依存',
                value: _appleLabel(value.timeSensitive),
              ),
            ],
          ],
        ),
        AsyncError(:final error) => Text(
          'エラー: $error',
          style: TextStyle(color: scheme.error),
        ),
        _ => const Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      },
    );
  }

  String _authLabel(AuthorizationStatus s) => switch (s) {
    AuthorizationStatus.authorized => '許可済み',
    AuthorizationStatus.denied => '拒否',
    AuthorizationStatus.notDetermined => '未確認',
    AuthorizationStatus.provisional => '仮承認（サイレント通知のみ）',
  };

  String _appleLabel(AppleNotificationSetting s) => switch (s) {
    AppleNotificationSetting.enabled => '有効',
    AppleNotificationSetting.disabled => '無効',
    AppleNotificationSetting.notSupported => '非対応',
  };
}

// ── デバイス情報（サーバー取得）────────────────────────────────────────────

class _DeviceInfoSection extends ConsumerWidget {
  const _DeviceInfoSection({required this.deviceIdAsync});

  final AsyncValue<String> deviceIdAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceAsync = ref.watch(
      _deviceInfoProvider(deviceIdAsync.value ?? ''),
    );

    return _SectionCard(
      title: 'デバイス（サーバー情報）',
      child: switch (deviceAsync) {
        AsyncData(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _KeyValueRow(label: 'サーバー上の ID', value: value.id),
            _KeyValueRow(label: 'ユーザー', value: value.userId ?? '未登録'),
            _KeyValueRow(label: '種別', value: value.platform.displayLabel),
          ],
        ),
        AsyncError(:final error) => Text(
          'デバイス情報の取得に失敗: $error',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        _ => const Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      },
    );
  }
}

@riverpod
Future<RegisteredDevice> _deviceInfo(Ref ref, String deviceId) async {
  if (deviceId.isEmpty) {
    throw ArgumentError('deviceId is empty');
  }
  final repo = await ref.watch(deviceRepositoryProvider.future);
  final result = await repo.getDevice(deviceId);
  return switch (result) {
    Success(:final value) => value,
    Failure(:final exception) => throw exception,
  };
}

// ── プッシュトークン同期 ────────────────────────────────────────────────────

class _TokenSection extends StatelessWidget {
  const _TokenSection({required this.syncSnapshot});

  final AsyncValue<PushTokenSyncSnapshot> syncSnapshot;

  @override
  Widget build(BuildContext context) {
    final snapshot = syncSnapshot.value;

    return _SectionCard(
      title: 'プッシュトークン同期',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TokenStatusRow(label: 'FCM', kindState: snapshot?.fcm),
          const SizedBox(height: 6),
          _TokenStatusRow(
            label: 'APNs（通知）',
            kindState: snapshot?.apnsNotification,
          ),
          const SizedBox(height: 6),
          _TokenStatusRow(
            label: 'Push to Start',
            kindState: snapshot?.apnsPushToStart,
          ),
        ],
      ),
    );
  }
}

class _TokenStatusRow extends StatelessWidget {
  const _TokenStatusRow({required this.label, required this.kindState});

  final String label;
  final PushTokenKindState? kindState;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (icon, color, statusText) = switch (kindState) {
      SyncedTokenState() => (Icons.check_circle, scheme.primary, '同期済み'),
      PendingTokenState() => (Icons.sync, scheme.secondary, '同期待ち'),
      FailedTokenState(:final error) => (
        Icons.error_outline,
        scheme.error,
        'エラー: ${error.userMessage}',
      ),
      AbsentTokenState() => (
        Icons.radio_button_unchecked,
        scheme.outline,
        '未取得',
      ),
      NotApplicableTokenState() => (
        Icons.remove_circle_outline,
        scheme.outline,
        '非対応',
      ),
      null => (Icons.hourglass_empty, scheme.outline, '…'),
    };

    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label: $statusText',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

// ── 全般通知設定 ────────────────────────────────────────────────────────────

class _NotificationSettingsSection extends HookConsumerWidget {
  const _NotificationSettingsSection({required this.deviceId});

  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(
      _notificationSettingsProvider(deviceId),
    );
    final settings = settingsAsync.value;
    final isBusy = useState(false);
    final tsunami = useState(settings?.tsunamiEnabled ?? false);
    final training = useState(settings?.trainingEnabled ?? false);

    ref.listen(_notificationSettingsProvider(deviceId), (_, next) {
      if (next.value != null) {
        tsunami.value = next.requireValue.tsunamiEnabled;
        training.value = next.requireValue.trainingEnabled;
      }
    });

    Future<void> submit() async {
      if (isBusy.value) {
        return;
      }
      isBusy.value = true;
      final messenger = ScaffoldMessenger.of(context);
      final notificationRepository = await ref.read(
        pushNotificationRepositoryProvider.future,
      );
      final result = await notificationRepository.patchNotificationSettings(
        deviceId: deviceId,
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
          ref.invalidate(_notificationSettingsProvider(deviceId));
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
      child: settings == null
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Column(
              children: [
                AppSwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: '津波情報の通知',
                  subtitle: 'training / 訓練報とは別の津波関連通知',
                  value: tsunami.value,
                  onChanged: isBusy.value ? null : (v) => tsunami.value = v,
                ),
                AppSwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: '訓練報・試験報の通知',
                  value: training.value,
                  onChanged: isBusy.value ? null : (v) => training.value = v,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: isBusy.value ? null : submit,
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

@riverpod
Future<GeneralNotificationSettings> _notificationSettings(
  Ref ref,
  String deviceId,
) async {
  if (deviceId.isEmpty) {
    throw ArgumentError('deviceId is empty');
  }
  final repo = await ref.watch(pushNotificationRepositoryProvider.future);
  final result = await repo.getNotificationSettings(deviceId);
  return switch (result) {
    Success(:final value) => value,
    Failure(:final exception) => throw exception,
  };
}

// ── テスト通知 ───────────────────────────────────────────────────────────────

class _TestNotificationSection extends HookConsumerWidget {
  const _TestNotificationSection({required this.deviceId});

  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingKind = useState<TestNotificationKind?>(null);

    Future<void> send(TestNotificationKind kind) async {
      pendingKind.value = kind;
      final messenger = ScaffoldMessenger.of(context);
      final notificationRepository = await ref.read(
        pushNotificationRepositoryProvider.future,
      );
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
        children:
            [
              TestNotificationKind.silent,
              TestNotificationKind.normal,
              TestNotificationKind.critical,
            ].map((kind) {
              final isPending = pendingKind.value == kind;
              return FilledButton.tonal(
                onPressed: pendingKind.value != null && !isPending
                    ? null
                    : () async => send(kind),
                child: isPending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                        ),
                      )
                    : Text(kind.displayLabel),
              );
            }).toList(),
      ),
    );
  }
}

// ── 通知履歴 ─────────────────────────────────────────────────────────────────

class _HistorySection extends ConsumerWidget {
  const _HistorySection({required this.deviceId});

  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(_notificationHistoryProvider(deviceId));

    return _SectionCard(
      title: '通知履歴',
      trailing: IconButton(
        tooltip: '更新',
        onPressed: () => ref.invalidate(_notificationHistoryProvider(deviceId)),
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
          itemBuilder: (context, index) =>
              _NotificationHistoryTile(item: value[index]),
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

@riverpod
Future<List<PushNotificationLogEntry>> _notificationHistory(
  Ref ref,
  String deviceId,
) async {
  if (deviceId.isEmpty) {
    throw ArgumentError('deviceId is empty');
  }
  final repo = await ref.watch(pushNotificationRepositoryProvider.future);
  final result = await repo.getNotificationHistory(deviceId: deviceId, limit: 50);
  return switch (result) {
    Success(:final value) => value.items,
    Failure(:final exception) => throw exception,
  };
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
      subtitle: Text(subtitle, maxLines: 4, overflow: TextOverflow.ellipsis),
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

// ── Riverpod プロバイダー ──────────────────────────────────────────────────

@riverpod
bool _isProvisioned(Ref ref) {
  final repo = ref.watch(deviceProvisioningRepositoryProvider);
  return repo.isProvisioned();
}

@riverpod
String? _legacyDeviceId(Ref ref) {
  final repo = ref.watch(deviceProvisioningRepositoryProvider);
  return repo.readLegacyDeviceId();
}

@riverpod
Future<NotificationSettings> _osNotificationPermission(Ref ref) async {
  final messaging = ref.watch(firebaseMessagingProvider);
  return messaging.getNotificationSettings();
}

// ── 共通ウィジェット ───────────────────────────────────────────────────────

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
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
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
