import 'package:collection/collection.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_notification_settings_repository.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceNotificationSettingsRepository>
deviceNotificationSettingsRepository(Ref ref) async =>
    DeviceNotificationSettingsRepository(
      await ref.watch(apiClientProvider.future),
    );

class DeviceNotificationSettingsRepository {
  DeviceNotificationSettingsRepository(this._api);

  final api.ApiClient _api;

  // ---------------------------------------------------------------------------
  // EEW
  // ---------------------------------------------------------------------------

  Future<Result<EewNotificationSettings, Exception>> getEewSettings(
    String deviceId,
  ) => Result.capture(() async {
    final response = await _api.device.getV2DeviceDeviceIdSettingsEew(
      deviceId: deviceId,
    );
    return _eewFromResponse(response.data, []);
  });

  Future<Result<List<NotificationRegion>, Exception>> getEewRegions(
    String deviceId,
  ) => Result.capture(() async {
    final response = await _api.device.getV2DeviceDeviceIdSettingsEewRegions(
      deviceId: deviceId,
    );
    return response.data.map((r) => r.toNotificationRegion).toList();
  });

  Future<Result<EewNotificationSettings, Exception>> patchEewSettings({
    required String deviceId,
    required bool enabled,
    required JmaIntensity? criticalThreshold,
    required bool startLiveActivity,
  }) => Result.capture(() async {
    final response = await _api.device.patchV2DeviceDeviceIdSettingsEew(
      deviceId: deviceId,
      body: api.EewSettingsRequest(
        enabled: enabled,
        notificationTiers: _toEewApiTiers(criticalThreshold),
        startLiveActivity: startLiveActivity,
      ),
    );
    final regionsResult = await _api.device
        .getV2DeviceDeviceIdSettingsEewRegions(deviceId: deviceId);
    return _eewFromResponse(
      response.data,
      regionsResult.data.map((r) => r.toNotificationRegion).toList(),
    );
  });

  Future<Result<List<NotificationRegion>, Exception>> putEewRegions({
    required String deviceId,
    required List<NotificationRegion> regions,
  }) => Result.capture(() async {
    final response = await _api.device.putV2DeviceDeviceIdSettingsEewRegions(
      deviceId: deviceId,
      body: regions.map((r) => r.toApiRequest).toList(),
    );
    return response.data.map((r) => r.toNotificationRegion).toList();
  });

  // ---------------------------------------------------------------------------
  // Earthquake
  // ---------------------------------------------------------------------------

  Future<Result<EarthquakeNotificationSettings, Exception>>
  getEarthquakeSettings(String deviceId) => Result.capture(() async {
    final response = await _api.device.getV2DeviceDeviceIdSettingsEarthquake(
      deviceId: deviceId,
    );
    return _earthquakeFromResponse(response.data, []);
  });

  Future<Result<List<NotificationRegion>, Exception>> getEarthquakeRegions(
    String deviceId,
  ) => Result.capture(() async {
    final response = await _api.device
        .getV2DeviceDeviceIdSettingsEarthquakeRegions(deviceId: deviceId);
    return response.data.map((r) => r.toNotificationRegion).toList();
  });

  Future<Result<EarthquakeNotificationSettings, Exception>>
  patchEarthquakeSettings({
    required String deviceId,
    required bool enabled,
    required JmaIntensity? criticalThreshold,
    required bool estimatedIntensityEnabled,
  }) => Result.capture(() async {
    final response =
        await _api.device.patchV2DeviceDeviceIdSettingsEarthquake(
          deviceId: deviceId,
          body: api.EarthquakeSettingsRequest(
            enabled: enabled,
            notificationTiers: _toEarthquakeApiTiers(criticalThreshold),
            estimatedIntensityEnabled: estimatedIntensityEnabled,
          ),
        );
    final regionsResult = await _api.device
        .getV2DeviceDeviceIdSettingsEarthquakeRegions(deviceId: deviceId);
    return _earthquakeFromResponse(
      response.data,
      regionsResult.data.map((r) => r.toNotificationRegion).toList(),
    );
  });

  Future<Result<List<NotificationRegion>, Exception>> putEarthquakeRegions({
    required String deviceId,
    required List<NotificationRegion> regions,
  }) => Result.capture(() async {
    final response = await _api.device
        .putV2DeviceDeviceIdSettingsEarthquakeRegions(
          deviceId: deviceId,
          body: regions.map((r) => r.toApiRequest).toList(),
        );
    return response.data.map((r) => r.toNotificationRegion).toList();
  });

