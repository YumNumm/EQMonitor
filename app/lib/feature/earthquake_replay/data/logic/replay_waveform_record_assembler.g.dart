// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_waveform_record_assembler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayWaveformRecordAssembler)
final replayWaveformRecordAssemblerProvider =
    ReplayWaveformRecordAssemblerProvider._();

final class ReplayWaveformRecordAssemblerProvider
    extends
        $FunctionalProvider<
          ReplayWaveformRecordAssembler,
          ReplayWaveformRecordAssembler,
          ReplayWaveformRecordAssembler
        >
    with $Provider<ReplayWaveformRecordAssembler> {
  ReplayWaveformRecordAssemblerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayWaveformRecordAssemblerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayWaveformRecordAssemblerHash();

  @$internal
  @override
  $ProviderElement<ReplayWaveformRecordAssembler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayWaveformRecordAssembler create(Ref ref) {
    return replayWaveformRecordAssembler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayWaveformRecordAssembler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayWaveformRecordAssembler>(
        value,
      ),
    );
  }
}

String _$replayWaveformRecordAssemblerHash() =>
    r'79d323f40cccbb877e667e7e93b7bad8cd47fc86';
