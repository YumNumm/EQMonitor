// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/challenge_response.dart';
import '../models/create_device_notification_webhook_request.dart';
import '../models/create_region_slot_request.dart';
import '../models/device_location_request.dart';
import '../models/device_location_response.dart';
import '../models/device_me_response.dart';
import '../models/device_notification_webhook_response.dart';
import '../models/device_register_body.dart';
import '../models/device_register_response.dart';
import '../models/earthquake_settings_request.dart';
import '../models/earthquake_settings_response.dart';
import '../models/eew_settings_request.dart';
import '../models/eew_settings_response.dart';
import '../models/eew_warning_config_request.dart';
import '../models/eew_warning_config_response.dart';
import '../models/kind.dart';
import '../models/migrate_request.dart';
import '../models/migration_response.dart';
import '../models/notification_settings_request.dart';
import '../models/notification_settings_response.dart';
import '../models/replace_slot_entry.dart';
import '../models/shake_detection_setting_request.dart';
import '../models/shake_detection_setting_response.dart';
import '../models/shake_detection_sub_region_response.dart';
import '../models/slot_response.dart';
import '../models/tsunami_region_setting_patch_request.dart';
import '../models/tsunami_region_setting_request.dart';
import '../models/tsunami_region_setting_response.dart';
import '../models/tsunami_settings_request.dart';
import '../models/tsunami_settings_response.dart';
import '../models/update_region_slot_request.dart';
import '../models/upsert_singleton_slot_request.dart';
import '../models/v2_device_me_apns_kind_request_body.dart';
import '../models/v2_device_me_fcm_request_body.dart';

part 'device_api_client.g.dart';

@RestApi()
abstract class DeviceApiClient {
  factory DeviceApiClient(Dio dio, {String? baseUrl}) = _DeviceApiClient;

  /// チャレンジコードを発行する（IP レート制限あり）
  @POST(DeviceApiClientUrls.postV2DeviceChallenge)
  Future<HttpResponse<ChallengeResponse>> postV2DeviceChallenge();

  /// デバイスを登録してJWTを返す。X-Firebase-AppCheck または X-Challenge-Code/X-Challenge-Response ヘッダーが存在する場合はそれぞれ検証を試みるが、検証失敗時も registrationType=null として登録を続行する。
  @POST(DeviceApiClientUrls.postV2Device)
  Future<HttpResponse<DeviceRegisterResponse>> postV2Device({
    @Body() required DeviceRegisterBody body,
  });

  /// デバイス情報を取得。role は ADMIN_DEVICE_IDS に列挙されたデバイスのみ ADMIN、それ以外は USER。
  @GET(DeviceApiClientUrls.getV2DeviceMe)
  Future<HttpResponse<DeviceMeResponse>> getV2DeviceMe();

  /// デバイスを削除（JWTを無効化後に削除）
  @DELETE(DeviceApiClientUrls.deleteV2DeviceMe)
  Future<HttpResponse<void>> deleteV2DeviceMe();

  /// FCMトークンを更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceMeFcm)
  Future<HttpResponse<void>> patchV2DeviceMeFcm({
    @Body() required V2DeviceMeFcmRequestBody body,
  });

  /// APNsトークンを更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceMeApnsKind)
  Future<HttpResponse<void>> patchV2DeviceMeApnsKind({
    @Path('kind') required Kind kind,
    @Body() required V2DeviceMeApnsKindRequestBody body,
  });

  /// 全般通知設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsNotification)
  Future<HttpResponse<NotificationSettingsResponse>> getV2DeviceMeSettingsNotification();

  /// 全般通知設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceMeSettingsNotification)
  Future<HttpResponse<NotificationSettingsResponse>> patchV2DeviceMeSettingsNotification({
    @Body() required NotificationSettingsRequest body,
  });

  /// 地震通知設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsEarthquake)
  Future<HttpResponse<EarthquakeSettingsResponse>> getV2DeviceMeSettingsEarthquake();

  /// 地震通知設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceMeSettingsEarthquake)
  Future<HttpResponse<EarthquakeSettingsResponse>> patchV2DeviceMeSettingsEarthquake({
    @Body() required EarthquakeSettingsRequest body,
  });

  /// EEW通知設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsEew)
  Future<HttpResponse<EewSettingsResponse>> getV2DeviceMeSettingsEew();

  /// EEW通知設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceMeSettingsEew)
  Future<HttpResponse<EewSettingsResponse>> patchV2DeviceMeSettingsEew({
    @Body() required EewSettingsRequest body,
  });

