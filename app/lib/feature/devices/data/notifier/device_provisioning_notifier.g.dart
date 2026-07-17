// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_provisioning_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceMigratedFromLegacy)
final deviceMigratedFromLegacyProvider = DeviceMigratedFromLegacyProvider._();

final class DeviceMigratedFromLegacyProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  DeviceMigratedFromLegacyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceMigratedFromLegacyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceMigratedFromLegacyHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return deviceMigratedFromLegacy(ref);
  }
}

String _$deviceMigratedFromLegacyHash() =>
    r'9f302518711450e8b0eaeb624d994fcb67966149';

@ProviderFor(DeviceProvisioningNotifier)
final deviceProvisioningProvider = DeviceProvisioningNotifierProvider._();

final class DeviceProvisioningNotifierProvider
    extends
        $AsyncNotifierProvider<
          DeviceProvisioningNotifier,
          DeviceProvisioningStatus
        > {
  DeviceProvisioningNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceProvisioningProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceProvisioningNotifierHash();

  @$internal
  @override
  DeviceProvisioningNotifier create() => DeviceProvisioningNotifier();
}

String _$deviceProvisioningNotifierHash() =>
    r'6d9a2206876270657a7b1d4e8a6b1fb63fb570d3';

abstract class _$DeviceProvisioningNotifier
    extends $AsyncNotifier<DeviceProvisioningStatus> {
  FutureOr<DeviceProvisioningStatus> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<DeviceProvisioningStatus>,
              DeviceProvisioningStatus
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<DeviceProvisioningStatus>,
                DeviceProvisioningStatus
              >,
              AsyncValue<DeviceProvisioningStatus>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
