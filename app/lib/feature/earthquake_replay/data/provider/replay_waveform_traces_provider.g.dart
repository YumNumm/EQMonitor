// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_waveform_traces_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayWaveformTraces)
final replayWaveformTracesProvider = ReplayWaveformTracesFamily._();

final class ReplayWaveformTracesProvider
    extends
        $FunctionalProvider<
          List<KyoshinWaveformTrace>,
          List<KyoshinWaveformTrace>,
          List<KyoshinWaveformTrace>
        >
    with $Provider<List<KyoshinWaveformTrace>> {
  ReplayWaveformTracesProvider._({
    required ReplayWaveformTracesFamily super.from,
    required ({String stationCode, KyoshinWaveformQuantity quantity})
    super.argument,
  }) : super(
         retry: null,
         name: r'replayWaveformTracesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$replayWaveformTracesHash();

  @override
  String toString() {
    return r'replayWaveformTracesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<List<KyoshinWaveformTrace>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<KyoshinWaveformTrace> create(Ref ref) {
    final argument =
        this.argument
            as ({String stationCode, KyoshinWaveformQuantity quantity});
    return replayWaveformTraces(
      ref,
      stationCode: argument.stationCode,
      quantity: argument.quantity,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<KyoshinWaveformTrace> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<KyoshinWaveformTrace>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ReplayWaveformTracesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$replayWaveformTracesHash() =>
    r'd6e864537bfaff205618ac7a64ec347051adf3d2';

final class ReplayWaveformTracesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          List<KyoshinWaveformTrace>,
          ({String stationCode, KyoshinWaveformQuantity quantity})
        > {
  ReplayWaveformTracesFamily._()
    : super(
        retry: null,
        name: r'replayWaveformTracesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReplayWaveformTracesProvider call({
    required String stationCode,
    required KyoshinWaveformQuantity quantity,
  }) => ReplayWaveformTracesProvider._(
    argument: (stationCode: stationCode, quantity: quantity),
    from: this,
  );

  @override
  String toString() => r'replayWaveformTracesProvider';
}
