import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DeviceLocationSyncAvailability { enabled, disabled, uninitialized }

class DeviceLocationSyncScope {
  const new({
    required this.apiEndpoint,
    required this.registrationGeneration,
  });

  static DeviceLocationSyncScope fromApiBaseUrl({
    required String apiBaseUrl,
    required String registrationGeneration,
  }) {
    final baseUri = Uri.parse(apiBaseUrl);
    return DeviceLocationSyncScope(
      apiEndpoint: Uri.parse(
        baseUri.origin,
      ).resolve('/v2/device/me/location').toString(),
      registrationGeneration: registrationGeneration,
    );
  }

  final String apiEndpoint;
  final String registrationGeneration;

  @override
  bool operator ==(Object other) =>
      other is DeviceLocationSyncScope &&
      other.apiEndpoint == apiEndpoint &&
      other.registrationGeneration == registrationGeneration;

  @override
  int get hashCode => Object.hash(apiEndpoint, registrationGeneration);
}

final deviceLocationSyncStateRepositoryProvider =
    Provider<SharedPreferencesDeviceLocationSyncStateRepository>(
      (ref) => SharedPreferencesDeviceLocationSyncStateRepository(
        SharedPreferencesAsync(),
      ),
    );

abstract interface class DeviceLocationSyncStateRepository {
  Future<DeviceLocationSyncAvailability> readAvailability();

  Future<void> writeAvailability(DeviceLocationSyncAvailability availability);

  Future<DeviceLocationPayload?> readLastSent({
    required DeviceLocationSyncScope scope,
  });

  Future<void> writeLastSent({
    required DeviceLocationSyncScope scope,
    required DeviceLocationPayload payload,
  });
}

class InMemoryDeviceLocationSyncStateRepository
    implements DeviceLocationSyncStateRepository {
  new({
    this.availability = DeviceLocationSyncAvailability.enabled,
    this.lastSentScope,
    DeviceLocationPayload? lastSent,
  }) : _lastSent = lastSent;

  DeviceLocationSyncAvailability availability;
  DeviceLocationSyncScope? lastSentScope;
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
  Future<DeviceLocationPayload?> readLastSent({
    required DeviceLocationSyncScope scope,
  }) async => lastSentScope == scope ? _lastSent : null;

  @override
  Future<void> writeLastSent({
    required DeviceLocationSyncScope scope,
    required DeviceLocationPayload payload,
  }) async {
    lastSentScope = scope;
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
  Future<DeviceLocationPayload?> readLastSent({
    required DeviceLocationSyncScope scope,
  }) async {
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
      final storedScope = decoded['scope'];
      final storedPayload = decoded['payload'];
      if (storedScope is! Map<String, dynamic> ||
          storedPayload is! Map<String, dynamic> ||
          storedScope['apiEndpoint'] != scope.apiEndpoint ||
          storedScope['registrationGeneration'] !=
              scope.registrationGeneration) {
        return null;
      }
      final region = storedPayload['region'];
      final city = storedPayload['city'];
      final tsunamiForecastRegion = storedPayload['tsunamiForecastRegion'];
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
  Future<void> writeLastSent({
    required DeviceLocationSyncScope scope,
    required DeviceLocationPayload payload,
  }) => _preferences.setString(
    SharedPreferencesKey.backgroundLocationLastSentPayload.key,
    jsonEncode({
      'scope': {
        'apiEndpoint': scope.apiEndpoint,
        'registrationGeneration': scope.registrationGeneration,
      },
      'payload': payload.toJson(),
    }),
  );
}
