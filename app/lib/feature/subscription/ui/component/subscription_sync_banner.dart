import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_server_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:eqmonitor/feature/subscription/data/flow/paywall_flow.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/repository/revenue_cat_session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class SubscriptionSyncBanner extends ConsumerWidget {
  const new();

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
    final message = switch (phase) {
      SubscriptionSyncPhase.synchronizing => '購入情報を同期しています',
      SubscriptionSyncPhase.pending => '購入情報の反映を待っています。再購入は不要です。',
      SubscriptionSyncPhase.authenticationRequired =>
        'デバイスの認証を確認できません。デバイス登録を確認して再試行してください。',
      _ => '購入情報を確認できませんでした。通信状況を確認して再試行してください。',
    };
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(message),
          M3EButton(
            style: .text,
            onPressed:
                recovering ||
                    subscription.isLoading ||
                    phase == SubscriptionSyncPhase.synchronizing
                ? null
                : () async {
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
                  },
            child: Text(requiresAuth ? 'デバイス登録を再試行' : '購入情報を同期'),
          ),
        ],
      ),
    );
  }
}
