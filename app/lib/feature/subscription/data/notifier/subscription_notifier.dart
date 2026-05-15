import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_notifier.g.dart';

/// サブスクリプション状態を保持する AsyncNotifier の **スタブ**。
///
/// 後続 PR (#12) で RevenueCat (`purchases_flutter`) 統合により
/// 本実装に差し替えられる。差し替え時にはこの signature を維持し、
/// UI 側 (`PaywallPage` / `SubscriptionSettingsPage` / `isProProvider`) を
/// 変更しなくて済むようにする。
///
/// 現状の挙動:
/// - `build()` は常に [SubscriptionStatus.inactive] を返す
/// - [refresh] は no-op
/// - [purchaseMonthly] は [PurchaseResult.unavailable] を返す
/// - [restorePurchases] は [PurchaseResult.unavailable] を返す
@Riverpod(keepAlive: true)
class SubscriptionNotifier extends _$SubscriptionNotifier {
  @override
  Future<SubscriptionStatus> build() async {
    // TODO(#12): RevenueCat の `Purchases.getCustomerInfo()` を呼んで
    // active なエンタイトルメントから [SubscriptionStatus] を組み立てる。
    return const SubscriptionStatus.inactive();
  }

  /// サブスク状態を再取得する。stub では何もしない。
  Future<void> refresh() async {
    // TODO(#12): RevenueCat から再取得し state を更新する。
  }

  /// 月額プラン購入フローを開始する。stub では常に unavailable を返す。
  Future<PurchaseResult> purchaseMonthly() async {
    // TODO(#12): RevenueCat の `Purchases.purchasePackage(...)` を呼ぶ。
    return const PurchaseResult.unavailable('SDK 未統合');
  }

  /// 購入を復元する。stub では unavailable を返す。
  Future<PurchaseResult> restorePurchases() async {
    // TODO(#12): RevenueCat の `Purchases.restorePurchases()` を呼ぶ。
    return const PurchaseResult.unavailable('SDK 未統合');
  }
}
