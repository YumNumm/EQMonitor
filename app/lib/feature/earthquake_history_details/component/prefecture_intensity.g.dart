// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'prefecture_intensity.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$calculatorHash() => r'8f639dd4d60bda645dfc32e57a8efe6ebb4d1e5e';

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

/// See also [_calculator].
@ProviderFor(_calculator)
const _calculatorProvider = _CalculatorFamily();

/// See also [_calculator].
class _CalculatorFamily extends Family {
  /// See also [_calculator].
  const _CalculatorFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_calculatorProvider';

  /// See also [_calculator].
  _CalculatorProvider call(
    _Arg arg,
  ) {
    return _CalculatorProvider(
      arg,
    );
  }

  @visibleForOverriding
  @override
  _CalculatorProvider getProviderOverride(
    covariant _CalculatorProvider provider,
  ) {
    return call(
      provider.arg,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<Map<JmaIntensity, List<_MergedRegionIntensity>>> Function(
              _CalculatorRef ref)
          create) {
    return _$CalculatorFamilyOverride(this, create);
  }
}

class _$CalculatorFamilyOverride implements FamilyOverride {
  _$CalculatorFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Map<JmaIntensity, List<_MergedRegionIntensity>>> Function(
      _CalculatorRef ref) create;

  @override
  final _CalculatorFamily overriddenFamily;

  @override
  _CalculatorProvider getProviderOverride(
    covariant _CalculatorProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_calculator].
class _CalculatorProvider extends AutoDisposeFutureProvider<
    Map<JmaIntensity, List<_MergedRegionIntensity>>> {
  /// See also [_calculator].
  _CalculatorProvider(
    _Arg arg,
  ) : this._internal(
          (ref) => _calculator(
            ref as _CalculatorRef,
            arg,
          ),
          from: _calculatorProvider,
          name: r'_calculatorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$calculatorHash,
          dependencies: _CalculatorFamily._dependencies,
          allTransitiveDependencies:
              _CalculatorFamily._allTransitiveDependencies,
          arg: arg,
        );

  _CalculatorProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final _Arg arg;

  @override
  Override overrideWith(
    FutureOr<Map<JmaIntensity, List<_MergedRegionIntensity>>> Function(
            _CalculatorRef ref)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _CalculatorProvider._internal(
        (ref) => create(ref as _CalculatorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
      ),
    );
  }

  @override
  (_Arg,) get argument {
    return (arg,);
  }

  @override
  AutoDisposeFutureProviderElement<
      Map<JmaIntensity, List<_MergedRegionIntensity>>> createElement() {
    return _CalculatorProviderElement(this);
  }

  _CalculatorProvider _copyWith(
    FutureOr<Map<JmaIntensity, List<_MergedRegionIntensity>>> Function(
            _CalculatorRef ref)
        create,
  ) {
    return _CalculatorProvider._internal(
      (ref) => create(ref as _CalculatorRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      arg: arg,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _CalculatorProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _CalculatorRef on AutoDisposeFutureProviderRef<
    Map<JmaIntensity, List<_MergedRegionIntensity>>> {
  /// The parameter `arg` of this provider.
  _Arg get arg;
}

class _CalculatorProviderElement extends AutoDisposeFutureProviderElement<
    Map<JmaIntensity, List<_MergedRegionIntensity>>> with _CalculatorRef {
  _CalculatorProviderElement(super.provider);

  @override
  _Arg get arg => (origin as _CalculatorProvider).arg;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
