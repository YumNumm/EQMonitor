import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_sync_scope.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_sync_state_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:eqmonitor/feature/location/data/model/device_location_sync_scope.dart';

part 'device_location_sync_state_repository.g.dart';

enum DeviceLocationSyncAvailability { enabled, disabled, uninitialized }

@Riverpod(keepAlive: true)
DeviceLocationSyncStateRepository deviceLocationSyncStateRepository(Ref ref) =>
    SharedPreferencesDeviceLocationSyncStateRepository(
      SharedPreferencesAsync(),
    );

abstract interface class DeviceLocationSyncStateRepository {
  Future<DeviceLocationSyncAvailability> readAvailability();

  Future<void> writeAvailability(DeviceLocationSyncAvailability availability);

  /// 揺れ検知の「現在地」条件が有効だったか。一度も保存していなければ null。
  ///
  /// 揺れ検知の設定はサーバーから毎起動では取得しないため、起動時の
  /// 位置情報監視の判定に最後の値を使う。
  Future<bool?> readShakeCurrentLocationEnabled();

  Future<void> writeShakeCurrentLocationEnabled({required bool isEnabled});

  Future<DeviceLocationPayload?> readLastSent({
    required DeviceLocationSyncScope scope,
  });

  Future<void> writeLastSent({
    required DeviceLocationSyncScope scope,
    required DeviceLocationPayload payload,
  });

  Future<void> clearLastSent();
}

class InMemoryDeviceLocationSyncStateRepository({
  var DeviceLocationSyncAvailability availability =
      DeviceLocationSyncAvailability.enabled,
  var bool? isShakeCurrentLocationEnabled,
  var DeviceLocationSyncScope? lastSentScope,
  DeviceLocationPayload? lastSent,
}) implements DeviceLocationSyncStateRepository {
  DeviceLocationPayload? _lastSent = lastSent;

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
  Future<bool?> readShakeCurrentLocationEnabled() async =>
      isShakeCurrentLocationEnabled;

  @override
  Future<void> writeShakeCurrentLocationEnabled({
    required bool isEnabled,
  }) async {
    isShakeCurrentLocationEnabled = isEnabled;
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

  @override
  Future<void> clearLastSent() async {
    lastSentScope = null;
    _lastSent = null;
  }
}

class SharedPreferencesDeviceLocationSyncStateRepository(
  final SharedPreferencesAsync _preferences,
) implements DeviceLocationSyncStateRepository {
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
  Future<bool?> readShakeCurrentLocationEnabled() => _preferences.getBool(
    SharedPreferencesKey.backgroundLocationShakeCurrentLocationEnabled.key,
  );

  @override
  Future<void> writeShakeCurrentLocationEnabled({required bool isEnabled}) =>
      _preferences.setBool(
        SharedPreferencesKey.backgroundLocationShakeCurrentLocationEnabled.key,
        isEnabled,
      );

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
      final record = DeviceLocationSyncStateRecord.fromJson(decoded);
      if (record.scope != scope) {
        return null;
      }
      return record.payload;
    } on Object {
      return null;
    }
  }

  @override
  Future<void> writeLastSent({
    required DeviceLocationSyncScope scope,
    required DeviceLocationPayload payload,
  }) => _preferences.setString(
    SharedPreferencesKey.backgroundLocationLastSentPayload.key,
    jsonEncode(
      DeviceLocationSyncStateRecord(
        scope: scope,
        payload: payload,
      ).toJson(),
    ),
  );

  @override
  Future<void> clearLastSent() => _preferences.remove(
    SharedPreferencesKey.backgroundLocationLastSentPayload.key,
  );
}
