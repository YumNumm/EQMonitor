// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_location_sync_state_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceLocationSyncStateRepository)
final deviceLocationSyncStateRepositoryProvider =
    DeviceLocationSyncStateRepositoryProvider._();

final class DeviceLocationSyncStateRepositoryProvider
    extends
        $FunctionalProvider<
          DeviceLocationSyncStateRepository,
          DeviceLocationSyncStateRepository,
          DeviceLocationSyncStateRepository
        >
    with $Provider<DeviceLocationSyncStateRepository> {
  DeviceLocationSyncStateRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceLocationSyncStateRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$deviceLocationSyncStateRepositoryHash();

  @$internal
  @override
  $ProviderElement<DeviceLocationSyncStateRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceLocationSyncStateRepository create(Ref ref) {
    return deviceLocationSyncStateRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceLocationSyncStateRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceLocationSyncStateRepository>(
        value,
      ),
    );
  }
}

String _$deviceLocationSyncStateRepositoryHash() =>
    r'6038c2afd8855b03544f9067cbedba9fcf311107';
