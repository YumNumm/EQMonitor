// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_clock_progress.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayClockProgress)
final replayClockProgressProvider = ReplayClockProgressProvider._();

final class ReplayClockProgressProvider
    extends
        $FunctionalProvider<
          ReplayClockProgress,
          ReplayClockProgress,
          ReplayClockProgress
        >
    with $Provider<ReplayClockProgress> {
  ReplayClockProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayClockProgressProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayClockProgressHash();

  @$internal
  @override
  $ProviderElement<ReplayClockProgress> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayClockProgress create(Ref ref) {
    return replayClockProgress(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayClockProgress value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayClockProgress>(value),
    );
  }
}

String _$replayClockProgressHash() =>
    r'fdf4cb4625739027badc1f3993f0d1480cdb330e';
