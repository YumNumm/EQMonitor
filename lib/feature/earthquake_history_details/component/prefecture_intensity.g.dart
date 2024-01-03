// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'prefecture_intensity.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$calculatorHash() => r'0d904c3c6d4fdb0bc1ea3e404efb330055a3ada8';

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
class _CalculatorFamily
    extends Family<AsyncValue<Map<JmaIntensity, List<_PrefectureIntensity>>>> {
  /// See also [_calculator].
  const _CalculatorFamily();

  /// See also [_calculator].
  _CalculatorProvider call(
    ({
      List<RegionIntensity>? cities,
      List<RegionIntensity> prefectures,
      List<RegionIntensity>? stations
    }) arg,
  ) {
    return _CalculatorProvider(
      arg,
    );
  }

  @override
  _CalculatorProvider getProviderOverride(
    covariant _CalculatorProvider provider,
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
  String? get name => r'_calculatorProvider';
}

/// See also [_calculator].
class _CalculatorProvider extends AutoDisposeFutureProvider<
    Map<JmaIntensity, List<_PrefectureIntensity>>> {
  /// See also [_calculator].
  _CalculatorProvider(
    ({
      List<RegionIntensity>? cities,
      List<RegionIntensity> prefectures,
      List<RegionIntensity>? stations
    }) arg,
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
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final ({
    List<RegionIntensity>? cities,
    List<RegionIntensity> prefectures,
    List<RegionIntensity>? stations
  }) arg;

  @override
  Override overrideWith(
    FutureOr<Map<JmaIntensity, List<_PrefectureIntensity>>> Function(
            _CalculatorRef provider)
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
  AutoDisposeFutureProviderElement<
      Map<JmaIntensity, List<_PrefectureIntensity>>> createElement() {
    return _CalculatorProviderElement(this);
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
    Map<JmaIntensity, List<_PrefectureIntensity>>> {
  /// The parameter `arg` of this provider.
  ({
    List<RegionIntensity>? cities,
    List<RegionIntensity> prefectures,
    List<RegionIntensity>? stations
  }) get arg;
}

class _CalculatorProviderElement extends AutoDisposeFutureProviderElement<
    Map<JmaIntensity, List<_PrefectureIntensity>>> with _CalculatorRef {
  _CalculatorProviderElement(super.provider);

  @override
  ({
    List<RegionIntensity>? cities,
    List<RegionIntensity> prefectures,
    List<RegionIntensity>? stations
  }) get arg => (origin as _CalculatorProvider).arg;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