  /// 揺れ検知通知設定一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsShakeDetection)
  Future<HttpResponse<List<ShakeDetectionSettingResponse>>> getV2DeviceMeSettingsShakeDetection();

  /// 揺れ検知通知設定を一括更新（全件上書き）
  @PUT(DeviceApiClientUrls.putV2DeviceMeSettingsShakeDetection)
  Future<HttpResponse<List<ShakeDetectionSettingResponse>>> putV2DeviceMeSettingsShakeDetection({
    @Body() required List<ShakeDetectionSettingRequest> body,
  });

  /// 揺れ検知サブ地域マスター一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsShakeDetectionSubRegions)
  Future<HttpResponse<List<ShakeDetectionSubRegionResponse>>> getV2DeviceMeSettingsShakeDetectionSubRegions();

  /// 津波通知設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsTsunami)
  Future<HttpResponse<TsunamiSettingsResponse>> getV2DeviceMeSettingsTsunami();

  /// 津波通知設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceMeSettingsTsunami)
  Future<HttpResponse<TsunamiSettingsResponse>> patchV2DeviceMeSettingsTsunami({
    @Body() required TsunamiSettingsRequest body,
  });

  /// 津波通知リージョン設定一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsTsunamiRegions)
  Future<HttpResponse<List<TsunamiRegionSettingResponse>>> getV2DeviceMeSettingsTsunamiRegions();

  /// 津波通知リージョン設定を新規作成（同一予報区コードが既存の場合は上書き）
  @POST(DeviceApiClientUrls.postV2DeviceMeSettingsTsunamiRegions)
  Future<HttpResponse<TsunamiRegionSettingResponse>> postV2DeviceMeSettingsTsunamiRegions({
    @Body() required TsunamiRegionSettingRequest body,
  });

  /// 特定の津波リージョン設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsTsunamiRegionsRegionId)
  Future<HttpResponse<TsunamiRegionSettingResponse>> getV2DeviceMeSettingsTsunamiRegionsRegionId({
    @Path('regionId') required String regionId,
  });

  /// 特定の津波リージョン設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceMeSettingsTsunamiRegionsRegionId)
  Future<HttpResponse<TsunamiRegionSettingResponse>> patchV2DeviceMeSettingsTsunamiRegionsRegionId({
    @Path('regionId') required String regionId,
    @Body() required TsunamiRegionSettingPatchRequest body,
  });

  /// 特定の津波リージョン設定を削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceMeSettingsTsunamiRegionsRegionId)
  Future<HttpResponse<void>> deleteV2DeviceMeSettingsTsunamiRegionsRegionId({
    @Path('regionId') required String regionId,
  });

  /// 通知スロット一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsSlots)
  Future<HttpResponse<List<SlotResponse>>> getV2DeviceMeSettingsSlots();

  /// 通知スロットを一括置換（既存スロットを全削除してから投入。空配列で全削除）
  @PUT(DeviceApiClientUrls.putV2DeviceMeSettingsSlots)
  Future<HttpResponse<List<SlotResponse>>> putV2DeviceMeSettingsSlots({
    @Body() required List<ReplaceSlotEntry> body,
  });

  /// 現在地スロットを取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsSlotsCurrentLocation)
  Future<HttpResponse<SlotResponse>> getV2DeviceMeSettingsSlotsCurrentLocation();

  /// 現在地スロットを upsert
  @PUT(DeviceApiClientUrls.putV2DeviceMeSettingsSlotsCurrentLocation)
  Future<HttpResponse<SlotResponse>> putV2DeviceMeSettingsSlotsCurrentLocation({
    @Body() required UpsertSingletonSlotRequest body,
  });

  /// 現在地スロットを削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceMeSettingsSlotsCurrentLocation)
  Future<HttpResponse<void>> deleteV2DeviceMeSettingsSlotsCurrentLocation();

  /// 全国スロットを取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsSlotsNationwide)
  Future<HttpResponse<SlotResponse>> getV2DeviceMeSettingsSlotsNationwide();

  /// 全国スロットを upsert
  @PUT(DeviceApiClientUrls.putV2DeviceMeSettingsSlotsNationwide)
  Future<HttpResponse<SlotResponse>> putV2DeviceMeSettingsSlotsNationwide({
    @Body() required UpsertSingletonSlotRequest body,
  });

  /// 全国スロットを削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceMeSettingsSlotsNationwide)
  Future<HttpResponse<void>> deleteV2DeviceMeSettingsSlotsNationwide();

