import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/subscription/data/flow/paywall_flow.dart';
import 'package:eqmonitor/feature/subscription/data/model/pro_benefit.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/provider/pro_benefits_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:eqmonitor/feature/subscription/data/provider/monthly_subscription_package_provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/ui/component/shake_detection_notification_detail_sheet.dart';
import 'package:eqmonitor/feature/subscription/ui/component/subscription_sync_banner.dart';
import 'package:eqmonitor/feature/devices/ui/component/device_provisioning_banner.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

/// EQMonitor Pro へアップグレードするための Paywall 画面。
class const PaywallPage({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flow = ref.watch(paywallFlowProvider);
    final subscription = ref.watch(subscriptionProvider);
    final isSubscriptionAvailable = ref.watch(
      buildConfigProvider.select((config) => config.isSubscriptionAvailable),
    );
    final canPurchase =
        isSubscriptionAvailable &&
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
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorTheme.surfaceContainerLow,
      bottomNavigationBar: _PurchaseBar(
        packageState: packageState,
        isPurchasing: isPurchasing,
        isSubscriptionAvailable: isSubscriptionAvailable,
        onRetry: isBusy
            ? null
            : () => ref.invalidate(monthlySubscriptionPackageProvider),
        onPurchase: isBusy || !canPurchase || package == null
            ? null
            : () async => flow.purchaseMonthly(ref, context, package: package),
      ),
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
              padding: EdgeInsets.symmetric(
                horizontal: spacing.lg,
                vertical: spacing.sm,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Text(
                    'EQMonitor Pro は、開発・運営を支援していただく方向けの月額プランです。\n'
                    'いただいた支援は、サービスの継続的な運営を行うための費用に充てられます。',
                    style: textTheme.bodyMedium,
                  ),
                  SizedBox(height: spacing.md),
                  const DeviceProvisioningBanner(),
                  SubscriptionSyncBanner(
                    padding: EdgeInsets.only(bottom: spacing.md),
                  ),
                  SizedBox(height: spacing.sm),
                  const _BenefitsSection(),
                  SizedBox(height: spacing.lg),
                  M3EButton(
                    style: .text,
                    onPressed: isBusy || !isSubscriptionAvailable
                        ? null
                        : () async => flow.restorePurchases(ref, context),
                    child: const Text('購入を復元する'),
                  ),
                  SizedBox(height: spacing.sm),
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
                  SizedBox(height: spacing.lg),
                  const _AutoRenewNotice(),
                  SizedBox(height: spacing.lg),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class const _BenefitsSection() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final benefits = ref.watch(proBenefitsProvider);
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing.xs),
          child: Text(
            'Pro で利用できる機能',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: colorTheme.secondary,
            ),
          ),
        ),
        SizedBox(height: spacing.sm),
        DecoratedBox(
          decoration: ShapeDecoration(
            color: colorTheme.surfaceContainerHigh,
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(designSystem.shape.card),
              side: BorderSide(color: colorTheme.outlineVariant),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: spacing.sm),
            child: Column(
              children: [
                for (final (index, benefit) in benefits.indexed) ...[
                  if (index > 0)
                    Divider(
                      height: 1,
                      indent: spacing.lg + _BenefitRow.iconExtent + spacing.lg,
                      endIndent: spacing.lg,
                      color: colorTheme.outlineVariant,
                    ),
                  _BenefitRow(benefit: benefit),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class const _BenefitRow({required final ProBenefit benefit})
    extends StatelessWidget {
  static const iconExtent = 40.0;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.lg,
        vertical: spacing.md,
      ),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          DecoratedBox(
            decoration: ShapeDecoration(
              color: colorTheme.primaryContainer,
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(designSystem.shape.sm),
              ),
            ),
            child: SizedBox.square(
              dimension: iconExtent,
              child: Icon(
                switch (benefit) {
                  .notificationRegions => Icons.add_location_alt_rounded,
                  .shakeDetectionNotification => Icons.sensors_rounded,
                  .eewHistory => Icons.history_rounded,
                  .nearbyEarthquakes => Icons.travel_explore_rounded,
                },
                color: colorTheme.onPrimaryContainer,
                size: 22,
              ),
            ),
          ),
          SizedBox(width: spacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(benefit.title, style: textTheme.titleMedium),
                SizedBox(height: spacing.xs),
                Text(
                  benefit.description,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorTheme.onSurfaceVariant,
                  ),
                ),
                if (benefit == .shakeDetectionNotification)
                  _DetailLink(
                    onTap: () async =>
                        const ShakeDetectionNotificationDetailSheetAction()
                            .show(context),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const _DetailLink({required final VoidCallback onTap})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    return Semantics(
      link: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(designSystem.shape.xs),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: spacing.sm),
          child: Text(
            '詳しく',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colorTheme.primary,
              decoration: .underline,
              decorationColor: colorTheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

/// 価格と購入ボタン。機能の一覧が増えても見失わないよう、画面の下部に固定する。
class const _PurchaseBar({
  required final AsyncValue<rc.Package?> packageState,
  required final bool isPurchasing,
  required final bool isSubscriptionAvailable,
  required final VoidCallback? onRetry,
  required final VoidCallback? onPurchase,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorTheme.surfaceContainer,
        border: Border(top: BorderSide(color: colorTheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            spacing.lg,
            spacing.md,
            spacing.lg,
            spacing.md,
          ),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: [
              _PlanPrice(packageState: packageState, onRetry: onRetry),
              SizedBox(height: spacing.md),
              if (!isSubscriptionAvailable) ...[
                Text(
                  'ベータ版では EQMonitor Pro を利用できません。購入済みの場合も無料版として動作します。',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorTheme.onSurfaceVariant,
                  ),
                  textAlign: .center,
                ),
                SizedBox(height: spacing.sm),
              ],
              M3EButton(
                style: .filled,
                decoration: .new(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.lg,
                    vertical: spacing.lg,
                  ),
                  // テーマの文字スタイルから作り、日本語のフォールバックを引き継ぐ。
                  textStyle: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: .bold,
                    fontFamily: FontFamily.googleSansFlex,
                    fontSize: 16,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                onPressed: onPurchase,
                child: isPurchasing
                    ? const SizedBox.square(
                        dimension: 20,
                        child: AccessibleCircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Pro にアップグレード'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class const _PlanPrice({
  required final AsyncValue<rc.Package?> packageState,
  required final VoidCallback? onRetry,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final spacing = context.designSystem.spacing;
    final label = Text('月額プラン', style: textTheme.titleMedium);
    if (packageState.isLoading) {
      return Row(
        children: [
          Expanded(child: label),
          const SizedBox.square(
            dimension: 20,
            child: AccessibleCircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      );
    }
    return switch (packageState) {
      AsyncData(value: final package?) => Wrap(
        alignment: .spaceBetween,
        crossAxisAlignment: .center,
        spacing: spacing.lg,
        children: [
          label,
          Text(
            '${package.storeProduct.priceString} / 月',
            style: textTheme.headlineSmall?.copyWith(
              fontFamily: FontFamily.googleSansCode,
              fontWeight: .bold,
            ),
          ),
        ],
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
    };
  }
}

class const _LegalLinksRow({
  required final Future<void> Function() onTerms,
  required final Future<void> Function() onPrivacy,
  required final Future<void> Function() onTokushoho,
}) extends StatelessWidget {
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

class const _AutoRenewNotice() extends StatelessWidget {
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
