// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_id_decoder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceIdDecoder)
final deviceIdDecoderProvider = DeviceIdDecoderProvider._();

final class DeviceIdDecoderProvider
    extends
        $FunctionalProvider<DeviceIdDecoder, DeviceIdDecoder, DeviceIdDecoder>
    with $Provider<DeviceIdDecoder> {
  DeviceIdDecoderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceIdDecoderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceIdDecoderHash();

  @$internal
  @override
  $ProviderElement<DeviceIdDecoder> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeviceIdDecoder create(Ref ref) {
    return deviceIdDecoder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceIdDecoder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceIdDecoder>(value),
    );
  }
}

String _$deviceIdDecoderHash() => r'd3ee39db712c7a1ee7d75fa730ba73f62599e938';
