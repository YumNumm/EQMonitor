// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'travel_time_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(travelTime)
const travelTimeProvider = TravelTimeProvider._();

final class TravelTimeProvider
    extends $FunctionalProvider<TravelTimeTables, TravelTimeTables>
    with $Provider<TravelTimeTables> {
  const TravelTimeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'travelTimeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$travelTimeHash();

  @$internal
  @override
  $ProviderElement<TravelTimeTables> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TravelTimeTables create(Ref ref) {
    return travelTime(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TravelTimeTables value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<TravelTimeTables>(value),
    );
  }
}

String _$travelTimeHash() => r'64b0091c63436d40dd0f6043fcc05e804ad00964';

@ProviderFor(travelTimeInternal)
const travelTimeInternalProvider = TravelTimeInternalProvider._();

final class TravelTimeInternalProvider
    extends
        $FunctionalProvider<
          AsyncValue<TravelTimeTables>,
          FutureOr<TravelTimeTables>
        >
    with $FutureModifier<TravelTimeTables>, $FutureProvider<TravelTimeTables> {
  const TravelTimeInternalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'travelTimeInternalProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$travelTimeInternalHash();

  @$internal
  @override
  $FutureProviderElement<TravelTimeTables> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TravelTimeTables> create(Ref ref) {
    return travelTimeInternal(ref);
  }
}

String _$travelTimeInternalHash() =>
    r'e3fd821da9e8d04c0ff59076ebb98b85ac978e3f';

@ProviderFor(travelTimeDepthMap)
const travelTimeDepthMapProvider = TravelTimeDepthMapProvider._();

final class TravelTimeDepthMapProvider
    extends $FunctionalProvider<TravelTimeDepthMap, TravelTimeDepthMap>
    with $Provider<TravelTimeDepthMap> {
  const TravelTimeDepthMapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'travelTimeDepthMapProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$travelTimeDepthMapHash();

  @$internal
  @override
  $ProviderElement<TravelTimeDepthMap> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TravelTimeDepthMap create(Ref ref) {
    return travelTimeDepthMap(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TravelTimeDepthMap value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<TravelTimeDepthMap>(value),
    );
  }
}

String _$travelTimeDepthMapHash() =>
    r'dae2dec61f482a44877c74c71d28b94d4065c643';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
