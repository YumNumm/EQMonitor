// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_provisioning_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
    r'4322a87c90df357ce201f8effde05d7bf7d7e3bb';

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
