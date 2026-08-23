import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DeviceLocationSyncAvailability { enabled, disabled, uninitialized }

final deviceLocationSyncStateRepositoryProvider =
    Provider<SharedPreferencesDeviceLocationSyncStateRepository>(
      (ref) => SharedPreferencesDeviceLocationSyncStateRepository(
        SharedPreferencesAsync(),
      ),
    );

abstract interface class DeviceLocationSyncStateRepository {
  Future<DeviceLocationSyncAvailability> readAvailability();

  Future<void> writeAvailability(DeviceLocationSyncAvailability availability);

  Future<DeviceLocationPayload?> readLastSent();

  Future<void> writeLastSent(DeviceLocationPayload payload);
}

class InMemoryDeviceLocationSyncStateRepository
    implements DeviceLocationSyncStateRepository {
  new({
    this.availability = DeviceLocationSyncAvailability.enabled,
    DeviceLocationPayload? lastSent,
  }) : _lastSent = lastSent;

  DeviceLocationSyncAvailability availability;
  DeviceLocationPayload? _lastSent;

  @override
  Future<DeviceLocationSyncAvailability> readAvailability() async =>
      availability;

  @override
  Future<void> writeAvailability(
    DeviceLocationSyncAvailability availability,
  ) async {
    this.availability = availability;
  }

  @override
  Future<DeviceLocationPayload?> readLastSent() async => _lastSent;

  @override
  Future<void> writeLastSent(DeviceLocationPayload payload) async {
    _lastSent = payload;
  }
}

class SharedPreferencesDeviceLocationSyncStateRepository
    implements DeviceLocationSyncStateRepository {
  new(this._preferences);

  final SharedPreferencesAsync _preferences;

  @override
  Future<DeviceLocationSyncAvailability> readAvailability() async {
    final enabled = await _preferences.getBool(
      SharedPreferencesKey.backgroundLocationCurrentSlotEnabled.key,
    );
    return switch (enabled) {
      true => DeviceLocationSyncAvailability.enabled,
      false => DeviceLocationSyncAvailability.disabled,
      null => DeviceLocationSyncAvailability.uninitialized,
    };
  }

  @override
  Future<void> writeAvailability(
    DeviceLocationSyncAvailability availability,
  ) => switch (availability) {
    DeviceLocationSyncAvailability.enabled => _preferences.setBool(
      SharedPreferencesKey.backgroundLocationCurrentSlotEnabled.key,
      true,
    ),
    DeviceLocationSyncAvailability.disabled => _preferences.setBool(
      SharedPreferencesKey.backgroundLocationCurrentSlotEnabled.key,
      false,
    ),
    DeviceLocationSyncAvailability.uninitialized => _preferences.remove(
      SharedPreferencesKey.backgroundLocationCurrentSlotEnabled.key,
    ),
  };

  @override
  Future<DeviceLocationPayload?> readLastSent() async {
    final source = await _preferences.getString(
      SharedPreferencesKey.backgroundLocationLastSentPayload.key,
    );
    if (source == null) {
      return null;
    }
    try {
      final decoded = jsonDecode(source);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }
      final region = decoded['region'];
      final city = decoded['city'];
      final tsunamiForecastRegion = decoded['tsunamiForecastRegion'];
      if (region is! String ||
          city != null && city is! String ||
          tsunamiForecastRegion != null && tsunamiForecastRegion is! String) {
        return null;
      }
      return DeviceLocationPayload(
        region: region,
        city: city as String?,
        tsunamiForecastRegion: tsunamiForecastRegion as String?,
      );
    } on FormatException {
      return null;
    }
  }

  @override
  Future<void> writeLastSent(DeviceLocationPayload payload) =>
      _preferences.setString(
        SharedPreferencesKey.backgroundLocationLastSentPayload.key,
        jsonEncode(payload.toJson()),
      );
}
