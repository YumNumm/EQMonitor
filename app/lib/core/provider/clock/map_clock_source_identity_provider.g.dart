// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'map_clock_source_identity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mapClockSourceIdentity)
final mapClockSourceIdentityProvider = MapClockSourceIdentityProvider._();

final class MapClockSourceIdentityProvider
    extends
        $FunctionalProvider<
          MapClockSourceIdentity,
          MapClockSourceIdentity,
          MapClockSourceIdentity
        >
    with $Provider<MapClockSourceIdentity> {
  MapClockSourceIdentityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapClockSourceIdentityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapClockSourceIdentityHash();

  @$internal
  @override
  $ProviderElement<MapClockSourceIdentity> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MapClockSourceIdentity create(Ref ref) {
    return mapClockSourceIdentity(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapClockSourceIdentity value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapClockSourceIdentity>(value),
    );
  }
}

String _$mapClockSourceIdentityHash() =>
    r'121c3721a95d81d4428921af39be7091f1b0f3b4';
