import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
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
    final response = await _api.device.getV2DeviceMeSettingsEew();
    return _eewFromResponse(response.data, []);
  });

  Future<Result<List<NotificationRegion>, Exception>> getEewRegions(
    String deviceId,
  ) => Result.capture(() async {
    final response = await _api.device.getV2DeviceMeSettingsEewRegions();
    return response.data.map((r) => r.toNotificationRegion).toList();
  });

  Future<Result<EewNotificationSettings, Exception>> patchEewSettings({
    required String deviceId,
    required bool enabled,
    required bool startLiveActivity,
    required bool onePointEnabled,
  }) => Result.capture(() async {
    final response = await _api.device.patchV2DeviceMeSettingsEew(
      body: api.EewSettingsRequest(
        enabled: enabled,
        startLiveActivity: startLiveActivity,
        onePointEnabled: onePointEnabled,
      ),
    );
    final regionsResult = await _api.device.getV2DeviceMeSettingsEewRegions();
    return _eewFromResponse(
      response.data,
      regionsResult.data.map((r) => r.toNotificationRegion).toList(),
    );
  });

  Future<Result<List<NotificationRegion>, Exception>> putEewRegions({
    required String deviceId,
    required List<NotificationRegion> regions,
  }) => Result.capture(() async {
    final response = await _api.device.putV2DeviceMeSettingsEewRegions(
      body: regions.map((r) => r.toApiRequest).toList(),
    );
    return response.data.map((r) => r.toNotificationRegion).toList();
  });

  // ---------------------------------------------------------------------------
  // Earthquake
  // ---------------------------------------------------------------------------

  Future<Result<EarthquakeNotificationSettings, Exception>>
  getEarthquakeSettings(String deviceId) => Result.capture(() async {
    final response = await _api.device.getV2DeviceMeSettingsEarthquake();
    return _earthquakeFromResponse(response.data, []);
  });

  Future<Result<List<NotificationRegion>, Exception>> getEarthquakeRegions(
    String deviceId,
  ) => Result.capture(() async {
    final response = await _api.device.getV2DeviceMeSettingsEarthquakeRegions();
    return response.data.map((r) => r.toNotificationRegion).toList();
  });

  Future<Result<EarthquakeNotificationSettings, Exception>>
  patchEarthquakeSettings({
    required String deviceId,
    required bool enabled,
    required bool estimatedIntensityEnabled,
  }) => Result.capture(() async {
    final response = await _api.device.patchV2DeviceMeSettingsEarthquake(
      body: api.EarthquakeSettingsRequest(
        enabled: enabled,
        estimatedIntensityEnabled: estimatedIntensityEnabled,
      ),
    );
    final regionsResult = await _api.device
        .getV2DeviceMeSettingsEarthquakeRegions();
    return _earthquakeFromResponse(
      response.data,
      regionsResult.data.map((r) => r.toNotificationRegion).toList(),
    );
  });

  Future<Result<List<NotificationRegion>, Exception>> putEarthquakeRegions({
    required String deviceId,
    required List<NotificationRegion> regions,
  }) => Result.capture(() async {
    final response = await _api.device.putV2DeviceMeSettingsEarthquakeRegions(
      body: regions.map((r) => r.toApiRequest).toList(),
    );
    return response.data.map((r) => r.toNotificationRegion).toList();
  });

  // ---------------------------------------------------------------------------
  // Shake Detection
  // ---------------------------------------------------------------------------

  Future<Result<List<ShakeDetectionEntry>, Exception>>
  getShakeDetectionSettings(String deviceId) => Result.capture(() async {
    final response = await _api.device.getV2DeviceMeSettingsShakeDetection();
    return response.data.map(_shakeEntryFromResponse).toList();
  });

  Future<Result<List<ShakeDetectionEntry>, Exception>>
  putShakeDetectionSettings({
    required String deviceId,
    required List<ShakeDetectionEntry> entries,
  }) => Result.capture(() async {
    final response = await _api.device.putV2DeviceMeSettingsShakeDetection(
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
        .getV2DeviceMeSettingsShakeDetectionSubRegions();
    return response.data
        .map(
          (r) => ShakeDetectionSubRegion(id: r.id, code: r.code, name: r.name),
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
    startLiveActivity: resp.startLiveActivity,
    onePointEnabled: resp.onePointEnabled,
    regions: regions,
  );

  EarthquakeNotificationSettings _earthquakeFromResponse(
    api.EarthquakeSettingsResponse resp,
    List<NotificationRegion> regions,
  ) => EarthquakeNotificationSettings(
    enabled: resp.enabled,
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
}
