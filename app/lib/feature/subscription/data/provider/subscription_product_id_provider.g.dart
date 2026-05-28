// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'subscription_product_id_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(monthlySubscriptionProductId)
final monthlySubscriptionProductIdProvider =
    MonthlySubscriptionProductIdProvider._();

final class MonthlySubscriptionProductIdProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  MonthlySubscriptionProductIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monthlySubscriptionProductIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monthlySubscriptionProductIdHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return monthlySubscriptionProductId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$monthlySubscriptionProductIdHash() =>
    r'0fe0ac507b07b8006f708425de972cb4e5b89046';
