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
    this.themeMode,
  ) : super.internal(
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
        );

  final ThemeMode themeMode;

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

  @override
  MapConfig runNotifierBuild(
    covariant MapConfigState notifier,
  ) {
    return notifier.build(
      themeMode,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
