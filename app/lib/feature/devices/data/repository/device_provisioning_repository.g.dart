// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_provisioning_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceProvisioningRepository)
final deviceProvisioningRepositoryProvider =
    DeviceProvisioningRepositoryProvider._();

final class DeviceProvisioningRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeviceProvisioningRepository>,
          DeviceProvisioningRepository,
          FutureOr<DeviceProvisioningRepository>
        >
    with
        $FutureModifier<DeviceProvisioningRepository>,
        $FutureProvider<DeviceProvisioningRepository> {
  DeviceProvisioningRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceProvisioningRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceProvisioningRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<DeviceProvisioningRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DeviceProvisioningRepository> create(Ref ref) {
    return deviceProvisioningRepository(ref);
  }
}

String _$deviceProvisioningRepositoryHash() =>
    r'549bc0a97ac558a3ca65f301d5e3fe11847946d9';
