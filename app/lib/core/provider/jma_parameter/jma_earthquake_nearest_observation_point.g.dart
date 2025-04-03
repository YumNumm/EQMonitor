// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'jma_earthquake_nearest_observation_point.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jmaEarthquakeNearestObservationPointHash() =>
    r'46d50c9150faeccc1fcddd4e83ee69e16df3b4a0';

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

/// See also [jmaEarthquakeNearestObservationPoint].
@ProviderFor(jmaEarthquakeNearestObservationPoint)
const jmaEarthquakeNearestObservationPointProvider =
    JmaEarthquakeNearestObservationPointFamily();

/// See also [jmaEarthquakeNearestObservationPoint].
class JmaEarthquakeNearestObservationPointFamily
    extends Family<AsyncValue<(EarthquakeParameterStationItem, double)?>> {
  /// See also [jmaEarthquakeNearestObservationPoint].
  const JmaEarthquakeNearestObservationPointFamily();

  /// See also [jmaEarthquakeNearestObservationPoint].
  JmaEarthquakeNearestObservationPointProvider call(LatLng latLng) {
    return JmaEarthquakeNearestObservationPointProvider(latLng);
  }

  @override
  JmaEarthquakeNearestObservationPointProvider getProviderOverride(
    covariant JmaEarthquakeNearestObservationPointProvider provider,
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
  String? get name => r'jmaEarthquakeNearestObservationPointProvider';
}

/// See also [jmaEarthquakeNearestObservationPoint].
class JmaEarthquakeNearestObservationPointProvider
    extends
        AutoDisposeFutureProvider<(EarthquakeParameterStationItem, double)?> {
  /// See also [jmaEarthquakeNearestObservationPoint].
  JmaEarthquakeNearestObservationPointProvider(LatLng latLng)
    : this._internal(
        (ref) => jmaEarthquakeNearestObservationPoint(
          ref as JmaEarthquakeNearestObservationPointRef,
          latLng,
        ),
        from: jmaEarthquakeNearestObservationPointProvider,
        name: r'jmaEarthquakeNearestObservationPointProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$jmaEarthquakeNearestObservationPointHash,
        dependencies: JmaEarthquakeNearestObservationPointFamily._dependencies,
        allTransitiveDependencies:
            JmaEarthquakeNearestObservationPointFamily
                ._allTransitiveDependencies,
        latLng: latLng,
      );

  JmaEarthquakeNearestObservationPointProvider._internal(
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
    FutureOr<(EarthquakeParameterStationItem, double)?> Function(
      JmaEarthquakeNearestObservationPointRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JmaEarthquakeNearestObservationPointProvider._internal(
        (ref) => create(ref as JmaEarthquakeNearestObservationPointRef),
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
  AutoDisposeFutureProviderElement<(EarthquakeParameterStationItem, double)?>
  createElement() {
    return _JmaEarthquakeNearestObservationPointProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JmaEarthquakeNearestObservationPointProvider &&
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
mixin JmaEarthquakeNearestObservationPointRef
    on AutoDisposeFutureProviderRef<(EarthquakeParameterStationItem, double)?> {
  /// The parameter `latLng` of this provider.
  LatLng get latLng;
}

class _JmaEarthquakeNearestObservationPointProviderElement
    extends
        AutoDisposeFutureProviderElement<
          (EarthquakeParameterStationItem, double)?
        >
    with JmaEarthquakeNearestObservationPointRef {
  _JmaEarthquakeNearestObservationPointProviderElement(super.provider);

  @override
  LatLng get latLng =>
      (origin as JmaEarthquakeNearestObservationPointProvider).latLng;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
