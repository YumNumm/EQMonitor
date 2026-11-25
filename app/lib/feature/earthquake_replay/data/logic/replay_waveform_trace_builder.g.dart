// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_waveform_trace_builder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayWaveformTraceBuilder)
final replayWaveformTraceBuilderProvider =
    ReplayWaveformTraceBuilderProvider._();

final class ReplayWaveformTraceBuilderProvider
    extends
        $FunctionalProvider<
          ReplayWaveformTraceBuilder,
          ReplayWaveformTraceBuilder,
          ReplayWaveformTraceBuilder
        >
    with $Provider<ReplayWaveformTraceBuilder> {
  ReplayWaveformTraceBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayWaveformTraceBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayWaveformTraceBuilderHash();

  @$internal
  @override
  $ProviderElement<ReplayWaveformTraceBuilder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayWaveformTraceBuilder create(Ref ref) {
    return replayWaveformTraceBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayWaveformTraceBuilder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayWaveformTraceBuilder>(value),
    );
  }
}

String _$replayWaveformTraceBuilderHash() =>
    r'76d769aad4db9e1ae5b93c9ea16c9635c1b8893f';
