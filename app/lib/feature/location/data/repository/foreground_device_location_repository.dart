import 'package:eqmonitor/feature/location/data/headless/headless_device_location_dependencies.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/location/data/logic/device_location_sync_service.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/model/pending_device_location.dart';
import 'package:eqmonitor/feature/location/data/provider/device_location_sync_scope_provider.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'foreground_device_location_repository.g.dart';

@Riverpod(keepAlive: true)
ForegroundDeviceLocationRepository foregroundDeviceLocationRepository(
  Ref ref,
) => ForegroundDeviceLocationRepository(
  getPermission: ref.read(permissionRepositoryProvider).getLocationPermission,
  getPosition: () => Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.medium,
      timeLimit: Duration(seconds: 20),
    ),
  ),
  createSyncService: () async => HeadlessDeviceLocationSyncServiceBuilder.build(
    scope: await ref.read(deviceLocationSyncScopeProvider.future),
    stateRepository: ref.read(deviceLocationSyncStateRepositoryProvider),
    resolver: await ref.read(jmaRegionResolverProvider.future),
    repository: await ref.read(notificationSlotRepositoryProvider.future),
  ),
  readLastSent: () async => ref
      .read(deviceLocationSyncStateRepositoryProvider)
      .readLastSent(
        scope: await ref.read(deviceLocationSyncScopeProvider.future),
      ),
);

/// Uses the same resolver, Device Location API and deduplication as headless updates.
class const ForegroundDeviceLocationRepository({
  required final Future<LocationPermission> Function() getPermission,
  required final Future<Position> Function() getPosition,
  required final Future<DeviceLocationSyncService> Function() createSyncService,
  required final Future<DeviceLocationPayload?> Function() readLastSent,
}) {
  Future<DeviceLocationPayload?> sync() async {
    final permission = await getPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse)
      return readLastSent();
    final position = await getPosition();
    final service = await createSyncService();
    await service.syncPending(
      location: PendingDeviceLocation(
        updateId: 'foreground-${position.timestamp.millisecondsSinceEpoch}',
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        timestampMillis: position.timestamp.millisecondsSinceEpoch,
      ),
    );
    return readLastSent();
  }
}
