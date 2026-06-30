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
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
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
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return deviceMigratedFromLegacy(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$deviceMigratedFromLegacyHash() =>
    r'6cf2db036d78bb2e59bc0cb7b792358465e6968a';

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
    r'abfbe9e22dc1335a1eda91d47f41fbefc8b8472c';

abstract class _$DeviceProvisioningNotifier
    extends $AsyncNotifier<DeviceProvisioningStatus> {
  FutureOr<DeviceProvisioningStatus> build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
  }
}
