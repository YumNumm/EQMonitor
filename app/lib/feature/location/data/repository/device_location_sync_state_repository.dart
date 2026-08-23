import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final deviceLocationSyncStateRepositoryProvider =
    Provider<SharedPreferencesDeviceLocationSyncStateRepository>(
      (ref) => SharedPreferencesDeviceLocationSyncStateRepository(
        SharedPreferencesAsync(),
      ),
    );

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

class SharedPreferencesDeviceLocationSyncStateRepository
    implements DeviceLocationSyncStateRepository {
  new(this._preferences);

  final SharedPreferencesAsync _preferences;

  @override
  Future<bool> isDeviceLocationSyncEnabled() async =>
      await _preferences.getBool(
        SharedPreferencesKey.backgroundLocationCurrentSlotEnabled.key,
      ) ??
      false;

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

  Future<void> writeDeviceLocationSyncEnabled({required bool enabled}) =>
      _preferences.setBool(
        SharedPreferencesKey.backgroundLocationCurrentSlotEnabled.key,
        enabled,
      );
}
