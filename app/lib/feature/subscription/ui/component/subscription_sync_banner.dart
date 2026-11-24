import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_server_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:eqmonitor/feature/subscription/data/flow/paywall_flow.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_pending_retry.dart';
import 'package:eqmonitor/feature/subscription/data/repository/revenue_cat_session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const SubscriptionSyncBanner({
  /// バナーの外側の余白。指定しない場合は四方に標準の余白を取る。
  final EdgeInsetsGeometry? padding,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscription = ref.watch(subscriptionProvider);
    final phase = subscription.value?.syncPhase;
    final requiresAuth = switch (subscription.error) {
      SubscriptionApiException(
        reason: SubscriptionApiFailure.authenticationRequired,
      ) =>
        true,
      _ => phase == SubscriptionSyncPhase.authenticationRequired,
    };
    final recovering = ref.watch(
      DeviceProvisioningNotifier.provisionMutation,
    ) is MutationPending;
    if (!subscription.hasError &&
        (phase == null || phase == SubscriptionSyncPhase.idle)) {
      return const SizedBox.shrink();
    }
    // 確認中と、反映待ちを自動で再試行している間は、操作のボタンを出さない。
    // 自動の再試行が終わっても反映されない場合に、手動の同期を出す。
    final isRetrying = ref.watch(
      subscriptionPendingRetryProvider.select((token) => token != null),
    );
    final isInProgress =
        phase == SubscriptionSyncPhase.synchronizing ||
        (phase == SubscriptionSyncPhase.pending && isRetrying);
    final message = switch (phase) {
      SubscriptionSyncPhase.synchronizing => '購入情報を確認しています',
      SubscriptionSyncPhase.pending when isRetrying =>
        '購入情報を反映しています。しばらくお待ちください...',
      SubscriptionSyncPhase.pending => '購入情報の反映に時間がかかっています。',
      SubscriptionSyncPhase.authenticationRequired =>
        'デバイスの認証を確認できません。デバイス登録を確認して、もう一度お試しください。',
      _ => '購入情報を確認できませんでした。通信状況を確認して、もう一度お試しください。',
    };
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    return Padding(
      padding: padding ?? EdgeInsets.all(spacing.lg),
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: colorTheme.surfaceContainerHigh,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(designSystem.shape.card),
            side: BorderSide(color: colorTheme.outlineVariant),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            spacing.lg,
            spacing.lg,
            spacing.lg,
            isInProgress ? spacing.lg : spacing.sm,
          ),
          child: Row(
            crossAxisAlignment: .start,
            children: [
              if (isInProgress)
                const SizedBox.square(
                  dimension: 20,
                  child: AccessibleCircularProgressIndicator(strokeWidth: 2),
                )
              else
                Icon(
                  phase == SubscriptionSyncPhase.pending
                      ? Icons.hourglass_top_rounded
                      : Icons.error_outline_rounded,
                  size: 20,
                  color: phase == SubscriptionSyncPhase.pending
                      ? colorTheme.primary
                      : colorTheme.error,
                ),
              SizedBox(width: spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(message),
                    if (!isInProgress)
                      M3EButton(
                        style: .text,
                        onPressed: recovering || subscription.isLoading
                            ? null
                            : () => HapticUtil.light(() async {
                                if (requiresAuth) {
                                  await ref
                                      .read(paywallFlowProvider)
                                      .recoverDevice(ref, context);
                                } else if (subscription.hasError) {
                                  ref.invalidate(revenueCatSessionProvider);
                                  ref.invalidate(subscriptionProvider);
                                } else {
                                  await ref
                                      .read(paywallFlowProvider)
                                      .synchronize(ref, context);
                                }
                              }),
                        child: Text(requiresAuth ? 'デバイス登録を再試行' : '購入情報を同期'),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