  /// 地域スロット一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsSlotsRegions)
  Future<HttpResponse<List<SlotResponse>>> getV2DeviceMeSettingsSlotsRegions();

  /// 地域スロットを作成（プラン制約チェックあり）
  @POST(DeviceApiClientUrls.postV2DeviceMeSettingsSlotsRegions)
  Future<HttpResponse<SlotResponse>> postV2DeviceMeSettingsSlotsRegions({
    @Body() required CreateRegionSlotRequest body,
  });

  /// 地域スロットを更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceMeSettingsSlotsRegionsSlotId)
  Future<HttpResponse<SlotResponse>> patchV2DeviceMeSettingsSlotsRegionsSlotId({
    @Path('slotId') required String slotId,
    @Body() required UpdateRegionSlotRequest body,
  });

  /// 地域スロットを削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceMeSettingsSlotsRegionsSlotId)
  Future<HttpResponse<void>> deleteV2DeviceMeSettingsSlotsRegionsSlotId({
    @Path('slotId') required String slotId,
  });

  /// EEW 警報設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsEewWarning)
  Future<HttpResponse<EewWarningConfigResponse>> getV2DeviceMeSettingsEewWarning();

  /// EEW 警報設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceMeSettingsEewWarning)
  Future<HttpResponse<EewWarningConfigResponse>> patchV2DeviceMeSettingsEewWarning({
    @Body() required EewWarningConfigRequest body,
  });

  /// デバイスの現在地を更新
  @PUT(DeviceApiClientUrls.putV2DeviceMeLocation)
  Future<HttpResponse<DeviceLocationResponse>> putV2DeviceMeLocation({
    @Body() required DeviceLocationRequest body,
  });

  /// 通知 Webhook を作成
  @POST(DeviceApiClientUrls.postV2DeviceMeNotificationWebhooks)
  Future<HttpResponse<DeviceNotificationWebhookResponse>> postV2DeviceMeNotificationWebhooks({
    @Body() required CreateDeviceNotificationWebhookRequest body,
  });

  /// 通知 Webhook の一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeNotificationWebhooks)
  Future<HttpResponse<List<DeviceNotificationWebhookResponse>>> getV2DeviceMeNotificationWebhooks();

  /// 通知 Webhook を削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceMeNotificationWebhooksId)
  Future<HttpResponse<void>> deleteV2DeviceMeNotificationWebhooksId({
    @Path('id') required String id,
  });

  /// 旧 Supabase のデバイス設定を新 DB に移行
  @POST(DeviceApiClientUrls.postV2DeviceMeMigrate)
  Future<HttpResponse<MigrationResponse>> postV2DeviceMeMigrate({
    @Body() required MigrateRequest body,
  });
}


