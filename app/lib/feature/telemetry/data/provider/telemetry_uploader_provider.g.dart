// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telemetry_uploader_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(telemetryUploader)
final telemetryUploaderProvider = TelemetryUploaderProvider._();

final class TelemetryUploaderProvider
    extends
        $FunctionalProvider<
          TelemetryUploader,
          TelemetryUploader,
          TelemetryUploader
        >
    with $Provider<TelemetryUploader> {
  TelemetryUploaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telemetryUploaderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telemetryUploaderHash();

  @$internal
  @override
  $ProviderElement<TelemetryUploader> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TelemetryUploader create(Ref ref) {
    return telemetryUploader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TelemetryUploader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TelemetryUploader>(value),
    );
  }
}

String _$telemetryUploaderHash() => r'30769600dc9a6b9f4fb5bceb0baab86104f07edd';
