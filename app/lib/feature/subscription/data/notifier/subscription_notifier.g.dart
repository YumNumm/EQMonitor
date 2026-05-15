// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'subscription_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

@ProviderFor(SubscriptionNotifier)
final subscriptionProvider = SubscriptionNotifierProvider._();

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
final class SubscriptionNotifierProvider
    extends $AsyncNotifierProvider<SubscriptionNotifier, SubscriptionStatus> {
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
  SubscriptionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionNotifierHash();

  @$internal
  @override
  SubscriptionNotifier create() => SubscriptionNotifier();
}

String _$subscriptionNotifierHash() =>
    r'b58bb9c060cf5eac765ed860c5440852a76b64ad';

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

abstract class _$SubscriptionNotifier
    extends $AsyncNotifier<SubscriptionStatus> {
  FutureOr<SubscriptionStatus> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SubscriptionStatus>, SubscriptionStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SubscriptionStatus>, SubscriptionStatus>,
              AsyncValue<SubscriptionStatus>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
