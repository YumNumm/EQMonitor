// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_waveform_features_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayWaveformStationNames)
final replayWaveformStationNamesProvider =
    ReplayWaveformStationNamesProvider._();

final class ReplayWaveformStationNamesProvider
    extends
        $FunctionalProvider<
          Map<String, String>,
          Map<String, String>,
          Map<String, String>
        >
    with $Provider<Map<String, String>> {
  ReplayWaveformStationNamesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayWaveformStationNamesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayWaveformStationNamesHash();

  @$internal
  @override
  $ProviderElement<Map<String, String>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, String> create(Ref ref) {
    return replayWaveformStationNames(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, String>>(value),
    );
  }
}

String _$replayWaveformStationNamesHash() =>
    r'b00b4297e1acd1990a25f83b16a97e43fc82baa5';

@ProviderFor(replayWaveformFeatures)
final replayWaveformFeaturesProvider = ReplayWaveformFeaturesProvider._();

final class ReplayWaveformFeaturesProvider
    extends
        $FunctionalProvider<
          List<Map<String, dynamic>>,
          List<Map<String, dynamic>>,
          List<Map<String, dynamic>>
        >
    with $Provider<List<Map<String, dynamic>>> {
  ReplayWaveformFeaturesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayWaveformFeaturesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayWaveformFeaturesHash();

  @$internal
  @override
  $ProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<Map<String, dynamic>> create(Ref ref) {
    return replayWaveformFeatures(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Map<String, dynamic>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Map<String, dynamic>>>(value),
    );
  }
}

String _$replayWaveformFeaturesHash() =>
    r'b12638ebea00d8d0b6dba3c966a4f239bd54a3ae';
