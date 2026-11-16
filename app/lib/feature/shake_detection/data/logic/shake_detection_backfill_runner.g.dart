// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_backfill_runner.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionBackfillRunner)
final shakeDetectionBackfillRunnerProvider =
    ShakeDetectionBackfillRunnerProvider._();

final class ShakeDetectionBackfillRunnerProvider
    extends
        $FunctionalProvider<
          ShakeDetectionBackfillRunner,
          ShakeDetectionBackfillRunner,
          ShakeDetectionBackfillRunner
        >
    with $Provider<ShakeDetectionBackfillRunner> {
  ShakeDetectionBackfillRunnerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionBackfillRunnerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionBackfillRunnerHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionBackfillRunner> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionBackfillRunner create(Ref ref) {
    return shakeDetectionBackfillRunner(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionBackfillRunner value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionBackfillRunner>(value),
    );
  }
}

String _$shakeDetectionBackfillRunnerHash() =>
    r'590a81aa7d357647ab925163a128fce2dd0c0849';
