import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_kind.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_min_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot_draft.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_slot_repository.g.dart';

const JmaIntensity defaultNotificationSlotMinIntensity = JmaIntensity.three;

@Riverpod(keepAlive: true)
Future<NotificationSlotRepository> notificationSlotRepository(Ref ref) async =>
    NotificationSlotRepository(await ref.watch(apiClientProvider.future));

/// 通知スロットの最小震度を決定する。
///
/// [enabled] が true かつ [minIntensity] が未指定の場合のみ、通知が
/// 無条件発火しないよう [defaultNotificationSlotMinIntensity] を補う。
/// [enabled] が false/未指定のときは [minIntensity] をそのまま返す
/// (無効スロットの震度指定は意味を持たないため補完しない)。
///
/// 現在地・地域スロットは UI を経由しない経路でも下限を下回らないよう
/// [NotificationMinIntensityPolicy.clamp] で引き上げる。
class NotificationSlotMinIntensityResolver {
  const new();

  JmaIntensity? resolve({
    required NotificationSlotType slotType,
    required NotificationKind kind,
    required bool? enabled,
    required JmaIntensity? minIntensity,
  }) {
    if (enabled != true) {
      return minIntensity;
    }
    return notificationMinIntensityPolicy.clamp(
      slotType: slotType,
      kind: kind,
      minIntensity: minIntensity ?? defaultNotificationSlotMinIntensity,
    );
  }
}

class NotificationSlotRepository {
  new(this._api);

  final api.ApiClient _api;

  static const _minIntensityResolver = NotificationSlotMinIntensityResolver();

  // ─── Slots ───

  Future<List<NotificationSlot>> getSlots() async {
    final response = await _api.device.getV2DeviceMeSettingsSlots();
    return response.data.map((s) => s.toNotificationSlot()).toList();
  }

