// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_baseline_planner.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionBaselinePlanner)
final shakeDetectionBaselinePlannerProvider =
    ShakeDetectionBaselinePlannerProvider._();

final class ShakeDetectionBaselinePlannerProvider
    extends
        $FunctionalProvider<
          ShakeDetectionBaselinePlanner,
          ShakeDetectionBaselinePlanner,
          ShakeDetectionBaselinePlanner
        >
    with $Provider<ShakeDetectionBaselinePlanner> {
  ShakeDetectionBaselinePlannerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionBaselinePlannerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionBaselinePlannerHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionBaselinePlanner> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionBaselinePlanner create(Ref ref) {
    return shakeDetectionBaselinePlanner(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionBaselinePlanner value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionBaselinePlanner>(
        value,
      ),
    );
  }
}

String _$shakeDetectionBaselinePlannerHash() =>
    r'a040c30e36ea2c5ef790364b4937ee5cc9aa6a86';
