// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_location_sync_scope_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceLocationSyncScope)
final deviceLocationSyncScopeProvider = DeviceLocationSyncScopeProvider._();

final class DeviceLocationSyncScopeProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeviceLocationSyncScope>,
          DeviceLocationSyncScope,
          FutureOr<DeviceLocationSyncScope>
        >
    with
        $FutureModifier<DeviceLocationSyncScope>,
        $FutureProvider<DeviceLocationSyncScope> {
  DeviceLocationSyncScopeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceLocationSyncScopeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceLocationSyncScopeHash();

  @$internal
  @override
  $FutureProviderElement<DeviceLocationSyncScope> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DeviceLocationSyncScope> create(Ref ref) {
    return deviceLocationSyncScope(ref);
  }
}

String _$deviceLocationSyncScopeHash() =>
    r'b14433db940e2407c541582bdeac418e4b84e9e3';