  /// 現在地スロットを upsert する。
  Future<NotificationSlot> putCurrentLocation({
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final resolvedEewEnabled = eewEnabled ?? false;
    final resolvedEarthquakeEnabled = earthquakeEnabled ?? false;
    final response = await _api.device
        .putV2DeviceMeSettingsSlotsCurrentLocation(
          body: api.UpsertSingletonSlotRequest(
            eewEnabled: resolvedEewEnabled,
            eewMinIntensity: resolvedEewEnabled
                ? notificationMinIntensityPolicy
                      .clamp(
                        slotType: NotificationSlotType.currentLocation,
                        kind: NotificationKind.eew,
                        minIntensity:
                            eewMinIntensity ?? currentLocationEewMinIntensity,
                      )
                      ?.toApiJmaIntensity
                : null,
            eewOverrides: eewOverrides
                ?.map((o) => o.toApiSlotOverride())
                .toList(),
            earthquakeEnabled: resolvedEarthquakeEnabled,
            earthquakeMinIntensity: resolvedEarthquakeEnabled
                ? notificationMinIntensityPolicy
                      .clamp(
                        slotType: NotificationSlotType.currentLocation,
                        kind: NotificationKind.earthquake,
                        minIntensity:
                            earthquakeMinIntensity ??
                            currentLocationEarthquakeMinIntensity,
                      )
                      ?.toApiJmaIntensity
                : null,
            earthquakeOverrides: earthquakeOverrides
                ?.map((o) => o.toApiSlotOverride())
                .toList(),
          ),
        );
    return response.data.toNotificationSlot();
  }

  /// 通知スロットを全件置換する
  ///
  /// 既存スロットはサーバ側で削除されるため、渡した構成がそのまま反映される。
  /// カスタム設定のスナップショット復元など下限導入前の値が混じる経路があるため、
  /// 最小震度はスロット種別ごとの下限まで引き上げてから送信する。
  Future<List<NotificationSlot>> replaceSlots(
    List<NotificationSlotDraft> slots,
  ) async {
    final response = await _api.device.putV2DeviceMeSettingsSlots(
      body: slots
          .map((slot) => _clampDraftMinIntensity(slot).toApiReplaceSlotEntry())
          .toList(),
    );
    return response.data.map((s) => s.toNotificationSlot()).toList();
  }

  NotificationSlotDraft _clampDraftMinIntensity(NotificationSlotDraft slot) =>
      slot.copyWith(
        eewMinIntensity: notificationMinIntensityPolicy.clamp(
          slotType: slot.slotType,
          kind: NotificationKind.eew,
          minIntensity: slot.eewMinIntensity,
        ),
        earthquakeMinIntensity: notificationMinIntensityPolicy.clamp(
          slotType: slot.slotType,
          kind: NotificationKind.earthquake,
          minIntensity: slot.earthquakeMinIntensity,
        ),
      );

  Future<void> deleteCurrentLocation() async {
    await _api.device.deleteV2DeviceMeSettingsSlotsCurrentLocation();
  }

  Future<void> putDeviceLocation({
    required int regionId,
    String? cityCode,
  }) async {
    await _api.device.putV2DeviceMeLocation(
      body: api.DeviceLocationRequest(
        regionId: regionId.toString(),
        cityCode: cityCode,
      ),
    );
  }

  Future<NotificationSlot> putNationwide({
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final resolvedEewEnabled = eewEnabled ?? false;
    final resolvedEarthquakeEnabled = earthquakeEnabled ?? false;
    final response = await _api.device.putV2DeviceMeSettingsSlotsNationwide(
      body: api.UpsertSingletonSlotRequest(
        eewEnabled: resolvedEewEnabled,
        eewMinIntensity: _minIntensityResolver
            .resolve(
              slotType: NotificationSlotType.nationwide,
              kind: NotificationKind.eew,
              enabled: resolvedEewEnabled,
              minIntensity: eewMinIntensity,
            )
            ?.toApiJmaIntensity,
        eewOverrides: eewOverrides?.map((o) => o.toApiSlotOverride()).toList(),
        earthquakeEnabled: resolvedEarthquakeEnabled,
        earthquakeMinIntensity: _minIntensityResolver
            .resolve(
              slotType: NotificationSlotType.nationwide,
              kind: NotificationKind.earthquake,
              enabled: resolvedEarthquakeEnabled,
              minIntensity: earthquakeMinIntensity,
            )
            ?.toApiJmaIntensity,
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
        eewMinIntensity: _minIntensityResolver
            .resolve(
              slotType: NotificationSlotType.region,
              kind: NotificationKind.eew,
              enabled: eewEnabled,
              minIntensity: eewMinIntensity,
            )
            ?.toApiJmaIntensity,
        eewOverrides: eewOverrides?.map((o) => o.toApiSlotOverride()).toList(),
        earthquakeEnabled: earthquakeEnabled,
        earthquakeMinIntensity: _minIntensityResolver
            .resolve(
              slotType: NotificationSlotType.region,
              kind: NotificationKind.earthquake,
              enabled: earthquakeEnabled,
              minIntensity: earthquakeMinIntensity,
            )
            ?.toApiJmaIntensity,
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
            eewMinIntensity: _minIntensityResolver
                .resolve(
                  slotType: NotificationSlotType.region,
                  kind: NotificationKind.eew,
                  enabled: eewEnabled,
                  minIntensity: eewMinIntensity,
                )
                ?.toApiJmaIntensity,
            eewOverrides: eewOverrides
                ?.map((o) => o.toApiSlotOverride())
                .toList(),
            earthquakeEnabled: earthquakeEnabled,
            earthquakeMinIntensity: _minIntensityResolver
                .resolve(
                  slotType: NotificationSlotType.region,
                  kind: NotificationKind.earthquake,
                  enabled: earthquakeEnabled,
                  minIntensity: earthquakeMinIntensity,
                )
                ?.toApiJmaIntensity,
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
    InterruptionLevel? currentLocationInterruptionLevel,
    InterruptionLevel? nationwideInterruptionLevel,
  }) async {
    final response = await _api.device.patchV2DeviceMeSettingsEewWarning(
      body: api.EewWarningConfigRequest(
        target: target?.toApiTarget,
        currentLocationInterruptionLevel: currentLocationInterruptionLevel
            ?.toApiCurrentLocationInterruptionLevel,
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
