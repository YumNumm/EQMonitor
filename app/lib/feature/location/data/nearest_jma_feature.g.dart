// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'nearest_jma_feature.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jmaMapAreaForecastLocalEewInsideHash() =>
    r'4ff30976ac501077239e83117dfe6f126a0fa15c';

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

/// See also [jmaMapAreaForecastLocalEewInside].
@ProviderFor(jmaMapAreaForecastLocalEewInside)
const jmaMapAreaForecastLocalEewInsideProvider =
    JmaMapAreaForecastLocalEewInsideFamily();

/// See also [jmaMapAreaForecastLocalEewInside].
class JmaMapAreaForecastLocalEewInsideFamily
    extends Family<AsyncValue<JmaMap_JmaMapData_JmaMapDataItem?>> {
  /// See also [jmaMapAreaForecastLocalEewInside].
  const JmaMapAreaForecastLocalEewInsideFamily();

  /// See also [jmaMapAreaForecastLocalEewInside].
  JmaMapAreaForecastLocalEewInsideProvider call(LatLng latLng) {
    return JmaMapAreaForecastLocalEewInsideProvider(latLng);
  }

  @override
  JmaMapAreaForecastLocalEewInsideProvider getProviderOverride(
    covariant JmaMapAreaForecastLocalEewInsideProvider provider,
  ) {
    return call(provider.latLng);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'jmaMapAreaForecastLocalEewInsideProvider';
}

/// See also [jmaMapAreaForecastLocalEewInside].
class JmaMapAreaForecastLocalEewInsideProvider
    extends AutoDisposeFutureProvider<JmaMap_JmaMapData_JmaMapDataItem?> {
  /// See also [jmaMapAreaForecastLocalEewInside].
  JmaMapAreaForecastLocalEewInsideProvider(LatLng latLng)
    : this._internal(
        (ref) => jmaMapAreaForecastLocalEewInside(
          ref as JmaMapAreaForecastLocalEewInsideRef,
          latLng,
        ),
        from: jmaMapAreaForecastLocalEewInsideProvider,
        name: r'jmaMapAreaForecastLocalEewInsideProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$jmaMapAreaForecastLocalEewInsideHash,
        dependencies: JmaMapAreaForecastLocalEewInsideFamily._dependencies,
        allTransitiveDependencies:
            JmaMapAreaForecastLocalEewInsideFamily._allTransitiveDependencies,
        latLng: latLng,
      );

  JmaMapAreaForecastLocalEewInsideProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.latLng,
  }) : super.internal();

  final LatLng latLng;

  @override
  Override overrideWith(
    FutureOr<JmaMap_JmaMapData_JmaMapDataItem?> Function(
      JmaMapAreaForecastLocalEewInsideRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JmaMapAreaForecastLocalEewInsideProvider._internal(
        (ref) => create(ref as JmaMapAreaForecastLocalEewInsideRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        latLng: latLng,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<JmaMap_JmaMapData_JmaMapDataItem?>
  createElement() {
    return _JmaMapAreaForecastLocalEewInsideProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JmaMapAreaForecastLocalEewInsideProvider &&
        other.latLng == latLng;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, latLng.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin JmaMapAreaForecastLocalEewInsideRef
    on AutoDisposeFutureProviderRef<JmaMap_JmaMapData_JmaMapDataItem?> {
  /// The parameter `latLng` of this provider.
  LatLng get latLng;
}

class _JmaMapAreaForecastLocalEewInsideProviderElement
    extends AutoDisposeFutureProviderElement<JmaMap_JmaMapData_JmaMapDataItem?>
    with JmaMapAreaForecastLocalEewInsideRef {
  _JmaMapAreaForecastLocalEewInsideProviderElement(super.provider);

  @override
  LatLng get latLng =>
      (origin as JmaMapAreaForecastLocalEewInsideProvider).latLng;
}

String _$jmaMapAreaForecastLocalEInsideHash() =>
    r'9ff489ff43f7e78222aabaa9482e5a0edf7fa555';

/// See also [jmaMapAreaForecastLocalEInside].
@ProviderFor(jmaMapAreaForecastLocalEInside)
const jmaMapAreaForecastLocalEInsideProvider =
    JmaMapAreaForecastLocalEInsideFamily();

/// See also [jmaMapAreaForecastLocalEInside].
class JmaMapAreaForecastLocalEInsideFamily
    extends Family<AsyncValue<JmaMap_JmaMapData_JmaMapDataItem?>> {
  /// See also [jmaMapAreaForecastLocalEInside].
  const JmaMapAreaForecastLocalEInsideFamily();

  /// See also [jmaMapAreaForecastLocalEInside].
  JmaMapAreaForecastLocalEInsideProvider call(LatLng latLng) {
    return JmaMapAreaForecastLocalEInsideProvider(latLng);
  }

  @override
  JmaMapAreaForecastLocalEInsideProvider getProviderOverride(
    covariant JmaMapAreaForecastLocalEInsideProvider provider,
  ) {
    return call(provider.latLng);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'jmaMapAreaForecastLocalEInsideProvider';
}

/// See also [jmaMapAreaForecastLocalEInside].
class JmaMapAreaForecastLocalEInsideProvider
    extends AutoDisposeFutureProvider<JmaMap_JmaMapData_JmaMapDataItem?> {
  /// See also [jmaMapAreaForecastLocalEInside].
  JmaMapAreaForecastLocalEInsideProvider(LatLng latLng)
    : this._internal(
        (ref) => jmaMapAreaForecastLocalEInside(
          ref as JmaMapAreaForecastLocalEInsideRef,
          latLng,
        ),
        from: jmaMapAreaForecastLocalEInsideProvider,
        name: r'jmaMapAreaForecastLocalEInsideProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$jmaMapAreaForecastLocalEInsideHash,
        dependencies: JmaMapAreaForecastLocalEInsideFamily._dependencies,
        allTransitiveDependencies:
            JmaMapAreaForecastLocalEInsideFamily._allTransitiveDependencies,
        latLng: latLng,
      );

  JmaMapAreaForecastLocalEInsideProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.latLng,
  }) : super.internal();

  final LatLng latLng;

  @override
  Override overrideWith(
    FutureOr<JmaMap_JmaMapData_JmaMapDataItem?> Function(
      JmaMapAreaForecastLocalEInsideRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JmaMapAreaForecastLocalEInsideProvider._internal(
        (ref) => create(ref as JmaMapAreaForecastLocalEInsideRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        latLng: latLng,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<JmaMap_JmaMapData_JmaMapDataItem?>
  createElement() {
    return _JmaMapAreaForecastLocalEInsideProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JmaMapAreaForecastLocalEInsideProvider &&
        other.latLng == latLng;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, latLng.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin JmaMapAreaForecastLocalEInsideRef
    on AutoDisposeFutureProviderRef<JmaMap_JmaMapData_JmaMapDataItem?> {
  /// The parameter `latLng` of this provider.
  LatLng get latLng;
}

class _JmaMapAreaForecastLocalEInsideProviderElement
    extends AutoDisposeFutureProviderElement<JmaMap_JmaMapData_JmaMapDataItem?>
    with JmaMapAreaForecastLocalEInsideRef {
  _JmaMapAreaForecastLocalEInsideProviderElement(super.provider);

  @override
  LatLng get latLng =>
      (origin as JmaMapAreaForecastLocalEInsideProvider).latLng;
}

String _$jmaMapAreaInformationCityInsideHash() =>
    r'93f5886776de857c7a024a68eab16e6a8accf9a0';

/// See also [jmaMapAreaInformationCityInside].
@ProviderFor(jmaMapAreaInformationCityInside)
const jmaMapAreaInformationCityInsideProvider =
    JmaMapAreaInformationCityInsideFamily();

/// See also [jmaMapAreaInformationCityInside].
class JmaMapAreaInformationCityInsideFamily
    extends Family<AsyncValue<JmaMap_JmaMapData_JmaMapDataItem?>> {
  /// See also [jmaMapAreaInformationCityInside].
  const JmaMapAreaInformationCityInsideFamily();

  /// See also [jmaMapAreaInformationCityInside].
  JmaMapAreaInformationCityInsideProvider call(LatLng latLng) {
    return JmaMapAreaInformationCityInsideProvider(latLng);
  }

  @override
  JmaMapAreaInformationCityInsideProvider getProviderOverride(
    covariant JmaMapAreaInformationCityInsideProvider provider,
  ) {
    return call(provider.latLng);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'jmaMapAreaInformationCityInsideProvider';
}

/// See also [jmaMapAreaInformationCityInside].
class JmaMapAreaInformationCityInsideProvider
    extends AutoDisposeFutureProvider<JmaMap_JmaMapData_JmaMapDataItem?> {
  /// See also [jmaMapAreaInformationCityInside].
  JmaMapAreaInformationCityInsideProvider(LatLng latLng)
    : this._internal(
        (ref) => jmaMapAreaInformationCityInside(
          ref as JmaMapAreaInformationCityInsideRef,
          latLng,
        ),
        from: jmaMapAreaInformationCityInsideProvider,
        name: r'jmaMapAreaInformationCityInsideProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$jmaMapAreaInformationCityInsideHash,
        dependencies: JmaMapAreaInformationCityInsideFamily._dependencies,
        allTransitiveDependencies:
            JmaMapAreaInformationCityInsideFamily._allTransitiveDependencies,
        latLng: latLng,
      );

  JmaMapAreaInformationCityInsideProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.latLng,
  }) : super.internal();

  final LatLng latLng;

  @override
  Override overrideWith(
    FutureOr<JmaMap_JmaMapData_JmaMapDataItem?> Function(
      JmaMapAreaInformationCityInsideRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JmaMapAreaInformationCityInsideProvider._internal(
        (ref) => create(ref as JmaMapAreaInformationCityInsideRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        latLng: latLng,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<JmaMap_JmaMapData_JmaMapDataItem?>
  createElement() {
    return _JmaMapAreaInformationCityInsideProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JmaMapAreaInformationCityInsideProvider &&
        other.latLng == latLng;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, latLng.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin JmaMapAreaInformationCityInsideRef
    on AutoDisposeFutureProviderRef<JmaMap_JmaMapData_JmaMapDataItem?> {
  /// The parameter `latLng` of this provider.
  LatLng get latLng;
}

class _JmaMapAreaInformationCityInsideProviderElement
    extends AutoDisposeFutureProviderElement<JmaMap_JmaMapData_JmaMapDataItem?>
    with JmaMapAreaInformationCityInsideRef {
  _JmaMapAreaInformationCityInsideProviderElement(super.provider);

  @override
  LatLng get latLng =>
      (origin as JmaMapAreaInformationCityInsideProvider).latLng;
}

String _$jmaMapAreaTsunamiNearestHash() =>
    r'1280074c335c521685a91e4152131e2209c5ef30';

/// See also [jmaMapAreaTsunamiNearest].
@ProviderFor(jmaMapAreaTsunamiNearest)
const jmaMapAreaTsunamiNearestProvider = JmaMapAreaTsunamiNearestFamily();

/// See also [jmaMapAreaTsunamiNearest].
class JmaMapAreaTsunamiNearestFamily
    extends Family<AsyncValue<JmaMap_JmaMapData_JmaMapDataItem?>> {
  /// See also [jmaMapAreaTsunamiNearest].
  const JmaMapAreaTsunamiNearestFamily();

  /// See also [jmaMapAreaTsunamiNearest].
  JmaMapAreaTsunamiNearestProvider call(LatLng latLng) {
    return JmaMapAreaTsunamiNearestProvider(latLng);
  }

  @override
  JmaMapAreaTsunamiNearestProvider getProviderOverride(
    covariant JmaMapAreaTsunamiNearestProvider provider,
  ) {
    return call(provider.latLng);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'jmaMapAreaTsunamiNearestProvider';
}

/// See also [jmaMapAreaTsunamiNearest].
class JmaMapAreaTsunamiNearestProvider
    extends AutoDisposeFutureProvider<JmaMap_JmaMapData_JmaMapDataItem?> {
  /// See also [jmaMapAreaTsunamiNearest].
  JmaMapAreaTsunamiNearestProvider(LatLng latLng)
    : this._internal(
        (ref) => jmaMapAreaTsunamiNearest(
          ref as JmaMapAreaTsunamiNearestRef,
          latLng,
        ),
        from: jmaMapAreaTsunamiNearestProvider,
        name: r'jmaMapAreaTsunamiNearestProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$jmaMapAreaTsunamiNearestHash,
        dependencies: JmaMapAreaTsunamiNearestFamily._dependencies,
        allTransitiveDependencies:
            JmaMapAreaTsunamiNearestFamily._allTransitiveDependencies,
        latLng: latLng,
      );

  JmaMapAreaTsunamiNearestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.latLng,
  }) : super.internal();

  final LatLng latLng;

  @override
  Override overrideWith(
    FutureOr<JmaMap_JmaMapData_JmaMapDataItem?> Function(
      JmaMapAreaTsunamiNearestRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JmaMapAreaTsunamiNearestProvider._internal(
        (ref) => create(ref as JmaMapAreaTsunamiNearestRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        latLng: latLng,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<JmaMap_JmaMapData_JmaMapDataItem?>
  createElement() {
    return _JmaMapAreaTsunamiNearestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JmaMapAreaTsunamiNearestProvider && other.latLng == latLng;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, latLng.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin JmaMapAreaTsunamiNearestRef
    on AutoDisposeFutureProviderRef<JmaMap_JmaMapData_JmaMapDataItem?> {
  /// The parameter `latLng` of this provider.
  LatLng get latLng;
}

class _JmaMapAreaTsunamiNearestProviderElement
    extends AutoDisposeFutureProviderElement<JmaMap_JmaMapData_JmaMapDataItem?>
    with JmaMapAreaTsunamiNearestRef {
  _JmaMapAreaTsunamiNearestProviderElement(super.provider);

  @override
  LatLng get latLng => (origin as JmaMapAreaTsunamiNearestProvider).latLng;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
