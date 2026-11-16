// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_region_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionRegionResolver)
final shakeDetectionRegionResolverProvider =
    ShakeDetectionRegionResolverProvider._();

final class ShakeDetectionRegionResolverProvider
    extends
        $FunctionalProvider<
          ShakeDetectionRegionResolver,
          ShakeDetectionRegionResolver,
          ShakeDetectionRegionResolver
        >
    with $Provider<ShakeDetectionRegionResolver> {
  ShakeDetectionRegionResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionRegionResolverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionRegionResolverHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionRegionResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionRegionResolver create(Ref ref) {
    return shakeDetectionRegionResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionRegionResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionRegionResolver>(value),
    );
  }
}

String _$shakeDetectionRegionResolverHash() =>
    r'cc5bfa17a1a4b2b47ffdc974d6febf7395b932fa';
