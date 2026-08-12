import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_notifier.g.dart';

/// サブスクリプション状態を保持する AsyncNotifier。
///
/// RevenueCat SDK へのアクセスは [SubscriptionRepository] に集約する。
@Riverpod(keepAlive: true)
class SubscriptionNotifier extends _$SubscriptionNotifier {
  @override
  Future<SubscriptionStatus> build() async {
    final isProFeaturesEnabled = ref.watch(
      buildConfigProvider.select((c) => c.isProFeaturesEnabled),
    );
    if (!isProFeaturesEnabled) {
      return const SubscriptionStatus.inactive();
    }
    final repository = await ref.watch(subscriptionRepositoryProvider.future);
    return repository.fetchStatus();
  }

  static final purchaseMonthlyMutation = Mutation<PurchaseResult>();
  Future<PurchaseResult> purchaseMonthly() async {
    final repository = await ref.read(subscriptionRepositoryProvider.future);
    final outcome = await repository.purchaseMonthly();
    final status = outcome.status;
    if (status != null) {
      state = AsyncData(status);
    }
    return outcome.result;
  }

  static final restorePurchasesMutation = Mutation<PurchaseResult>();
  Future<PurchaseResult> restorePurchases() async {
    final repository = await ref.read(subscriptionRepositoryProvider.future);
    final outcome = await repository.restorePurchases();
    final status = outcome.status;
    if (status != null) {
      state = AsyncData(status);
    }
    return outcome.result;
  }
}
