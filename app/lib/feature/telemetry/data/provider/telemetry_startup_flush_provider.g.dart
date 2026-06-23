// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telemetry_startup_flush_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(telemetryStartupFlush)
final telemetryStartupFlushProvider = TelemetryStartupFlushProvider._();

final class TelemetryStartupFlushProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  TelemetryStartupFlushProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telemetryStartupFlushProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telemetryStartupFlushHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return telemetryStartupFlush(ref);
  }
}

String _$telemetryStartupFlushHash() =>
    r'539f520334e98fb4782f8285a1444a217fc6f7fd';
