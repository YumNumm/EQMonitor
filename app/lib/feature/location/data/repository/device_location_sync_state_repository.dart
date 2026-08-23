import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';

abstract interface class DeviceLocationSyncStateRepository {
  Future<bool> isDeviceLocationSyncEnabled();

  Future<DeviceLocationPayload?> readLastSent();

  Future<void> writeLastSent(DeviceLocationPayload payload);
}

class InMemoryDeviceLocationSyncStateRepository
    implements DeviceLocationSyncStateRepository {
  new({
    this.enabled = true,
    DeviceLocationPayload? lastSent,
  }) : _lastSent = lastSent;

  final bool enabled;
  DeviceLocationPayload? _lastSent;

  @override
  Future<bool> isDeviceLocationSyncEnabled() async => enabled;

  @override
  Future<DeviceLocationPayload?> readLastSent() async => _lastSent;

  @override
  Future<void> writeLastSent(DeviceLocationPayload payload) async {
    _lastSent = payload;
  }
}
