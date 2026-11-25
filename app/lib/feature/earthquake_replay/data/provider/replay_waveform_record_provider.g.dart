// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_waveform_record_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayWaveformRecord)
final replayWaveformRecordProvider = ReplayWaveformRecordFamily._();

final class ReplayWaveformRecordProvider
    extends
        $FunctionalProvider<
          KyoshinWaveformRecord?,
          KyoshinWaveformRecord?,
          KyoshinWaveformRecord?
        >
    with $Provider<KyoshinWaveformRecord?> {
  ReplayWaveformRecordProvider._({
    required ReplayWaveformRecordFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'replayWaveformRecordProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$replayWaveformRecordHash();

  @override
  String toString() {
    return r'replayWaveformRecordProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<KyoshinWaveformRecord?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KyoshinWaveformRecord? create(Ref ref) {
    final argument = this.argument as String;
    return replayWaveformRecord(ref, stationCode: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinWaveformRecord? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinWaveformRecord?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ReplayWaveformRecordProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$replayWaveformRecordHash() =>
    r'b625542dcb64decaa134c6d9e8152e2fdc87979f';

final class ReplayWaveformRecordFamily extends $Family
    with $FunctionalFamilyOverride<KyoshinWaveformRecord?, String> {
  ReplayWaveformRecordFamily._()
    : super(
        retry: null,
        name: r'replayWaveformRecordProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReplayWaveformRecordProvider call({required String stationCode}) =>
      ReplayWaveformRecordProvider._(argument: stationCode, from: this);

  @override
  String toString() => r'replayWaveformRecordProvider';
}