  // ---------------------------------------------------------------------------
  // Shake Detection
  // ---------------------------------------------------------------------------

  Future<Result<List<ShakeDetectionEntry>, Exception>>
  getShakeDetectionSettings(String deviceId) => Result.capture(() async {
    final response = await _api.device.getV2DeviceDeviceIdSettingsShakeDetection(
      deviceId: deviceId,
    );
    return response.data.map(_shakeEntryFromResponse).toList();
  });

  Future<Result<List<ShakeDetectionEntry>, Exception>>
  putShakeDetectionSettings({
    required String deviceId,
    required List<ShakeDetectionEntry> entries,
  }) => Result.capture(() async {
    final response =
        await _api.device.putV2DeviceDeviceIdSettingsShakeDetection(
          deviceId: deviceId,
          body: entries
              .map(
                (e) => api.ShakeDetectionSettingRequest(
                  subRegionId: e.subRegionId,
                  minLevel: e.minLevel,
                  isCurrentLocation: e.isCurrentLocation,
                ),
              )
              .toList(),
        );
    return response.data.map(_shakeEntryFromResponse).toList();
  });

  Future<Result<List<ShakeDetectionSubRegion>, Exception>>
  getShakeDetectionSubRegions(String deviceId) => Result.capture(() async {
    final response = await _api.device
        .getV2DeviceDeviceIdSettingsShakeDetectionSubRegions(
          deviceId: deviceId,
        );
    return response.data
        .map(
          (r) =>
              ShakeDetectionSubRegion(id: r.id, code: r.code, name: r.name),
        )
        .toList();
  });

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  EewNotificationSettings _eewFromResponse(
    api.EewSettingsResponse resp,
    List<NotificationRegion> regions,
  ) => EewNotificationSettings(
    enabled: resp.enabled,
    criticalThreshold: _extractCriticalThresholdFromTiers3(
      resp.notificationTiers,
    ),
    startLiveActivity: resp.startLiveActivity,
    regions: regions,
  );

  EarthquakeNotificationSettings _earthquakeFromResponse(
    api.EarthquakeSettingsResponse resp,
    List<NotificationRegion> regions,
  ) => EarthquakeNotificationSettings(
    enabled: resp.enabled,
    criticalThreshold: _extractCriticalThresholdFromTiers(
      resp.notificationTiers,
    ),
    estimatedIntensityEnabled: resp.estimatedIntensityEnabled,
    regions: regions,
  );

  ShakeDetectionEntry _shakeEntryFromResponse(
    api.ShakeDetectionSettingResponse r,
  ) => ShakeDetectionEntry(
    id: r.id,
    subRegionId: r.subRegionId,
    subRegionName: null,
    minLevel: r.minLevel,
    isCurrentLocation: r.isCurrentLocation,
  );

  JmaIntensity? _extractCriticalThresholdFromTiers(
    List<api.NotificationTiers> tiers,
  ) {
    final tier = tiers.firstWhereOrNull(
      (t) => t.interruptionLevel == api.InterruptionLevel.critical,
    );
    return tier?.minJmaIntensity.toJmaIntensity;
  }

  JmaIntensity? _extractCriticalThresholdFromTiers3(
    List<api.NotificationTiers3> tiers,
  ) {
    final tier = tiers.firstWhereOrNull(
      (t) => t.interruptionLevel == api.InterruptionLevel.critical,
    );
    return tier?.minJmaIntensity.toJmaIntensity;
  }

  List<api.NotificationTiers4> _toEewApiTiers(JmaIntensity? threshold) {
    if (threshold == null) {
      return [];
    }
    final apiIntensity = threshold.toApiMinJmaIntensity;
    if (apiIntensity == null) {
      return [];
    }
    return [
      api.NotificationTiers4(
        minJmaIntensity: apiIntensity,
        sound: 'default',
        interruptionLevel: api.InterruptionLevel.critical,
      ),
    ];
  }

  List<api.NotificationTiers2>? _toEarthquakeApiTiers(JmaIntensity? threshold) {
    if (threshold == null) {
      return null;
    }
    final apiIntensity = threshold.toApiMinJmaIntensity;
    if (apiIntensity == null) {
      return null;
    }
    return [
      api.NotificationTiers2(
        minJmaIntensity: apiIntensity,
        sound: 'default',
        interruptionLevel: api.InterruptionLevel.critical,
      ),
    ];
  }
}
