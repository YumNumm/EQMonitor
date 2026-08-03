import 'dart:async';

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/retry/retry_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class DeviceProvisioningBanner extends ConsumerWidget {
  const DeviceProvisioningBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provisionStatus = ref.watch(deviceProvisioningProvider);
    final provisionMutation = ref.watch(
      DeviceProvisioningNotifier.provisionMutation,
    );
    final syncSnapshot =
        provisionStatus.value == DeviceProvisioningStatus.notRequired
        ? ref.watch(pushTokenSyncProvider)
        : null;

    final notifier = ref.watch(deviceProvisioningProvider.notifier);
    final provisionRetry = notifier.retryState;
    final syncRetry = syncSnapshot?.value?.retryState ?? const RetryIdle();

    // アクティブなリトライ状態（provisioning 優先）
    final activeRetry = provisionRetry is! RetryIdle
        ? provisionRetry
        : syncRetry;

    final isLoading =
        provisionMutation is MutationPending || syncRetry is RetryRunning;

    // 表示不要ケース
    final isProvisionDone =
        provisionStatus.value == DeviceProvisioningStatus.notRequired &&
        provisionMutation is! MutationPending;
    final isAllDone = isProvisionDone && activeRetry is RetryIdle;
    if (isAllDone) {
      return const SizedBox.shrink();
    }

    return _DeviceProvisioningBannerContent(
      activeRetry: activeRetry,
      isLoading: isLoading,
      isProvisioningRequired:
          provisionStatus.value == DeviceProvisioningStatus.required,
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
    required this.activeRetry,
    required this.isLoading,
    required this.isProvisioningRequired,
    required this.onRetry,
  });

  final RetryControllerState activeRetry;
  final bool isLoading;
  final bool isProvisioningRequired;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;

    return switch (activeRetry) {
      RetryExhausted(:final lastError) => _BannerTile(
        icon: Icons.error_outline,
        backgroundColor: colorTheme.errorContainer,
        foregroundColor: colorTheme.onErrorContainer,
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
        backgroundColor: colorTheme.secondaryContainer,
        foregroundColor: colorTheme.onSecondaryContainer,
        message: attempt == 0 ? '通知設定を更新しています…' : '再試行中… ($attempt 回目)',
        trailing: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        ),
      ),
      RetryIdle() when isLoading => _BannerTile(
        icon: Icons.sync,
        backgroundColor: colorTheme.secondaryContainer,
        foregroundColor: colorTheme.onSecondaryContainer,
        message: '通知設定を更新しています…',
        trailing: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        ),
      ),
      RetryIdle() when isProvisioningRequired => _BannerTile(
        icon: Icons.warning_amber_outlined,
        backgroundColor: colorTheme.errorContainer,
        foregroundColor: colorTheme.onErrorContainer,
        message: '通知の初期設定が完了していません',
        trailing: FilledButton.tonal(
          onPressed: onRetry,
          child: const Text('再試行'),
        ),
      ),
      _ => SizedBox.shrink(),
    };
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

    final colorTheme = context.designSystem.colorTheme;
    final seconds = remaining.value.inSeconds;
    return _BannerTile(
      icon: Icons.schedule,
      backgroundColor: colorTheme.tertiaryContainer,
      foregroundColor: colorTheme.onTertiaryContainer,
      message: seconds > 0
          ? '${error.userMessage}。$seconds 秒後に再試行します…'
          : '${error.userMessage}。再試行しています…',
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
    final designSystem = context.designSystem;

    final shape = designSystem.shape;
    final colorTheme = designSystem.colorTheme;

    return Material(
      color: backgroundColor,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      clipBehavior: .antiAlias,
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
