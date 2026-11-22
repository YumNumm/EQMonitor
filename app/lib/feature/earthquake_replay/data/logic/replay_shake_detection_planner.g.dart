// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_shake_detection_planner.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayShakeDetectionPlanner)
final replayShakeDetectionPlannerProvider =
    ReplayShakeDetectionPlannerProvider._();

final class ReplayShakeDetectionPlannerProvider
    extends
        $FunctionalProvider<
          ReplayShakeDetectionPlanner,
          ReplayShakeDetectionPlanner,
          ReplayShakeDetectionPlanner
        >
    with $Provider<ReplayShakeDetectionPlanner> {
  ReplayShakeDetectionPlannerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayShakeDetectionPlannerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayShakeDetectionPlannerHash();

  @$internal
  @override
  $ProviderElement<ReplayShakeDetectionPlanner> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayShakeDetectionPlanner create(Ref ref) {
    return replayShakeDetectionPlanner(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayShakeDetectionPlanner value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayShakeDetectionPlanner>(value),
    );
  }
}

String _$replayShakeDetectionPlannerHash() =>
    r'1a3d59d7b822a36a848d59900eb0f9c2da85382c';
