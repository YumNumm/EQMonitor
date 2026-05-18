// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'subscription_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// サブスクリプション状態を保持する AsyncNotifier。
///
/// `Purchases.getCustomerInfo()` で取得した `CustomerInfo` から
/// active な `pro` Entitlement を判定し [SubscriptionStatus] を返す。

@ProviderFor(SubscriptionNotifier)
final subscriptionProvider = SubscriptionNotifierProvider._();

/// サブスクリプション状態を保持する AsyncNotifier。
///
/// `Purchases.getCustomerInfo()` で取得した `CustomerInfo` から
/// active な `pro` Entitlement を判定し [SubscriptionStatus] を返す。
final class SubscriptionNotifierProvider
    extends $AsyncNotifierProvider<SubscriptionNotifier, SubscriptionStatus> {
  /// サブスクリプション状態を保持する AsyncNotifier。
  ///
  /// `Purchases.getCustomerInfo()` で取得した `CustomerInfo` から
  /// active な `pro` Entitlement を判定し [SubscriptionStatus] を返す。
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
    r'779ff27bb329e3466ab40977e12eaefdb5d9a6dd';

/// サブスクリプション状態を保持する AsyncNotifier。
///
/// `Purchases.getCustomerInfo()` で取得した `CustomerInfo` から
/// active な `pro` Entitlement を判定し [SubscriptionStatus] を返す。

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
