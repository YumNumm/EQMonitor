// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_device_storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayDeviceStorage)
final replayDeviceStorageProvider = ReplayDeviceStorageProvider._();

final class ReplayDeviceStorageProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeviceStorage?>,
          DeviceStorage?,
          FutureOr<DeviceStorage?>
        >
    with $FutureModifier<DeviceStorage?>, $FutureProvider<DeviceStorage?> {
  ReplayDeviceStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayDeviceStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayDeviceStorageHash();

  @$internal
  @override
  $FutureProviderElement<DeviceStorage?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DeviceStorage?> create(Ref ref) {
    return replayDeviceStorage(ref);
  }
}

String _$replayDeviceStorageHash() =>
    r'6ff8a2b3449db2500f0453f19086c1e748a7defc';
