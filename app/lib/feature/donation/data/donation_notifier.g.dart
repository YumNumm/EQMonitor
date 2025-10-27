// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'donation_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(products)
const productsProvider = ProductsProvider._();

final class ProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StoreProduct>>,
          List<StoreProduct>,
          FutureOr<List<StoreProduct>>
        >
    with
        $FutureModifier<List<StoreProduct>>,
        $FutureProvider<List<StoreProduct>> {
  const ProductsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productsHash();

  @$internal
  @override
  $FutureProviderElement<List<StoreProduct>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StoreProduct>> create(Ref ref) {
    return products(ref);
  }
}

String _$productsHash() => r'0580a85a0955da5812cf32d6ad08d86940b1ffd5';

@ProviderFor(purchase)
const purchaseProvider = PurchaseFamily._();

final class PurchaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<PurchaseResult>,
          PurchaseResult,
          FutureOr<PurchaseResult>
        >
    with $FutureModifier<PurchaseResult>, $FutureProvider<PurchaseResult> {
  const PurchaseProvider._({
    required PurchaseFamily super.from,
    required StoreProduct super.argument,
  }) : super(
         retry: null,
         name: r'purchaseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$purchaseHash();

  @override
  String toString() {
    return r'purchaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PurchaseResult> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PurchaseResult> create(Ref ref) {
    final argument = this.argument as StoreProduct;
    return purchase(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PurchaseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$purchaseHash() => r'063f4bbaca05afc6051c0366907347c8fcafe3c0';

final class PurchaseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PurchaseResult>, StoreProduct> {
  const PurchaseFamily._()
    : super(
        retry: null,
        name: r'purchaseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PurchaseProvider call(StoreProduct product) =>
      PurchaseProvider._(argument: product, from: this);

  @override
  String toString() => r'purchaseProvider';
}
