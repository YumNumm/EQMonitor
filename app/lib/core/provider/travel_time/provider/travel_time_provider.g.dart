// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'travel_time_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(travelTime)
final travelTimeProvider = TravelTimeProvider._();

final class TravelTimeProvider
    extends
        $FunctionalProvider<
          TravelTimeTables,
          TravelTimeTables,
          TravelTimeTables
        >
    with $Provider<TravelTimeTables> {
  TravelTimeProvider._()
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
      providerOverride: $SyncValueProvider<TravelTimeTables>(value),
    );
  }
}

String _$travelTimeHash() => r'64b0091c63436d40dd0f6043fcc05e804ad00964';

@ProviderFor(travelTimeInternal)
final travelTimeInternalProvider = TravelTimeInternalProvider._();

final class TravelTimeInternalProvider
    extends
        $FunctionalProvider<
          AsyncValue<TravelTimeTables>,
          TravelTimeTables,
          FutureOr<TravelTimeTables>
        >
    with $FutureModifier<TravelTimeTables>, $FutureProvider<TravelTimeTables> {
  TravelTimeInternalProvider._()
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
    r'afba3441dccb7558d89f86ab4eab300b7170c3b0';

@ProviderFor(travelTimeDepthMap)
final travelTimeDepthMapProvider = TravelTimeDepthMapProvider._();

final class TravelTimeDepthMapProvider
    extends
        $FunctionalProvider<
          TravelTimeDepthMap?,
          TravelTimeDepthMap?,
          TravelTimeDepthMap?
        >
    with $Provider<TravelTimeDepthMap?> {
  TravelTimeDepthMapProvider._()
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
  $ProviderElement<TravelTimeDepthMap?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TravelTimeDepthMap? create(Ref ref) {
    return travelTimeDepthMap(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TravelTimeDepthMap? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TravelTimeDepthMap?>(value),
    );
  }
}

String _$travelTimeDepthMapHash() =>
    r'9a36ac92ca94706ab65310ba1ed2219b505ff43e';
