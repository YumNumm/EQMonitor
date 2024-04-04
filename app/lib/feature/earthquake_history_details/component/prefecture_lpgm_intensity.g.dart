// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'prefecture_lpgm_intensity.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lpgmCalculatorHash() => r'0b31367311caf93e6f6708ea1f0016f6cfacd052';

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

/// See also [_lpgmCalculator].
@ProviderFor(_lpgmCalculator)
const _lpgmCalculatorProvider = _LpgmCalculatorFamily();

/// See also [_lpgmCalculator].
class _LpgmCalculatorFamily extends Family {
  /// See also [_lpgmCalculator].
  const _LpgmCalculatorFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_lpgmCalculatorProvider';

  /// See also [_lpgmCalculator].
  _LpgmCalculatorProvider call(
    _Arg arg,
  ) {
    return _LpgmCalculatorProvider(
      arg,
    );
  }

  @visibleForOverriding
  @override
  _LpgmCalculatorProvider getProviderOverride(
    covariant _LpgmCalculatorProvider provider,
  ) {
    return call(
      provider.arg,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>> Function(
              _LpgmCalculatorRef ref)
          create) {
    return _$LpgmCalculatorFamilyOverride(this, create);
  }
}

class _$LpgmCalculatorFamilyOverride implements FamilyOverride {
  _$LpgmCalculatorFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>>
      Function(_LpgmCalculatorRef ref) create;

  @override
  final _LpgmCalculatorFamily overriddenFamily;

  @override
  _LpgmCalculatorProvider getProviderOverride(
    covariant _LpgmCalculatorProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [_lpgmCalculator].
class _LpgmCalculatorProvider extends AutoDisposeFutureProvider<
    Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>> {
  /// See also [_lpgmCalculator].
  _LpgmCalculatorProvider(
    _Arg arg,
  ) : this._internal(
          (ref) => _lpgmCalculator(
            ref as _LpgmCalculatorRef,
            arg,
          ),
          from: _lpgmCalculatorProvider,
          name: r'_lpgmCalculatorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$lpgmCalculatorHash,
          dependencies: _LpgmCalculatorFamily._dependencies,
          allTransitiveDependencies:
              _LpgmCalculatorFamily._allTransitiveDependencies,
          arg: arg,
        );

  _LpgmCalculatorProvider._internal(
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
    FutureOr<Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>> Function(
            _LpgmCalculatorRef ref)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _LpgmCalculatorProvider._internal(
        (ref) => create(ref as _LpgmCalculatorRef),
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
      Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>> createElement() {
    return _LpgmCalculatorProviderElement(this);
  }

  _LpgmCalculatorProvider _copyWith(
    FutureOr<Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>> Function(
            _LpgmCalculatorRef ref)
        create,
  ) {
    return _LpgmCalculatorProvider._internal(
      (ref) => create(ref as _LpgmCalculatorRef),
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
    return other is _LpgmCalculatorProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _LpgmCalculatorRef on AutoDisposeFutureProviderRef<
    Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>> {
  /// The parameter `arg` of this provider.
  _Arg get arg;
}

class _LpgmCalculatorProviderElement extends AutoDisposeFutureProviderElement<
        Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>>
    with _LpgmCalculatorRef {
  _LpgmCalculatorProviderElement(super.provider);

  @override
  _Arg get arg => (origin as _LpgmCalculatorProvider).arg;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
