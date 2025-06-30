// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'map_utility.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(mapUtility)
const mapUtilityProvider = MapUtilityProvider._();

final class MapUtilityProvider
    extends $FunctionalProvider<MapUtility, MapUtility>
    with $Provider<MapUtility> {
  const MapUtilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapUtilityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapUtilityHash();

  @$internal
  @override
  $ProviderElement<MapUtility> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MapUtility create(Ref ref) {
    return mapUtility(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapUtility value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<MapUtility>(value),
    );
  }
}

String _$mapUtilityHash() => r'3d663a5f886800d3ef330e26082dc7188c10caf7';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
