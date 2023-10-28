// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'map_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mapViewModelHash() => r'0ef793550ee4cadd1fe977b7b1d9105d59a5473f';

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

abstract class _$MapViewModel extends BuildlessAutoDisposeNotifier<MapState> {
  late final Key key;

  MapState build(
    Key key,
  );
}

/// See also [MapViewModel].
@ProviderFor(MapViewModel)
const mapViewModelProvider = MapViewModelFamily();

/// See also [MapViewModel].
class MapViewModelFamily extends Family<MapState> {
  /// See also [MapViewModel].
  const MapViewModelFamily();

  /// See also [MapViewModel].
  MapViewModelProvider call(
    Key key,
  ) {
    return MapViewModelProvider(
      key,
    );
  }

  @override
  MapViewModelProvider getProviderOverride(
    covariant MapViewModelProvider provider,
  ) {
    return call(
      provider.key,
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
  String? get name => r'mapViewModelProvider';
}

/// See also [MapViewModel].
class MapViewModelProvider
    extends AutoDisposeNotifierProviderImpl<MapViewModel, MapState> {
  /// See also [MapViewModel].
  MapViewModelProvider(
    Key key,
  ) : this._internal(
          () => MapViewModel()..key = key,
          from: mapViewModelProvider,
          name: r'mapViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mapViewModelHash,
          dependencies: MapViewModelFamily._dependencies,
          allTransitiveDependencies:
              MapViewModelFamily._allTransitiveDependencies,
          key: key,
        );

  MapViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
  }) : super.internal();

  final Key key;

  @override
  MapState runNotifierBuild(
    covariant MapViewModel notifier,
  ) {
    return notifier.build(
      key,
    );
  }

  @override
  Override overrideWith(MapViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: MapViewModelProvider._internal(
        () => create()..key = key,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<MapViewModel, MapState> createElement() {
    return _MapViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MapViewModelProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MapViewModelRef on AutoDisposeNotifierProviderRef<MapState> {
  /// The parameter `key` of this provider.
  Key get key;
}

class _MapViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<MapViewModel, MapState>
    with MapViewModelRef {
  _MapViewModelProviderElement(super.provider);

  @override
  Key get key => (origin as MapViewModelProvider).key;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
