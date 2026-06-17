import 'dart:async';

import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/retry/retry_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

/// デバイスプロビジョニング / トークン同期の進行状況バナー。
/// 正常完了・アイドル状態では高さゼロの SizedBox.shrink() を返す。
class DeviceProvisioningBanner extends ConsumerWidget {
  const DeviceProvisioningBanner({required this.bottomSpacing, super.key});

  final double bottomSpacing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provisionStatus = ref.watch(deviceProvisioningProvider);
    final provisionMutation = ref.watch(
      DeviceProvisioningNotifier.provisionMutation,
    );
    final syncMutation = ref.watch(PushTokenSyncNotifier.syncMutation);

    final notifier = ref.watch(deviceProvisioningProvider.notifier);
    final syncNotifier = ref.watch(pushTokenSyncProvider.notifier);

    final provisionRetry = notifier.retryState;
    final syncRetry = syncNotifier.retryState;

    // アクティブなリトライ状態（provisioning 優先）
    final activeRetry = provisionRetry is! RetryIdle
        ? provisionRetry
        : syncRetry;

    final isLoading =
        provisionMutation is MutationPending || syncMutation is MutationPending;

    // 表示不要ケース
    final isProvisionDone =
        provisionStatus.value == DeviceProvisioningStatus.notRequired &&
        provisionMutation is MutationIdle;
    final isAllDone =
        isProvisionDone &&
        syncMutation is MutationIdle &&
        activeRetry is RetryIdle;
    if (isAllDone) {
      return const SizedBox.shrink();
    }

    return _DeviceProvisioningBannerContent(
      bottomSpacing: bottomSpacing,
      activeRetry: activeRetry,
      isLoading: isLoading,
      onRetry: () {
        if (provisionStatus.value == DeviceProvisioningStatus.required) {
          notifier.reset();
          unawaited(
            DeviceProvisioningNotifier.provisionMutation.run(
              ref,
              (tsx) async =>
                  tsx.get(deviceProvisioningProvider.notifier).provision(),
            ),
          );
        } else {
          syncNotifier.reset();
          unawaited(
            PushTokenSyncNotifier.syncMutation.run(
              ref,
              (tsx) async => tsx.get(pushTokenSyncProvider.notifier).sync(),
            ),
          );
        }
      },
    );
  }
}

class _DeviceProvisioningBannerContent extends StatelessWidget {
  const _DeviceProvisioningBannerContent({
    required this.bottomSpacing,
    required this.activeRetry,
    required this.isLoading,
    required this.onRetry,
  });

  final double bottomSpacing;
  final RetryControllerState activeRetry;
  final bool isLoading;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final content = switch (activeRetry) {
      RetryExhausted(:final lastError) => _BannerTile(
        icon: Icons.error_outline,
        backgroundColor: colorScheme.errorContainer,
        foregroundColor: colorScheme.onErrorContainer,
        message: lastError.userMessage,
        trailing: FilledButton.tonal(
          onPressed: onRetry,
          child: const Text('再試行'),
        ),
      ),
      RetryWaiting(:final resumeAt, :final lastError) => _WaitingBanner(
        resumeAt: resumeAt,
        error: lastError,
      ),
      RetryRunning(:final attempt) => _BannerTile(
        icon: Icons.sync,
        backgroundColor: colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer,
        message: attempt == 0 ? '通知設定を更新しています…' : '再試行中… ($attempt 回目)',
        trailing: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        ),
      ),
      RetryIdle() when isLoading => _BannerTile(
        icon: Icons.sync,
        backgroundColor: colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer,
        message: '通知設定を更新しています…',
        trailing: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        ),
      ),
      _ => null,
    };

    if (content == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: content,
    );
  }
}

class _WaitingBanner extends HookWidget {
  const _WaitingBanner({required this.resumeAt, required this.error});

  final DateTime resumeAt;
  final DeviceProvisioningException error;

  @override
  Widget build(BuildContext context) {
    Duration calcRemaining() {
      final now = DateTime.now();
      return resumeAt.isAfter(now) ? resumeAt.difference(now) : Duration.zero;
    }

    final remaining = useState(calcRemaining());

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        remaining.value = calcRemaining();
      });
      return timer.cancel;
    }, [resumeAt]);

    final colorScheme = Theme.of(context).colorScheme;
    final seconds = remaining.value.inSeconds;
    return _BannerTile(
      icon: Icons.schedule,
      backgroundColor: colorScheme.tertiaryContainer,
      foregroundColor: colorScheme.onTertiaryContainer,
      message: seconds > 0 ? '$seconds 秒後に再試行します…' : '再試行しています…',
    );
  }
}

class _BannerTile extends StatelessWidget {
  const _BannerTile({
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.message,
    this.trailing,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final String message;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: foregroundColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: foregroundColor),
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 8), trailing!],
          ],
        ),
      ),
    );
  }
}
