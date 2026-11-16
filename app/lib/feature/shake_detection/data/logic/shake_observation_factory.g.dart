// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_observation_factory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeObservationFactory)
final shakeObservationFactoryProvider = ShakeObservationFactoryProvider._();

final class ShakeObservationFactoryProvider
    extends
        $FunctionalProvider<
          ShakeObservationFactory,
          ShakeObservationFactory,
          ShakeObservationFactory
        >
    with $Provider<ShakeObservationFactory> {
  ShakeObservationFactoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeObservationFactoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeObservationFactoryHash();

  @$internal
  @override
  $ProviderElement<ShakeObservationFactory> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeObservationFactory create(Ref ref) {
    return shakeObservationFactory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeObservationFactory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeObservationFactory>(value),
    );
  }
}

String _$shakeObservationFactoryHash() =>
    r'9fb34eb50438e43f9c4fd7db898da6c9372d1f9f';
