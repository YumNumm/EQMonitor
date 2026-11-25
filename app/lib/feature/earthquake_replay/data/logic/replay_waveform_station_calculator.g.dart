// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_waveform_station_calculator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayWaveformStationCalculator)
final replayWaveformStationCalculatorProvider =
    ReplayWaveformStationCalculatorProvider._();

final class ReplayWaveformStationCalculatorProvider
    extends
        $FunctionalProvider<
          ReplayWaveformStationCalculator,
          ReplayWaveformStationCalculator,
          ReplayWaveformStationCalculator
        >
    with $Provider<ReplayWaveformStationCalculator> {
  ReplayWaveformStationCalculatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayWaveformStationCalculatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayWaveformStationCalculatorHash();

  @$internal
  @override
  $ProviderElement<ReplayWaveformStationCalculator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayWaveformStationCalculator create(Ref ref) {
    return replayWaveformStationCalculator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayWaveformStationCalculator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayWaveformStationCalculator>(
        value,
      ),
    );
  }
}

String _$replayWaveformStationCalculatorHash() =>
    r'eeda74584c3426029fe6abb79a0c21c8926bc80d';
