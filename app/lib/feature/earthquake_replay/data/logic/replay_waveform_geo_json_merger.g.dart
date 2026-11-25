// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_waveform_geo_json_merger.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayWaveformGeoJsonMerger)
final replayWaveformGeoJsonMergerProvider =
    ReplayWaveformGeoJsonMergerProvider._();

final class ReplayWaveformGeoJsonMergerProvider
    extends
        $FunctionalProvider<
          ReplayWaveformGeoJsonMerger,
          ReplayWaveformGeoJsonMerger,
          ReplayWaveformGeoJsonMerger
        >
    with $Provider<ReplayWaveformGeoJsonMerger> {
  ReplayWaveformGeoJsonMergerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayWaveformGeoJsonMergerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayWaveformGeoJsonMergerHash();

  @$internal
  @override
  $ProviderElement<ReplayWaveformGeoJsonMerger> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayWaveformGeoJsonMerger create(Ref ref) {
    return replayWaveformGeoJsonMerger(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayWaveformGeoJsonMerger value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayWaveformGeoJsonMerger>(value),
    );
  }
}

String _$replayWaveformGeoJsonMergerHash() =>
    r'c66ca4ff7ebe027a2cf2531dc8a42374ad40b38f';
