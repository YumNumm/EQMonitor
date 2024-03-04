// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'prefecture_lpgm_intensity.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lpgmCalculatorHash() => r'daa304302a60ec9802b1139cce69374128ecfb70';

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
class _LpgmCalculatorFamily extends Family<
    AsyncValue<Map<JmaLgIntensity, List<_MergedRegionIntensity>>>> {
  /// See also [_lpgmCalculator].
  const _LpgmCalculatorFamily();

  /// See also [_lpgmCalculator].
  _LpgmCalculatorProvider call(
    ({
      List<ObservedRegionLpgmIntensity>? cities,
      List<ObservedRegionLpgmIntensity> prefectures,
      List<ObservedRegionLpgmIntensity>? stations
    }) arg,
  ) {
    return _LpgmCalculatorProvider(
      arg,
    );
  }

  @override
  _LpgmCalculatorProvider getProviderOverride(
    covariant _LpgmCalculatorProvider provider,
  ) {
    return call(
      provider.arg,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_lpgmCalculatorProvider';
}

/// See also [_lpgmCalculator].
class _LpgmCalculatorProvider extends AutoDisposeFutureProvider<
    Map<JmaLgIntensity, List<_MergedRegionIntensity>>> {
  /// See also [_lpgmCalculator].
  _LpgmCalculatorProvider(
    ({
      List<ObservedRegionLpgmIntensity>? cities,
      List<ObservedRegionLpgmIntensity> prefectures,
      List<ObservedRegionLpgmIntensity>? stations
    }) arg,
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
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final ({
    List<ObservedRegionLpgmIntensity>? cities,
    List<ObservedRegionLpgmIntensity> prefectures,
    List<ObservedRegionLpgmIntensity>? stations
  }) arg;

  @override
  Override overrideWith(
    FutureOr<Map<JmaLgIntensity, List<_MergedRegionIntensity>>> Function(
            _LpgmCalculatorRef provider)
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
  AutoDisposeFutureProviderElement<
      Map<JmaLgIntensity, List<_MergedRegionIntensity>>> createElement() {
    return _LpgmCalculatorProviderElement(this);
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
    Map<JmaLgIntensity, List<_MergedRegionIntensity>>> {
  /// The parameter `arg` of this provider.
  ({
    List<ObservedRegionLpgmIntensity>? cities,
    List<ObservedRegionLpgmIntensity> prefectures,
    List<ObservedRegionLpgmIntensity>? stations
  }) get arg;
}

class _LpgmCalculatorProviderElement extends AutoDisposeFutureProviderElement<
    Map<JmaLgIntensity, List<_MergedRegionIntensity>>> with _LpgmCalculatorRef {
  _LpgmCalculatorProviderElement(super.provider);

  @override
  ({
    List<ObservedRegionLpgmIntensity>? cities,
    List<ObservedRegionLpgmIntensity> prefectures,
    List<ObservedRegionLpgmIntensity>? stations
  }) get arg => (origin as _LpgmCalculatorProvider).arg;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
