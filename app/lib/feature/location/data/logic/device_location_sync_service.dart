import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/model/pending_device_location.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';

enum DeviceLocationSyncResult {
  sent,
  unchanged,
  disabled,
  uninitialized,
  noPending,
}

typedef ResolveDeviceLocationPayload = Future<DeviceLocationPayload?> Function({
  required double latitude,
  required double longitude,
});

typedef SendDeviceLocationPayload = Future<void> Function({
  required DeviceLocationPayload payload,
});

class DeviceLocationSyncService {
  const new({
    required this.scope,
    required this.stateRepository,
    required this.resolvePayload,
    required this.sendPayload,
  });

  final DeviceLocationSyncScope scope;
  final DeviceLocationSyncStateRepository stateRepository;
  final ResolveDeviceLocationPayload resolvePayload;
  final SendDeviceLocationPayload sendPayload;

  Future<DeviceLocationSyncResult> syncPending({
    required PendingDeviceLocation? location,
  }) async {
    if (location == null) {
      return DeviceLocationSyncResult.noPending;
    }
    final availability = await stateRepository.readAvailability();
    switch (availability) {
      case DeviceLocationSyncAvailability.disabled:
        return DeviceLocationSyncResult.disabled;
      case DeviceLocationSyncAvailability.uninitialized:
        return DeviceLocationSyncResult.uninitialized;
      case DeviceLocationSyncAvailability.enabled:
        break;
    }

    final payload = await resolvePayload(
      latitude: location.latitude,
      longitude: location.longitude,
    );
    if (payload == null) {
      throw StateError('端末内で地域コードを解決できませんでした');
    }

    final previous = await stateRepository.readLastSent(scope: scope);
    if (previous == payload) {
      return DeviceLocationSyncResult.unchanged;
    }

    await sendPayload(payload: payload);
    await stateRepository.writeLastSent(scope: scope, payload: payload);
    return DeviceLocationSyncResult.sent;
  }
}
