// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// デバイスIDを提供するProvider
/// UDIDのSHA512ハッシュをUUID形式に変換して返す

@ProviderFor(deviceId)
final deviceIdProvider = DeviceIdProvider._();

/// デバイスIDを提供するProvider
/// UDIDのSHA512ハッシュをUUID形式に変換して返す

final class DeviceIdProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// デバイスIDを提供するProvider
  /// UDIDのSHA512ハッシュをUUID形式に変換して返す
  DeviceIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceIdHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return deviceId(ref);
  }
}

String _$deviceIdHash() => r'484f9de5df37e8548c3af9c59f980a04fe57123a';
