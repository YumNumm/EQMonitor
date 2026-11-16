// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_tuning_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionTuningResolver)
final shakeDetectionTuningResolverProvider =
    ShakeDetectionTuningResolverProvider._();

final class ShakeDetectionTuningResolverProvider
    extends
        $FunctionalProvider<
          ShakeDetectionTuningResolver,
          ShakeDetectionTuningResolver,
          ShakeDetectionTuningResolver
        >
    with $Provider<ShakeDetectionTuningResolver> {
  ShakeDetectionTuningResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionTuningResolverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionTuningResolverHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionTuningResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionTuningResolver create(Ref ref) {
    return shakeDetectionTuningResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionTuningResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionTuningResolver>(value),
    );
  }
}

String _$shakeDetectionTuningResolverHash() =>
    r'146aac360b8c231f3fa79049c828ef955fb9efba';
