import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_slot_repository.g.dart';

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
    final response =
        await _api.device.putV2DeviceMeSettingsSlotsCurrentLocation(
      body: api.UpsertSingletonSlotRequest(
        eewEnabled: eewEnabled,
        eewMinIntensity: eewMinIntensity?.toApiJmaIntensity,
        eewOverrides: eewOverrides?.map((o) => o.toApiSlotOverride()).toList(),
        earthquakeEnabled: earthquakeEnabled,
        earthquakeMinIntensity: earthquakeMinIntensity?.toApiJmaIntensity,
        earthquakeOverrides:
            earthquakeOverrides?.map((o) => o.toApiSlotOverride()).toList(),
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
        eewMinIntensity: eewMinIntensity?.toApiJmaIntensity,
        eewOverrides: eewOverrides?.map((o) => o.toApiSlotOverride()).toList(),
        earthquakeEnabled: earthquakeEnabled,
        earthquakeMinIntensity: earthquakeMinIntensity?.toApiJmaIntensity,
        earthquakeOverrides:
            earthquakeOverrides?.map((o) => o.toApiSlotOverride()).toList(),
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
        eewMinIntensity: eewMinIntensity?.toApiJmaIntensity,
        eewOverrides: eewOverrides?.map((o) => o.toApiSlotOverride()).toList(),
        earthquakeEnabled: earthquakeEnabled,
        earthquakeMinIntensity: earthquakeMinIntensity?.toApiJmaIntensity,
        earthquakeOverrides:
            earthquakeOverrides?.map((o) => o.toApiSlotOverride()).toList(),
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
    final response =
        await _api.device.patchV2DeviceMeSettingsSlotsRegionsSlotId(
      slotId: slotId,
      body: api.UpdateRegionSlotRequest(
        regionName: regionName,
        cityCode: cityCode,
        cityName: cityName,
        eewEnabled: eewEnabled,
        eewMinIntensity: eewMinIntensity?.toApiJmaIntensity,
        eewOverrides: eewOverrides?.map((o) => o.toApiSlotOverride()).toList(),
        earthquakeEnabled: earthquakeEnabled,
        earthquakeMinIntensity: earthquakeMinIntensity?.toApiJmaIntensity,
        earthquakeOverrides:
            earthquakeOverrides?.map((o) => o.toApiSlotOverride()).toList(),
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
}
