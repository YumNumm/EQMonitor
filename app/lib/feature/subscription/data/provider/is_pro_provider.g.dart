// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'is_pro_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Pro ユーザーかどうかを返す。
///
/// [subscriptionProvider] を watch し、active なら true。
/// SDK 未統合段階では Stub の Notifier が常に [SubscriptionStatus.inactive] を
/// 返すため false。後続 PR (#12) で RevenueCat 統合後は実際の購読状態を反映する。

@ProviderFor(isPro)
final isProProvider = IsProProvider._();

/// Pro ユーザーかどうかを返す。
///
/// [subscriptionProvider] を watch し、active なら true。
/// SDK 未統合段階では Stub の Notifier が常に [SubscriptionStatus.inactive] を
/// 返すため false。後続 PR (#12) で RevenueCat 統合後は実際の購読状態を反映する。

final class IsProProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Pro ユーザーかどうかを返す。
  ///
  /// [subscriptionProvider] を watch し、active なら true。
  /// SDK 未統合段階では Stub の Notifier が常に [SubscriptionStatus.inactive] を
  /// 返すため false。後続 PR (#12) で RevenueCat 統合後は実際の購読状態を反映する。
  IsProProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isProProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isProHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isPro(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isProHash() => r'd2cf08a16b70bbe19f11fb9cfeb8f4d9fbb65ee5';
