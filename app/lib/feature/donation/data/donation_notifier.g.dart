// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'donation_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsHash() => r'0580a85a0955da5812cf32d6ad08d86940b1ffd5';

/// See also [products].
@ProviderFor(products)
final productsProvider = FutureProvider<List<StoreProduct>>.internal(
  products,
  name: r'productsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$productsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsRef = FutureProviderRef<List<StoreProduct>>;
String _$purchaseHash() => r'9937f03b7541e1c598c164216e7a7ce9dd2ea4d7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [purchase].
@ProviderFor(purchase)
const purchaseProvider = PurchaseFamily();

/// See also [purchase].
class PurchaseFamily extends Family<AsyncValue<CustomerInfo>> {
  /// See also [purchase].
  const PurchaseFamily();

  /// See also [purchase].
  PurchaseProvider call(StoreProduct product) {
    return PurchaseProvider(product);
  }

  @override
  PurchaseProvider getProviderOverride(covariant PurchaseProvider provider) {
    return call(provider.product);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'purchaseProvider';
}

/// See also [purchase].
class PurchaseProvider extends AutoDisposeFutureProvider<CustomerInfo> {
  /// See also [purchase].
  PurchaseProvider(StoreProduct product)
    : this._internal(
        (ref) => purchase(ref as PurchaseRef, product),
        from: purchaseProvider,
        name: r'purchaseProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$purchaseHash,
        dependencies: PurchaseFamily._dependencies,
        allTransitiveDependencies: PurchaseFamily._allTransitiveDependencies,
        product: product,
      );

  PurchaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.product,
  }) : super.internal();

  final StoreProduct product;

  @override
  Override overrideWith(
    FutureOr<CustomerInfo> Function(PurchaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PurchaseProvider._internal(
        (ref) => create(ref as PurchaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        product: product,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CustomerInfo> createElement() {
    return _PurchaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PurchaseProvider && other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PurchaseRef on AutoDisposeFutureProviderRef<CustomerInfo> {
  /// The parameter `product` of this provider.
  StoreProduct get product;
}

class _PurchaseProviderElement
    extends AutoDisposeFutureProviderElement<CustomerInfo>
    with PurchaseRef {
  _PurchaseProviderElement(super.provider);

  @override
  StoreProduct get product => (origin as PurchaseProvider).product;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
