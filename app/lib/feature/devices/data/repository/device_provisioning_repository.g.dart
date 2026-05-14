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
          DeviceProvisioningRepository,
          DeviceProvisioningRepository,
          DeviceProvisioningRepository
        >
    with $Provider<DeviceProvisioningRepository> {
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
  $ProviderElement<DeviceProvisioningRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceProvisioningRepository create(Ref ref) {
    return deviceProvisioningRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceProvisioningRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceProvisioningRepository>(value),
    );
  }
}

String _$deviceProvisioningRepositoryHash() =>
    r'0939c4a05704d4647d351cfee14fb98dd7996f3e';
