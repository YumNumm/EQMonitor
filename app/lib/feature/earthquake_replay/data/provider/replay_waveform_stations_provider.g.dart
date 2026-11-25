// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_waveform_stations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayWaveformStations)
final replayWaveformStationsProvider = ReplayWaveformStationsProvider._();

final class ReplayWaveformStationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReplayWaveformStation>>,
          List<ReplayWaveformStation>,
          FutureOr<List<ReplayWaveformStation>>
        >
    with
        $FutureModifier<List<ReplayWaveformStation>>,
        $FutureProvider<List<ReplayWaveformStation>> {
  ReplayWaveformStationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayWaveformStationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayWaveformStationsHash();

  @$internal
  @override
  $FutureProviderElement<List<ReplayWaveformStation>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReplayWaveformStation>> create(Ref ref) {
    return replayWaveformStations(ref);
  }
}

String _$replayWaveformStationsHash() =>
    r'aa36bf9286f5e617432b2fd665e3319f9a5da46d';
