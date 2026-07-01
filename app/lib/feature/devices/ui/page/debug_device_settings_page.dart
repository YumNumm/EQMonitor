import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/devices/data/retry/retry_controller.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/model/push_notification_log.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
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
      ref.invalidate(deviceProvisioningProvider, asReload: true);
      ref.invalidate(pushTokenSyncProvider, asReload: true);
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
                const _SettingsProviderStatusSection(),
                if (deviceIdAsync.hasValue)
                  _NotificationSettingsSection(
                    deviceId: deviceIdAsync.requireValue,
                  ),
                if (deviceIdAsync.hasValue)
                  _TestNotificationSection(
                    deviceId: deviceIdAsync.requireValue,
                  ),
                if (deviceIdAsync.hasValue)
                  _TestScenarioSection(
                    deviceId: deviceIdAsync.requireValue,
                  ),
                if (deviceIdAsync.hasValue)
                  _TestScenarioTypeSection(
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

class _ProvisioningStartupSection extends HookConsumerWidget {
  const _ProvisioningStartupSection({required this.deviceIdAsync});

  final AsyncValue<String> deviceIdAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final retryState = useState<RetryControllerState>(const RetryIdle());
    final waitRemaining = useState(Duration.zero);

    void tick() {
      final rs = ref.read(deviceProvisioningProvider.notifier).retryState;
      retryState.value = rs;
      if (rs is RetryWaiting) {
        final diff = rs.resumeAt.difference(DateTime.now());
        waitRemaining.value = diff.isNegative ? Duration.zero : diff;
      } else {
        waitRemaining.value = Duration.zero;
      }
    }

    useEffect(() {
      tick();
      final timer = Timer.periodic(const Duration(seconds: 1), (_) => tick());
      return timer.cancel;
    }, const []);

    final provisionStatus = ref.watch(deviceProvisioningProvider);
    final provisionMutation = ref.watch(
      DeviceProvisioningNotifier.provisionMutation,
    );
    final isProvisioned = ref.watch(_isProvisionedProvider);
    final legacyId = ref.watch(_legacyDeviceIdProvider);
    final tokenPresent = ref.watch(_deviceTokenPresentProvider);

    final isLoading = provisionMutation is MutationPending;
    final colorTheme = context.designSystem.colorTheme;

    final statusText = switch (provisionStatus) {
      AsyncData(:final value) =>
        value == DeviceProvisioningStatus.notRequired ? '登録済み' : '未登録',
      AsyncError(:final error) => 'エラー: $error',
      _ => '取得中…',
    };

    final retryChip = switch (retryState.value) {
      RetryIdle() => _StatusChip(
        label: 'アイドル',
        color: colorTheme.secondaryContainer,
        textColor: colorTheme.onSecondaryContainer,
      ),
      RetryRunning(:final attempt) => _StatusChip(
        label: '実行中 (試行 ${attempt + 1})',
        color: colorTheme.tertiaryContainer,
        textColor: colorTheme.onTertiaryContainer,
        icon: Icons.sync,
      ),
      RetryWaiting(:final attempt) => _StatusChip(
        label: '待機中 (試行 ${attempt + 1}, ${waitRemaining.value.inSeconds}s後)',
        color: colorTheme.secondaryContainer,
        textColor: colorTheme.onSecondaryContainer,
        icon: Icons.schedule,
      ),
      RetryExhausted(:final lastError) => _StatusChip(
        label: '失敗: ${lastError.userMessage}',
        color: colorTheme.errorContainer,
        textColor: colorTheme.onErrorContainer,
        icon: Icons.error_outline,
      ),
    };

    final needsProvision =
        provisionStatus.value == DeviceProvisioningStatus.required ||
        retryState.value is RetryExhausted;

    return _SectionCard(
      title: '起動時プロビジョニング',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _KeyValueRow(
            label: 'Device ID',
            value: deviceIdAsync.value ?? '…',
          ),
          _KeyValueRow(
            label: '保存済みフラグ',
            value: isProvisioned ? '登録済み (true)' : '未登録 (false)',
          ),
          _KeyValueRow(
            label: 'Bearerトークン',
            value: switch (tokenPresent) {
              AsyncData(:final value) => value ? '存在' : '不在（再プロビジョニング必要）',
              AsyncError(:final error) => 'エラー: $error',
              _ => '確認中…',
            },
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
                  color: colorTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 4),
              retryChip,
            ],
          ),
          if (retryState.value is RetryWaiting) ...[
            const SizedBox(height: 4),
            Text(
              (retryState.value as RetryWaiting).lastError.userMessage,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorTheme.onSurfaceVariant,
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
                    (tsx) async => tsx
                        .get(deviceProvisioningProvider.notifier)
                        .provision(),
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
    final colorTheme = context.designSystem.colorTheme;

    return _SectionCard(
      title: '通知許可状態（OS）',
      trailing: IconButton(
        tooltip: '再取得',
        icon: const Icon(Icons.refresh),
        onPressed: () =>
            ref.invalidate(_osNotificationPermissionProvider, asReload: true),
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
          style: TextStyle(color: colorTheme.error),
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
          style: TextStyle(color: context.designSystem.colorTheme.error),
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
    final colorTheme = context.designSystem.colorTheme;
    final (icon, color, statusText) = switch (kindState) {
      SyncedTokenState() => (Icons.check_circle, colorTheme.primary, '同期済み'),
      PendingTokenState() => (Icons.sync, colorTheme.secondary, '同期待ち'),
      FailedTokenState(:final error) => (
        Icons.error_outline,
        colorTheme.error,
        'エラー: ${error.userMessage}',
      ),
      AbsentTokenState() => (
        Icons.radio_button_unchecked,
        colorTheme.outline,
        '未取得',
      ),
      NotApplicableTokenState() => (
        Icons.remove_circle_outline,
        colorTheme.outline,
        '非対応',
      ),
      null => (Icons.hourglass_empty, colorTheme.outline, '…'),
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

// ── 設定プロバイダー状態 ──────────────────────────────────────────────────────

class _SettingsProviderStatusSection extends ConsumerWidget {
  const _SettingsProviderStatusSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slots = ref.watch(notificationSlotsProvider);
    final shakeDetection = ref.watch(shakeDetectionSettingsProvider);

    return _SectionCard(
      title: '設定プロバイダー状態',
      subtitle: 'プロビジョニング完了後にロードされる',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProviderStatusRow(label: '通知スロット', state: slots),
          _ProviderStatusRow(label: '揺れ検知設定', state: shakeDetection),
        ],
      ),
    );
  }
}

class _ProviderStatusRow extends StatelessWidget {
  const _ProviderStatusRow({
    required this.label,
    required this.state,
  });

  final String label;
  final AsyncValue<Object?> state;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;
    final (icon, color, statusText) = switch (state) {
      AsyncData() => (Icons.check_circle, colorTheme.primary, 'ロード済み'),
      AsyncError(:final error) => (
        Icons.error_outline,
        colorTheme.error,
        'エラー: ${error.runtimeType}',
      ),
      _ => (Icons.hourglass_empty, colorTheme.outline, 'ロード中…'),
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: $statusText',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
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
    final notificationEnabled = useState(settings?.notificationEnabled ?? true);
    final tsunami = useState(settings?.tsunamiEnabled ?? false);
    final training = useState(settings?.trainingEnabled ?? false);
    final nankaiExtraordinary = useState(
      settings?.nankaiExtraordinaryEnabled ?? false,
    );
    final nankaiRegular = useState(settings?.nankaiRegularEnabled ?? false);
    final hokkaido3ren = useState(
      settings?.hokkaido3renOffshoreEnabled ?? false,
    );

    ref.listen(_notificationSettingsProvider(deviceId), (_, next) {
      if (next.value != null) {
        notificationEnabled.value = next.requireValue.notificationEnabled;
        tsunami.value = next.requireValue.tsunamiEnabled;
        training.value = next.requireValue.trainingEnabled;
        nankaiExtraordinary.value =
            next.requireValue.nankaiExtraordinaryEnabled;
        nankaiRegular.value = next.requireValue.nankaiRegularEnabled;
        hokkaido3ren.value = next.requireValue.hokkaido3renOffshoreEnabled;
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
          notificationEnabled: notificationEnabled.value,
          tsunamiEnabled: tsunami.value,
          trainingEnabled: training.value,
          nankaiExtraordinaryEnabled: nankaiExtraordinary.value,
          nankaiRegularEnabled: nankaiRegular.value,
          hokkaido3renOffshoreEnabled: hokkaido3ren.value,
        ),
      );
      isBusy.value = false;
      if (!context.mounted) {
        return;
      }
      switch (result) {
        case Success():
          ref.invalidate(
            _notificationSettingsProvider(deviceId),
            asReload: true,
          );
          messenger.showSnackBar(
            const SnackBar(content: Text('通知設定を更新しました')),
          );
        case Failure(:final exception):
          messenger.showSnackBar(
            SnackBar(
              content: Text('更新に失敗しました: $exception'),
              backgroundColor: context.designSystem.colorTheme.error,
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
              backgroundColor: context.designSystem.colorTheme.error,
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

// ── テストシナリオ実行 ───────────────────────────────────────────────────────

class _TestScenarioSection extends HookConsumerWidget {
  const _TestScenarioSection({required this.deviceId});

  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final isPending = useState(false);
    final lastResult = useState<TestScenarioDeliveryResult?>(null);

    Future<void> run() async {
      final eventId = controller.text.trim();
      if (eventId.isEmpty || isPending.value) {
        return;
      }
      isPending.value = true;
      final messenger = ScaffoldMessenger.of(context);
      final notificationRepository = await ref.read(
        pushNotificationRepositoryProvider.future,
      );
      final result = await notificationRepository.sendTestScenario(
        deviceId: deviceId,
        eventId: eventId,
      );
      isPending.value = false;
      if (!context.mounted) {
        return;
      }
      switch (result) {
        case Success(:final value):
          lastResult.value = value;
          messenger.showSnackBar(
            SnackBar(
              content: Text(
                'シナリオを実行しました（${value.stepsPlanned} ステップ）: '
                '${value.telegramTypes.join(', ')}',
              ),
            ),
          );
        case Failure(:final exception):
          messenger.showSnackBar(
            SnackBar(
              content: Text('実行に失敗: $exception'),
              backgroundColor: context.designSystem.colorTheme.error,
            ),
          );
      }
    }

    return _SectionCard(
      title: 'テストシナリオ実行',
      subtitle:
          'イベントIDの実データをDBから取得し、実際の通知パイプライン経由で'
          'この端末にのみ配信します（EEW + VXSE51/52/53）',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: controller,
            enabled: !isPending.value,
            textInputAction: TextInputAction.go,
            decoration: const InputDecoration(
              labelText: 'イベントID',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) async => run(),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: isPending.value ? null : () async => run(),
            icon: isPending.value
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                  )
                : const Icon(Icons.play_arrow),
            label: const Text('シナリオを実行'),
          ),
          if (lastResult.value case final result?) ...[
            const SizedBox(height: 16),
            _KeyValueRow(label: 'event_id', value: result.eventId),
            _KeyValueRow(
              label: 'steps_planned',
              value: result.stepsPlanned.toString(),
            ),
            _KeyValueRow(
              label: 'telegram_types',
              value: result.telegramTypes.isEmpty
                  ? '(なし)'
                  : result.telegramTypes.join(', '),
            ),
          ],
        ],
      ),
    );
  }
}

class _TestScenarioTypeSection extends HookConsumerWidget {
  const _TestScenarioTypeSection({required this.deviceId});

  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedScenario = useState(TestScenarioType.eewWarning);
    final isPending = useState(false);

    Future<void> run() async {
      if (isPending.value) {
        return;
      }
      isPending.value = true;
      final messenger = ScaffoldMessenger.of(context);
      final notificationRepository = await ref.read(
        pushNotificationRepositoryProvider.future,
      );
      final result = await notificationRepository.sendTestScenarioType(
        deviceId: deviceId,
        scenario: selectedScenario.value,
      );
      isPending.value = false;
      if (!context.mounted) {
        return;
      }
      switch (result) {
        case Success(:final value):
          await showAdaptiveDialog<void>(
            context: context,
            builder: (context) => AlertDialog.adaptive(
              title: Text(value.scenario),
              content: SingleChildScrollView(
                child: SelectableText(
                  value.prettyJson,
                  style: const TextStyle(
                    fontFamily: FontFamily.googleSansCode,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('閉じる'),
                ),
              ],
            ),
          );
        case Failure(:final exception):
          messenger.showSnackBar(
            SnackBar(
              content: Text('実行に失敗: $exception'),
              backgroundColor: context.designSystem.colorTheme.error,
            ),
          );
      }
    }

    return _SectionCard(
      title: 'テストシナリオ種別実行',
      subtitle:
          'シナリオ種別を指定して通知パイプラインを実行し、'
          'この端末にのみテスト通知を配信します',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<TestScenarioType>(
            initialValue: selectedScenario.value,
            decoration: const InputDecoration(
              labelText: 'シナリオ種別',
              border: OutlineInputBorder(),
            ),
            items: [
              for (final scenario in TestScenarioType.values)
                DropdownMenuItem(
                  value: scenario,
                  child: Text(scenario.displayLabel),
                ),
            ],
            onChanged: isPending.value
                ? null
                : (value) {
                    if (value != null) {
                      selectedScenario.value = value;
                    }
                  },
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: isPending.value ? null : () async => run(),
            icon: isPending.value
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                  )
                : const Icon(Icons.play_arrow),
            label: const Text('シナリオ種別を実行'),
          ),
        ],
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
        onPressed: () => ref.invalidate(
          _notificationHistoryProvider(deviceId),
          asReload: true,
        ),
        icon: const Icon(Icons.refresh),
      ),
      child: switch (historyAsync) {
        AsyncData(:final value) when value.isEmpty => Text(
          '履歴はまだありません',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: context.designSystem.colorTheme.onSurfaceVariant,
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
          style: TextStyle(color: context.designSystem.colorTheme.error),
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
  final result = await repo.getNotificationHistory(
    deviceId: deviceId,
    limit: 50,
  );
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
    final colorTheme = context.designSystem.colorTheme;
    final ok = item.result == PushNotificationDeliveryResult.ok;
    final resultColor = ok ? colorTheme.primary : colorTheme.error;
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
Future<bool> _deviceTokenPresent(Ref ref) async {
  final authRepo = await ref.watch(deviceAuthRepositoryProvider.future);
  final token = await authRepo.readToken();
  return token != null && token.isNotEmpty;
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
    final colorTheme = context.designSystem.colorTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 0,
        color: colorTheme.surfaceContainerHighest.withValues(alpha: 0.65),
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
                            style:
                                Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: colorTheme.onSurfaceVariant,
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
                color: context.designSystem.colorTheme.onSurfaceVariant,
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