abstract class DeviceApiClientUrls {
	/// /v2/device/challenge
	static const postV2DeviceChallenge = "/v2/device/challenge";
	/// /v2/device
	static const postV2Device = "/v2/device";
	/// /v2/device/me
	static const getV2DeviceMe = "/v2/device/me";
	/// /v2/device/me
	static const deleteV2DeviceMe = "/v2/device/me";
	/// /v2/device/me/fcm
	static const patchV2DeviceMeFcm = "/v2/device/me/fcm";
	/// /v2/device/me/apns/{kind}
	static const patchV2DeviceMeApnsKind = "/v2/device/me/apns/{kind}";
	/// /v2/device/me/settings/notification
	static const getV2DeviceMeSettingsNotification = "/v2/device/me/settings/notification";
	/// /v2/device/me/settings/notification
	static const patchV2DeviceMeSettingsNotification = "/v2/device/me/settings/notification";
	/// /v2/device/me/settings/earthquake
	static const getV2DeviceMeSettingsEarthquake = "/v2/device/me/settings/earthquake";
	/// /v2/device/me/settings/earthquake
	static const patchV2DeviceMeSettingsEarthquake = "/v2/device/me/settings/earthquake";
	/// /v2/device/me/settings/eew
	static const getV2DeviceMeSettingsEew = "/v2/device/me/settings/eew";
	/// /v2/device/me/settings/eew
	static const patchV2DeviceMeSettingsEew = "/v2/device/me/settings/eew";
	/// /v2/device/me/settings/shake-detection
	static const getV2DeviceMeSettingsShakeDetection = "/v2/device/me/settings/shake-detection";
	/// /v2/device/me/settings/shake-detection
	static const putV2DeviceMeSettingsShakeDetection = "/v2/device/me/settings/shake-detection";
	/// /v2/device/me/settings/shake-detection/sub-regions
	static const getV2DeviceMeSettingsShakeDetectionSubRegions = "/v2/device/me/settings/shake-detection/sub-regions";
	/// /v2/device/me/settings/tsunami
	static const getV2DeviceMeSettingsTsunami = "/v2/device/me/settings/tsunami";
	/// /v2/device/me/settings/tsunami
	static const patchV2DeviceMeSettingsTsunami = "/v2/device/me/settings/tsunami";
	/// /v2/device/me/settings/tsunami/regions
	static const getV2DeviceMeSettingsTsunamiRegions = "/v2/device/me/settings/tsunami/regions";
	/// /v2/device/me/settings/tsunami/regions
	static const postV2DeviceMeSettingsTsunamiRegions = "/v2/device/me/settings/tsunami/regions";
	/// /v2/device/me/settings/tsunami/regions/{regionId}
	static const getV2DeviceMeSettingsTsunamiRegionsRegionId = "/v2/device/me/settings/tsunami/regions/{regionId}";
	/// /v2/device/me/settings/tsunami/regions/{regionId}
	static const patchV2DeviceMeSettingsTsunamiRegionsRegionId = "/v2/device/me/settings/tsunami/regions/{regionId}";
	/// /v2/device/me/settings/tsunami/regions/{regionId}
	static const deleteV2DeviceMeSettingsTsunamiRegionsRegionId = "/v2/device/me/settings/tsunami/regions/{regionId}";
	/// /v2/device/me/settings/slots
	static const getV2DeviceMeSettingsSlots = "/v2/device/me/settings/slots";
	/// /v2/device/me/settings/slots
	static const putV2DeviceMeSettingsSlots = "/v2/device/me/settings/slots";
	/// /v2/device/me/settings/slots/current-location
	static const getV2DeviceMeSettingsSlotsCurrentLocation = "/v2/device/me/settings/slots/current-location";
	/// /v2/device/me/settings/slots/current-location
	static const putV2DeviceMeSettingsSlotsCurrentLocation = "/v2/device/me/settings/slots/current-location";
	/// /v2/device/me/settings/slots/current-location
	static const deleteV2DeviceMeSettingsSlotsCurrentLocation = "/v2/device/me/settings/slots/current-location";
	/// /v2/device/me/settings/slots/nationwide
	static const getV2DeviceMeSettingsSlotsNationwide = "/v2/device/me/settings/slots/nationwide";
	/// /v2/device/me/settings/slots/nationwide
	static const putV2DeviceMeSettingsSlotsNationwide = "/v2/device/me/settings/slots/nationwide";
	/// /v2/device/me/settings/slots/nationwide
	static const deleteV2DeviceMeSettingsSlotsNationwide = "/v2/device/me/settings/slots/nationwide";
	/// /v2/device/me/settings/slots/regions
	static const getV2DeviceMeSettingsSlotsRegions = "/v2/device/me/settings/slots/regions";
	/// /v2/device/me/settings/slots/regions
	static const postV2DeviceMeSettingsSlotsRegions = "/v2/device/me/settings/slots/regions";
	/// /v2/device/me/settings/slots/regions/{slotId}
	static const patchV2DeviceMeSettingsSlotsRegionsSlotId = "/v2/device/me/settings/slots/regions/{slotId}";
	/// /v2/device/me/settings/slots/regions/{slotId}
	static const deleteV2DeviceMeSettingsSlotsRegionsSlotId = "/v2/device/me/settings/slots/regions/{slotId}";
	/// /v2/device/me/settings/eew-warning
	static const getV2DeviceMeSettingsEewWarning = "/v2/device/me/settings/eew-warning";
	/// /v2/device/me/settings/eew-warning
	static const patchV2DeviceMeSettingsEewWarning = "/v2/device/me/settings/eew-warning";
	/// /v2/device/me/location
	static const putV2DeviceMeLocation = "/v2/device/me/location";
	/// /v2/device/me/notification/webhooks
	static const postV2DeviceMeNotificationWebhooks = "/v2/device/me/notification/webhooks";
	/// /v2/device/me/notification/webhooks
	static const getV2DeviceMeNotificationWebhooks = "/v2/device/me/notification/webhooks";
	/// /v2/device/me/notification/webhooks/{id}
	static const deleteV2DeviceMeNotificationWebhooksId = "/v2/device/me/notification/webhooks/{id}";
	/// /v2/device/me/migrate
	static const postV2DeviceMeMigrate = "/v2/device/me/migrate";
}

