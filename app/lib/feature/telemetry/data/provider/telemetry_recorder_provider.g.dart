// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telemetry_recorder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(telemetryRecorder)
final telemetryRecorderProvider = TelemetryRecorderProvider._();

final class TelemetryRecorderProvider
    extends
        $FunctionalProvider<
          TelemetryRecorder,
          TelemetryRecorder,
          TelemetryRecorder
        >
    with $Provider<TelemetryRecorder> {
  TelemetryRecorderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telemetryRecorderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telemetryRecorderHash();

  @$internal
  @override
  $ProviderElement<TelemetryRecorder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TelemetryRecorder create(Ref ref) {
    return telemetryRecorder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TelemetryRecorder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TelemetryRecorder>(value),
    );
  }
}

String _$telemetryRecorderHash() => r'a0ac094897646fe3f513b5ccd0bf4c9ed1ad4f48';
