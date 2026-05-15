import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/subscription/data/flow/paywall_flow.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// サブスクリプションの状態確認 / 管理画面。
class SubscriptionSettingsPage extends ConsumerWidget {
  const SubscriptionSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(subscriptionProvider);
    final color = context.designSystem.color;
    return Scaffold(
      backgroundColor: color.backgroundDefault,
      appBar: AppBar(title: const Text('EQMonitor Pro')),
      body: statusAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('サブスクリプション情報の取得に失敗しました: $error'),
          ),
        ),
        data: (status) => switch (status) {
          SubscriptionStatusActive() => _ActiveSection(status: status),
          SubscriptionStatusInactive() => const _InactiveSection(),
        },
      ),
    );
  }
}

class _ActiveSection extends ConsumerWidget {
  const _ActiveSection({required this.status});

  final SubscriptionStatusActive status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final color = context.designSystem.color;
    final flow = ref.watch(paywallFlowProvider);

    final expiresAt = status.expiresAt;
    final expiresLabel = expiresAt == null
        ? null
        : '${expiresAt.year.toString().padLeft(4, '0')}/'
              '${expiresAt.month.toString().padLeft(2, '0')}/'
              '${expiresAt.day.toString().padLeft(2, '0')}';

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.surfaceCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.outlineSoft),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.workspace_premium_rounded,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text('現在のプラン', style: textTheme.labelMedium),
                ],
              ),
              const SizedBox(height: 8),
              Text('EQMonitor Pro 月額', style: textTheme.titleLarge),
              const SizedBox(height: 12),
              if (expiresLabel != null)
                Text(
                  status.willRenew
                      ? '次回更新: $expiresLabel'
                      : '有効期限: $expiresLabel（自動更新オフ）',
                  style: textTheme.bodyMedium,
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        FilledButton.tonal(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () async => flow.openStoreSubscriptionManagement(),
          child: const Text('サブスクリプションを管理'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () async => flow.restorePurchases(ref, context),
          child: const Text('購入を復元'),
        ),
      ],
    );
  }
}

class _InactiveSection extends ConsumerWidget {
  const _InactiveSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final color = context.designSystem.color;
    final flow = ref.watch(paywallFlowProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.surfaceCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.outlineSoft),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('現在のプラン', style: textTheme.labelMedium),
              const SizedBox(height: 8),
              Text('Free', style: textTheme.titleLarge),
              const SizedBox(height: 12),
              Text(
                'EQMonitor Pro にアップグレードすると、通知地点の拡張・広告非表示などの '
                '特典をご利用いただけます。',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        FilledButton(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () async => const PaywallRoute().push<void>(context),
          child: const Text('EQMonitor Pro にアップグレード'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () async => flow.restorePurchases(ref, context),
          child: const Text('購入を復元'),
        ),
      ],
    );
  }
}
