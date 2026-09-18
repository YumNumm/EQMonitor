// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_location_monitoring_reconciler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceLocationMonitoringReconciler)
final deviceLocationMonitoringReconcilerProvider =
    DeviceLocationMonitoringReconcilerProvider._();

final class DeviceLocationMonitoringReconcilerProvider
    extends
        $FunctionalProvider<
          DeviceLocationMonitoringReconciler,
          DeviceLocationMonitoringReconciler,
          DeviceLocationMonitoringReconciler
        >
    with $Provider<DeviceLocationMonitoringReconciler> {
  DeviceLocationMonitoringReconcilerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceLocationMonitoringReconcilerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$deviceLocationMonitoringReconcilerHash();

  @$internal
  @override
  $ProviderElement<DeviceLocationMonitoringReconciler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceLocationMonitoringReconciler create(Ref ref) {
    return deviceLocationMonitoringReconciler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceLocationMonitoringReconciler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceLocationMonitoringReconciler>(
        value,
      ),
    );
  }
}

String _$deviceLocationMonitoringReconcilerHash() =>
    r'896364e90012285fc0c2b7483ec494498387d84f';
