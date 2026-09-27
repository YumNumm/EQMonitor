import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/subscription/data/flow/paywall_flow.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:eqmonitor/feature/subscription/data/provider/monthly_subscription_package_provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/ui/component/subscription_sync_banner.dart';
import 'package:eqmonitor/feature/devices/ui/component/device_provisioning_banner.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

/// EQMonitor Pro へアップグレードするための Paywall 画面。
class PaywallPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flow = ref.watch(paywallFlowProvider);
    final subscription = ref.watch(subscriptionProvider);
    final canPurchase =
        !subscription.isLoading &&
        !subscription.hasError &&
        subscription.value is SubscriptionStatusInactive &&
        subscription.value?.syncPhase == SubscriptionSyncPhase.idle;
    final packageState = ref.watch(monthlySubscriptionPackageProvider);
    final package = switch (packageState) {
      AsyncData(:final value) when !packageState.isLoading => value,
      _ => null,
    };
    final purchaseState = ref.watch(
      SubscriptionNotifier.purchaseMonthlyMutation,
    );
    final restoreState = ref.watch(
      SubscriptionNotifier.restorePurchasesMutation,
    );
    final isPurchasing = purchaseState is MutationPending;
    final isRestoring = restoreState is MutationPending;
    final isBusy = isPurchasing || isRestoring;
    final colorTheme = context.designSystem.colorTheme;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorTheme.surfaceContainerLow,

      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text('EQMonitor Pro'),
            elevation: 2,
            primary: true,
            centerTitle: false,
            pinned: true,
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Text(
                    'EQMonitor Pro は、開発・運営を支援していただく方向けの月額プランです。\n'
                    'いただいた支援は、サービスの継続的な運営を行うための費用に充てられます。',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  const DeviceProvisioningBanner(),
                  const SubscriptionSyncBanner(),
                  const _BenefitsSection(),
                  const SizedBox(height: 12),
                  _PlanCard(
                    packageState: packageState,
                    onRetry: isBusy
                        ? null
                        : () => ref.invalidate(
                            monthlySubscriptionPackageProvider,
                          ),
                  ),
                  const SizedBox(height: 12),
                  M3EButton(
                    style: .filled,
                    decoration: .new(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      textStyle: .new(
                        fontWeight: .bold,
                        fontFamily: FontFamily.googleSansFlex,
                        fontSize: 16,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    onPressed: isBusy || !canPurchase || package == null
                        ? null
                        : () async => flow.purchaseMonthly(
                            ref,
                            context,
                            package: package,
                          ),
                    child: isPurchasing
                        ? const SizedBox.square(
                            dimension: 20,
                            child: AccessibleCircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Pro にアップグレード'),
                  ),
                  const SizedBox(height: 8),
                  M3EButton(
                    style: .text,
                    onPressed: isBusy
                        ? null
                        : () async => flow.restorePurchases(ref, context),
                    child: const Text('購入を復元する'),
                  ),
                  const SizedBox(height: 16),
                  _LegalLinksRow(
                    onTerms: () async => flow.openExternalUrl(
                      "https://eqmonitor.app/term_of_service",
                    ),
                    onPrivacy: () async => flow.openExternalUrl(
                      "https://eqmonitor.app/privacy_policy",
                    ),
                    onTokushoho: () async =>
                        flow.openExternalUrl("https://eqmonitor.app/asctl"),
                  ),
                  const SizedBox(height: 16),
                  const _AutoRenewNotice(),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class const _Benefit({
  required final IconData icon,
  required final String title,
  required final String description,
});

class _BenefitsSection extends StatelessWidget {
  const new();

  static const _benefits = <_Benefit>[
    _Benefit(
      icon: Icons.notifications_active_rounded,
      title: '通知対象地域を追加',
      description: '複数の地点の地震情報をまとめて受信できます',
    ),
    _Benefit(
      icon: Icons.history_rounded,
      title: "緊急地震速報の履歴",
      description: "過去に発表された緊急地震速報の履歴を確認できます",
    ),
    _Benefit(
      icon: Icons.location_on_rounded,
      title: "この震源の近傍で発生した地震",
      description: "地震の詳細ページから、付近で発生した地震の履歴を確認できます",
    ),
    _Benefit(
      icon: Icons.favorite_rounded,
      title: '開発・運営を支援',
      description: 'いただいた支援は EQMonitor の運営に充てられます。',
    ),
    _Benefit(
      icon: Icons.new_releases_rounded,
      title: "ベータアクセス",
      description:
          "一般公開前の機能をご利用できます。\n"
          "現在、ベータ版で提供している機能はありません",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;
    return Container(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        color: colorTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorTheme.outlineVariant),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      child: Column(
        children: _benefits
            .map((benefit) => _BenefitRow(benefit: benefit))
            .toList(),
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const new({required this.benefit});

  final _Benefit benefit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Icon(
            benefit.icon,
            color: context.designSystem.colorTheme.primary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
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
  const new({required this.packageState, required this.onRetry});

  final AsyncValue<rc.Package?> packageState;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorTheme = context.designSystem.colorTheme;
    return Container(
      decoration: BoxDecoration(
        color: colorTheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colorTheme.primary, width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('月額プラン', style: textTheme.titleMedium),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (packageState.isLoading)
            const AccessibleCircularProgressIndicator()
          else
            switch (packageState) {
              AsyncData(value: final package?) => Text(
                '${package.storeProduct.priceString} / 月',
                style: textTheme.headlineLarge?.copyWith(
                  fontFamily: FontFamily.googleSansFlex,
                ),
              ),
              _ => Column(
                crossAxisAlignment: .start,
                children: [
                  const Text('プラン情報を取得できませんでした。通信状況を確認して再試行してください。'),
                  M3EButton(
                    style: .text,
                    onPressed: onRetry,
                    child: const Text('再試行'),
                  ),
                ],
              ),
            },
        ],
      ),
    );
  }
}

class _LegalLinksRow extends StatelessWidget {
  const new({
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
      alignment: .center,
      spacing: 4,
      children: [
        M3EButton(
          style: .text,
          onPressed: () async => onTerms(),
          child: const Text('利用規約'),
        ),
        M3EButton(
          style: .text,

          onPressed: () async => onPrivacy(),
          child: const Text('プライバシーポリシー'),
        ),
        M3EButton(
          style: .text,

          onPressed: () async => onTokushoho(),
          child: const Text('特定商取引法に基づく表記'),
        ),
      ],
    );
  }
}

class _AutoRenewNotice extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      '自動更新のサブスクリプションになります。期間終了の 24 時間前までに解約しない場合、'
      '自動的に更新されます。\n'
      '解約は App Store / Google Play の '
      'サブスクリプション管理画面からいつでも行えます。',
      style: theme.textTheme.bodySmall?.copyWith(
        color: context.designSystem.colorTheme.onSurfaceVariant,
      ),
      textAlign: .center,
    );
  }
}
