// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'map_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mapConfigStateHash() => r'741e46eddd2534115de6ea3fb5f70774dd917c6b';

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

abstract class _$MapConfigState extends BuildlessNotifier<MapConfig> {
  late final ThemeMode themeMode;

  MapConfig build(
    ThemeMode themeMode,
  );
}

/// See also [MapConfigState].
@ProviderFor(MapConfigState)
const mapConfigStateProvider = MapConfigStateFamily();

/// See also [MapConfigState].
class MapConfigStateFamily extends Family<MapConfig> {
  /// See also [MapConfigState].
  const MapConfigStateFamily();

  /// See also [MapConfigState].
  MapConfigStateProvider call(
    ThemeMode themeMode,
  ) {
    return MapConfigStateProvider(
      themeMode,
    );
  }

  @override
  MapConfigStateProvider getProviderOverride(
    covariant MapConfigStateProvider provider,
  ) {
    return call(
      provider.themeMode,
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
  String? get name => r'mapConfigStateProvider';
}

/// See also [MapConfigState].
class MapConfigStateProvider
    extends NotifierProviderImpl<MapConfigState, MapConfig> {
  /// See also [MapConfigState].
  MapConfigStateProvider(
    ThemeMode themeMode,
  ) : this._internal(
          () => MapConfigState()..themeMode = themeMode,
          from: mapConfigStateProvider,
          name: r'mapConfigStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mapConfigStateHash,
          dependencies: MapConfigStateFamily._dependencies,
          allTransitiveDependencies:
              MapConfigStateFamily._allTransitiveDependencies,
          themeMode: themeMode,
        );

  MapConfigStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.themeMode,
  }) : super.internal();

  final ThemeMode themeMode;

  @override
  MapConfig runNotifierBuild(
    covariant MapConfigState notifier,
  ) {
    return notifier.build(
      themeMode,
    );
  }

  @override
  Override overrideWith(MapConfigState Function() create) {
    return ProviderOverride(
      origin: this,
      override: MapConfigStateProvider._internal(
        () => create()..themeMode = themeMode,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        themeMode: themeMode,
      ),
    );
  }

  @override
  NotifierProviderElement<MapConfigState, MapConfig> createElement() {
    return _MapConfigStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MapConfigStateProvider && other.themeMode == themeMode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, themeMode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MapConfigStateRef on NotifierProviderRef<MapConfig> {
  /// The parameter `themeMode` of this provider.
  ThemeMode get themeMode;
}

class _MapConfigStateProviderElement
    extends NotifierProviderElement<MapConfigState, MapConfig>
    with MapConfigStateRef {
  _MapConfigStateProviderElement(super.provider);

  @override
  ThemeMode get themeMode => (origin as MapConfigStateProvider).themeMode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
