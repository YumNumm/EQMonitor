import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_slot_repository.g.dart';

const JmaIntensity defaultNotificationSlotMinIntensity = JmaIntensity.three;

@Riverpod(keepAlive: true)
Future<NotificationSlotRepository> notificationSlotRepository(Ref ref) async =>
    NotificationSlotRepository(await ref.watch(apiClientProvider.future));

class NotificationSlotRepository {
  NotificationSlotRepository(this._api);

  final api.ApiClient _api;

  // ─── Slots ───

  Future<List<NotificationSlot>> getSlots() async {
    final response = await _api.device.getV2DeviceMeSettingsSlots();
    return response.data.map((s) => s.toNotificationSlot()).toList();
  }

  Future<NotificationSlot> putCurrentLocation({
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final response = await _api.device
        .putV2DeviceMeSettingsSlotsCurrentLocation(
          body: api.UpsertSingletonSlotRequest(
            eewEnabled: eewEnabled,
            eewMinIntensity: resolveNotificationSlotMinIntensity(
              enabled: eewEnabled,
              minIntensity: eewMinIntensity,
            )?.toApiJmaIntensity,
            eewOverrides: eewOverrides
                ?.map((o) => o.toApiSlotOverride())
                .toList(),
            earthquakeEnabled: earthquakeEnabled,
            earthquakeMinIntensity: resolveNotificationSlotMinIntensity(
              enabled: earthquakeEnabled,
              minIntensity: earthquakeMinIntensity,
            )?.toApiJmaIntensity,
            earthquakeOverrides: earthquakeOverrides
                ?.map((o) => o.toApiSlotOverride())
                .toList(),
          ),
        );
    return response.data.toNotificationSlot();
  }

  Future<void> deleteCurrentLocation() async {
    await _api.device.deleteV2DeviceMeSettingsSlotsCurrentLocation();
  }

  Future<NotificationSlot> putNationwide({
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final response = await _api.device.putV2DeviceMeSettingsSlotsNationwide(
      body: api.UpsertSingletonSlotRequest(
        eewEnabled: eewEnabled,
        eewMinIntensity: resolveNotificationSlotMinIntensity(
          enabled: eewEnabled,
          minIntensity: eewMinIntensity,
        )?.toApiJmaIntensity,
        eewOverrides: eewOverrides?.map((o) => o.toApiSlotOverride()).toList(),
        earthquakeEnabled: earthquakeEnabled,
        earthquakeMinIntensity: resolveNotificationSlotMinIntensity(
          enabled: earthquakeEnabled,
          minIntensity: earthquakeMinIntensity,
        )?.toApiJmaIntensity,
        earthquakeOverrides: earthquakeOverrides
            ?.map((o) => o.toApiSlotOverride())
            .toList(),
      ),
    );
    return response.data.toNotificationSlot();
  }

  Future<void> deleteNationwide() async {
    await _api.device.deleteV2DeviceMeSettingsSlotsNationwide();
  }

  Future<NotificationSlot> addRegion({
    required int regionId,
    String? regionName,
    String? cityCode,
    String? cityName,
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final response = await _api.device.postV2DeviceMeSettingsSlotsRegions(
      body: api.CreateRegionSlotRequest(
        regionId: regionId,
        regionName: regionName,
        cityCode: cityCode,
        cityName: cityName,
        eewEnabled: eewEnabled,
        eewMinIntensity: resolveNotificationSlotMinIntensity(
          enabled: eewEnabled,
          minIntensity: eewMinIntensity,
        )?.toApiJmaIntensity,
        eewOverrides: eewOverrides?.map((o) => o.toApiSlotOverride()).toList(),
        earthquakeEnabled: earthquakeEnabled,
        earthquakeMinIntensity: resolveNotificationSlotMinIntensity(
          enabled: earthquakeEnabled,
          minIntensity: earthquakeMinIntensity,
        )?.toApiJmaIntensity,
        earthquakeOverrides: earthquakeOverrides
            ?.map((o) => o.toApiSlotOverride())
            .toList(),
      ),
    );
    return response.data.toNotificationSlot();
  }

  Future<NotificationSlot> updateRegion({
    required String slotId,
    String? regionName,
    String? cityCode,
    String? cityName,
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final response = await _api.device
        .patchV2DeviceMeSettingsSlotsRegionsSlotId(
          slotId: slotId,
          body: api.UpdateRegionSlotRequest(
            regionName: regionName,
            cityCode: cityCode,
            cityName: cityName,
            eewEnabled: eewEnabled,
            eewMinIntensity: resolveNotificationSlotMinIntensity(
              enabled: eewEnabled,
              minIntensity: eewMinIntensity,
            )?.toApiJmaIntensity,
            eewOverrides: eewOverrides
                ?.map((o) => o.toApiSlotOverride())
                .toList(),
            earthquakeEnabled: earthquakeEnabled,
            earthquakeMinIntensity: resolveNotificationSlotMinIntensity(
              enabled: earthquakeEnabled,
              minIntensity: earthquakeMinIntensity,
            )?.toApiJmaIntensity,
            earthquakeOverrides: earthquakeOverrides
                ?.map((o) => o.toApiSlotOverride())
                .toList(),
          ),
        );
    return response.data.toNotificationSlot();
  }

  Future<void> removeRegion({required String slotId}) async {
    await _api.device.deleteV2DeviceMeSettingsSlotsRegionsSlotId(
      slotId: slotId,
    );
  }

  // ─── EEW Warning ───

  Future<EewWarningSettings> getEewWarningConfig() async {
    final response = await _api.device.getV2DeviceMeSettingsEewWarning();
    return response.data.toEewWarningSettings();
  }

  Future<EewWarningSettings> patchEewWarningConfig({
    EewWarningTarget? target,
    InterruptionLevel? nationwideInterruptionLevel,
  }) async {
    final response = await _api.device.patchV2DeviceMeSettingsEewWarning(
      body: api.EewWarningConfigRequest(
        target: target?.toApiTarget,
        nationwideInterruptionLevel:
            nationwideInterruptionLevel?.toApiNationwideInterruptionLevel,
      ),
    );
    return response.data.toEewWarningSettings();
  }

  // ─── EEW Global Settings ───

  Future<EewGlobalSettings> getEewGlobalSettings() async {
    final response = await _api.device.getV2DeviceMeSettingsEew();
    return response.data.toEewGlobalSettings();
  }

  Future<EewGlobalSettings> patchEewGlobalSettings({
    bool? enabled,
    String? defaultSound,
    InterruptionLevel? defaultInterruptionLevel,
    bool? startLiveActivity,
    bool? collapseNotification,
    bool? warningEnabled,
  }) async {
    final response = await _api.device.patchV2DeviceMeSettingsEew(
      body: api.EewSettingsRequest(
        enabled: enabled,
        defaultSound: defaultSound,
        defaultInterruptionLevel:
            defaultInterruptionLevel?.toApiDefaultInterruptionLevel,
        startLiveActivity: startLiveActivity,
        collapseNotification: collapseNotification,
        warningEnabled: warningEnabled,
      ),
    );
    return response.data.toEewGlobalSettings();
  }

  // ─── Earthquake Global Settings ───

  Future<EarthquakeGlobalSettings> getEarthquakeGlobalSettings() async {
    final response = await _api.device.getV2DeviceMeSettingsEarthquake();
    return response.data.toEarthquakeGlobalSettings();
  }

  Future<EarthquakeGlobalSettings> patchEarthquakeGlobalSettings({
    bool? enabled,
    String? defaultSound,
    InterruptionLevel? defaultInterruptionLevel,
    bool? estimatedIntensityEnabled,
    bool? collapseNotification,
  }) async {
    final response = await _api.device.patchV2DeviceMeSettingsEarthquake(
      body: api.EarthquakeSettingsRequest(
        enabled: enabled,
        defaultSound: defaultSound,
        defaultInterruptionLevel:
            defaultInterruptionLevel?.toApiDefaultInterruptionLevel,
        estimatedIntensityEnabled: estimatedIntensityEnabled,
        collapseNotification: collapseNotification,
      ),
    );
    return response.data.toEarthquakeGlobalSettings();
  }
}

JmaIntensity? resolveNotificationSlotMinIntensity({
  required bool? enabled,
  required JmaIntensity? minIntensity,
}) {
  if (enabled != true) {
    return minIntensity;
  }
  return minIntensity ?? defaultNotificationSlotMinIntensity;
}
