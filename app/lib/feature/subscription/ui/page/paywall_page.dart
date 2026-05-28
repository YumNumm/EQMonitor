import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/subscription/data/flow/paywall_flow.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

/// EQMonitor Pro へアップグレードするための Paywall 画面。
class PaywallPage extends ConsumerWidget {
  const PaywallPage({super.key});

  static const _termsUrl = 'https://eqmonitor.app/terms';
  static const _privacyUrl = 'https://eqmonitor.app/privacy';
  static const _tokushohoUrl = 'https://eqmonitor.app/tokushoho';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flow = ref.watch(paywallFlowProvider);
    final purchaseState = ref.watch(
      SubscriptionNotifier.purchaseMonthlyMutation,
    );
    final restoreState = ref.watch(
      SubscriptionNotifier.restorePurchasesMutation,
    );
    final isPurchasing = purchaseState is MutationPending;
    final isRestoring = restoreState is MutationPending;
    final isBusy = isPurchasing || isRestoring;
    final color = context.designSystem.color;

    return Scaffold(
      backgroundColor: color.backgroundDefault,
      appBar: AppBar(
        title: const Text('EQMonitor Pro'),
        backgroundColor: color.backgroundDefault,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const _PaywallHero(),
          const SizedBox(height: 28),
          const _BenefitsSection(),
          const SizedBox(height: 24),
          const _PlanCard(),
          const SizedBox(height: 24),
          FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: isBusy
                ? null
                : () async => flow.purchaseMonthly(ref, context),
            child: isPurchasing
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                  )
                : const Text('Pro にアップグレード'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: isBusy
                ? null
                : () async => flow.restorePurchases(ref, context),
            child: const Text('購入を復元する'),
          ),
          const SizedBox(height: 16),
          _LegalLinksRow(
            onTerms: () async => flow.openExternalUrl(_termsUrl),
            onPrivacy: () async => flow.openExternalUrl(_privacyUrl),
            onTokushoho: () async => flow.openExternalUrl(_tokushohoUrl),
          ),
          const SizedBox(height: 16),
          const _AutoRenewNotice(),
        ],
      ),
    );
  }
}

class _PaywallHero extends StatelessWidget {
  const _PaywallHero();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = context.designSystem.color;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.surfaceEmphasis,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'EQMonitor Pro',
            style: textTheme.labelMedium,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'すべての通知、\nすべての安心。',
          style: textTheme.displayMedium,
        ),
        const SizedBox(height: 12),
        Text(
          'EQMonitor Pro は、開発・運営を支援していただく方向けの月額プランです。 '
          'いただいた支援は、サーバー代と開発費に充てられます。',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _Benefit {
  const _Benefit({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class _BenefitsSection extends StatelessWidget {
  const _BenefitsSection();

  static const _benefits = <_Benefit>[
    _Benefit(
      icon: Icons.block_rounded,
      title: '広告を非表示',
      description: 'すべての画面で広告を非表示にします。',
    ),
    _Benefit(
      icon: Icons.notifications_active_outlined,
      title: '通知地点を最大 5 つに拡張',
      description: '気になる地域をまとめて見守れます。',
    ),
    _Benefit(
      icon: Icons.vibration_rounded,
      title: '揺れ検知を 3 地点に拡張',
      description: '複数地点の揺れをまとめて受信できます。',
    ),
    _Benefit(
      icon: Icons.favorite_outline,
      title: '開発・運営を支援',
      description: 'いただいた支援は EQMonitor の運営に充てられます。',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final color = context.designSystem.color;
    return Container(
      decoration: BoxDecoration(
        color: color.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.outlineSoft),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          for (final benefit in _benefits) _BenefitRow(benefit: benefit),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.benefit});

  final _Benefit benefit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(benefit.icon, color: theme.colorScheme.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(benefit.title, style: textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(benefit.description, style: textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final color = context.designSystem.color;
    return Container(
      decoration: BoxDecoration(
        color: color.surfaceEmphasis,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: theme.colorScheme.primary, width: 1.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('月額プラン', style: textTheme.titleMedium),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'おすすめ',
                  style: textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('¥300', style: textTheme.headlineLarge),
              const SizedBox(width: 6),
              Text('/ 月（税込）', style: textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'いつでも解約可能。期間中は Pro 特典をすべてご利用いただけます。',
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _LegalLinksRow extends StatelessWidget {
  const _LegalLinksRow({
    required this.onTerms,
    required this.onPrivacy,
    required this.onTokushoho,
  });

  final Future<void> Function() onTerms;
  final Future<void> Function() onPrivacy;
  final Future<void> Function() onTokushoho;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4,
      children: [
        TextButton(onPressed: () async => onTerms(), child: const Text('利用規約')),
        TextButton(
          onPressed: () async => onPrivacy(),
          child: const Text('プライバシーポリシー'),
        ),
        TextButton(
          onPressed: () async => onTokushoho(),
          child: const Text('特定商取引法に基づく表記'),
        ),
      ],
    );
  }
}

class _AutoRenewNotice extends StatelessWidget {
  const _AutoRenewNotice();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      '自動更新サブスクリプションです。期間終了の 24 時間前までに解約しないと、 '
      '自動的に更新されます。解約は App Store / Google Play の '
      'サブスクリプション管理画面からいつでも行えます。',
      style: theme.textTheme.bodySmall?.copyWith(
        color: context.designSystem.color.outlineStrong,
      ),
      textAlign: TextAlign.center,
    );
  }
}
