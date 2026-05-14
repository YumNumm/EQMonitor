// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/apns_token_request.dart';
import '../models/apns_token_response.dart';
import '../models/apns_token_type.dart';
import '../models/device_response.dart';
import '../models/device_upsert_request.dart';
import '../models/earthquake_settings_request.dart';
import '../models/earthquake_settings_response.dart';
import '../models/eew_settings_request.dart';
import '../models/eew_settings_response.dart';
import '../models/fcm_token_request.dart';
import '../models/fcm_token_response.dart';
import '../models/live_activity_test_scenario_request.dart';
import '../models/live_activity_test_scenario_response.dart';
import '../models/live_activity_token_request.dart';
import '../models/live_activity_token_response.dart';
import '../models/migrate_request.dart';
import '../models/migration_response.dart';
import '../models/notification_settings_request.dart';
import '../models/notification_settings_response.dart';
import '../models/region_setting_patch_request.dart';
import '../models/region_setting_request.dart';
import '../models/region_setting_response.dart';
import '../models/shake_detection_setting_request.dart';
import '../models/shake_detection_setting_response.dart';
import '../models/shake_detection_sub_region_response.dart';

part 'device_api_client.g.dart';

@RestApi()
abstract class DeviceApiClient {
  factory DeviceApiClient(Dio dio, {String? baseUrl}) = _DeviceApiClient;

  /// デバイスを作成または更新（Better Auth または Firebase App Check 必須）
  @PUT(DeviceApiClientUrls.putV2DeviceDeviceId)
  Future<HttpResponse<DeviceResponse>> putV2DeviceDeviceId({
    @Path('deviceId') required String deviceId,
    @Body() required DeviceUpsertRequest body,
  });

  /// デバイス情報を取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceId)
  Future<HttpResponse<DeviceResponse>> getV2DeviceDeviceId({
    @Path('deviceId') required String deviceId,
  });

  /// デバイスを削除（関連データも全て削除）
  @DELETE(DeviceApiClientUrls.deleteV2DeviceDeviceId)
  Future<HttpResponse<void>> deleteV2DeviceDeviceId({
    @Path('deviceId') required String deviceId,
  });

  /// APNsトークン一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdApns)
  Future<HttpResponse<List<ApnsTokenResponse>>> getV2DeviceDeviceIdApns({
    @Path('deviceId') required String deviceId,
  });

  /// 特定タイプのAPNsトークンを取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdApnsType)
  Future<HttpResponse<ApnsTokenResponse>> getV2DeviceDeviceIdApnsType({
    @Path('type') required ApnsTokenType type,
    @Path('deviceId') required String deviceId,
  });

  /// APNsトークンを更新（存在しない場合は作成）
  @PATCH(DeviceApiClientUrls.patchV2DeviceDeviceIdApnsType)
  Future<HttpResponse<ApnsTokenResponse>> patchV2DeviceDeviceIdApnsType({
    @Path('type') required ApnsTokenType type,
    @Path('deviceId') required String deviceId,
    @Body() required ApnsTokenRequest body,
  });

  /// APNsトークンを削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceDeviceIdApnsType)
  Future<HttpResponse<void>> deleteV2DeviceDeviceIdApnsType({
    @Path('type') required ApnsTokenType type,
    @Path('deviceId') required String deviceId,
  });

  /// FCMトークンを取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdFcm)
  Future<HttpResponse<FcmTokenResponse?>> getV2DeviceDeviceIdFcm({
    @Path('deviceId') required String deviceId,
  });

  /// FCMトークンを更新（存在しない場合は作成）
  @PATCH(DeviceApiClientUrls.patchV2DeviceDeviceIdFcm)
  Future<HttpResponse<FcmTokenResponse?>> patchV2DeviceDeviceIdFcm({
    @Path('deviceId') required String deviceId,
    @Body() required FcmTokenRequest body,
  });

  /// FCMトークンを削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceDeviceIdFcm)
  Future<HttpResponse<void>> deleteV2DeviceDeviceIdFcm({
    @Path('deviceId') required String deviceId,
  });

  /// Live Activity updateToken一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdLiveActivity)
  Future<HttpResponse<List<LiveActivityTokenResponse>>> getV2DeviceDeviceIdLiveActivity({
    @Path('deviceId') required String deviceId,
  });

  /// Live Activity updateTokenを更新。notification-resolverで作成されたレコードのtokenを更新する。
  @PUT(DeviceApiClientUrls.putV2DeviceDeviceIdLiveActivityLiveActivityIdToken)
  Future<HttpResponse<LiveActivityTokenResponse>> putV2DeviceDeviceIdLiveActivityLiveActivityIdToken({
    @Path('liveActivityId') required String liveActivityId,
    @Path('deviceId') required String deviceId,
    @Body() required LiveActivityTokenRequest body,
  });

  /// Live Activity updateTokenを削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceDeviceIdLiveActivityLiveActivityIdToken)
  Future<HttpResponse<void>> deleteV2DeviceDeviceIdLiveActivityLiveActivityIdToken({
    @Path('liveActivityId') required String liveActivityId,
    @Path('deviceId') required String deviceId,
  });

  /// デバッグ用: Live Activity の 4 報シーケンス（start + 3 updates）を再生する
  @POST(DeviceApiClientUrls.postV2DeviceDeviceIdLiveActivityTestScenario)
  Future<HttpResponse<LiveActivityTestScenarioResponse>> postV2DeviceDeviceIdLiveActivityTestScenario({
    @Path('deviceId') required String deviceId,
    @Body() required LiveActivityTestScenarioRequest body,
  });

  /// 全般通知設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdSettingsNotification)
  Future<HttpResponse<NotificationSettingsResponse>> getV2DeviceDeviceIdSettingsNotification({
    @Path('deviceId') required String deviceId,
  });

  /// 全般通知設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceDeviceIdSettingsNotification)
  Future<HttpResponse<NotificationSettingsResponse>> patchV2DeviceDeviceIdSettingsNotification({
    @Path('deviceId') required String deviceId,
    @Body() required NotificationSettingsRequest body,
  });

  /// 地震通知設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdSettingsEarthquake)
  Future<HttpResponse<EarthquakeSettingsResponse>> getV2DeviceDeviceIdSettingsEarthquake({
    @Path('deviceId') required String deviceId,
  });

  /// 地震通知設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceDeviceIdSettingsEarthquake)
  Future<HttpResponse<EarthquakeSettingsResponse>> patchV2DeviceDeviceIdSettingsEarthquake({
    @Path('deviceId') required String deviceId,
    @Body() required EarthquakeSettingsRequest body,
  });

  /// 地震通知リージョン設定一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdSettingsEarthquakeRegions)
  Future<HttpResponse<List<RegionSettingResponse>>> getV2DeviceDeviceIdSettingsEarthquakeRegions({
    @Path('deviceId') required String deviceId,
  });

  /// 地震通知リージョン設定を一括更新（全件上書き）
  @PUT(DeviceApiClientUrls.putV2DeviceDeviceIdSettingsEarthquakeRegions)
  Future<HttpResponse<List<RegionSettingResponse>>> putV2DeviceDeviceIdSettingsEarthquakeRegions({
    @Path('deviceId') required String deviceId,
    @Body() required List<RegionSettingRequest> body,
  });

  /// 特定のリージョン設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdSettingsEarthquakeRegionsRegionId)
  Future<HttpResponse<RegionSettingResponse>> getV2DeviceDeviceIdSettingsEarthquakeRegionsRegionId({
    @Path('regionId') required num regionId,
    @Path('deviceId') required String deviceId,
  });

  /// 特定のリージョン設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceDeviceIdSettingsEarthquakeRegionsRegionId)
  Future<HttpResponse<RegionSettingResponse>> patchV2DeviceDeviceIdSettingsEarthquakeRegionsRegionId({
    @Path('regionId') required num regionId,
    @Path('deviceId') required String deviceId,
    @Body() required RegionSettingPatchRequest body,
  });

  /// 特定のリージョン設定を削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceDeviceIdSettingsEarthquakeRegionsRegionId)
  Future<HttpResponse<void>> deleteV2DeviceDeviceIdSettingsEarthquakeRegionsRegionId({
    @Path('regionId') required num regionId,
    @Path('deviceId') required String deviceId,
  });

  /// EEW通知設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdSettingsEew)
  Future<HttpResponse<EewSettingsResponse>> getV2DeviceDeviceIdSettingsEew({
    @Path('deviceId') required String deviceId,
  });

  /// EEW通知設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceDeviceIdSettingsEew)
  Future<HttpResponse<EewSettingsResponse>> patchV2DeviceDeviceIdSettingsEew({
    @Path('deviceId') required String deviceId,
    @Body() required EewSettingsRequest body,
  });

  /// EEW通知リージョン設定一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdSettingsEewRegions)
  Future<HttpResponse<List<RegionSettingResponse>>> getV2DeviceDeviceIdSettingsEewRegions({
    @Path('deviceId') required String deviceId,
  });

  /// EEW通知リージョン設定を一括更新（全件上書き）
  @PUT(DeviceApiClientUrls.putV2DeviceDeviceIdSettingsEewRegions)
  Future<HttpResponse<List<RegionSettingResponse>>> putV2DeviceDeviceIdSettingsEewRegions({
    @Path('deviceId') required String deviceId,
    @Body() required List<RegionSettingRequest> body,
  });

  /// 特定のリージョン設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdSettingsEewRegionsRegionId)
  Future<HttpResponse<RegionSettingResponse>> getV2DeviceDeviceIdSettingsEewRegionsRegionId({
    @Path('regionId') required num regionId,
    @Path('deviceId') required String deviceId,
  });

  /// 特定のリージョン設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceDeviceIdSettingsEewRegionsRegionId)
  Future<HttpResponse<RegionSettingResponse>> patchV2DeviceDeviceIdSettingsEewRegionsRegionId({
    @Path('regionId') required num regionId,
    @Path('deviceId') required String deviceId,
    @Body() required RegionSettingPatchRequest body,
  });

  /// 特定のリージョン設定を削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceDeviceIdSettingsEewRegionsRegionId)
  Future<HttpResponse<void>> deleteV2DeviceDeviceIdSettingsEewRegionsRegionId({
    @Path('regionId') required num regionId,
    @Path('deviceId') required String deviceId,
  });

  /// 揺れ検知通知設定一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdSettingsShakeDetection)
  Future<HttpResponse<List<ShakeDetectionSettingResponse>>> getV2DeviceDeviceIdSettingsShakeDetection({
    @Path('deviceId') required String deviceId,
  });

  /// 揺れ検知通知設定を一括更新（全件上書き）
  @PUT(DeviceApiClientUrls.putV2DeviceDeviceIdSettingsShakeDetection)
  Future<HttpResponse<List<ShakeDetectionSettingResponse>>> putV2DeviceDeviceIdSettingsShakeDetection({
    @Path('deviceId') required String deviceId,
    @Body() required List<ShakeDetectionSettingRequest> body,
  });

  /// 揺れ検知サブ地域マスター一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceDeviceIdSettingsShakeDetectionSubRegions)
  Future<HttpResponse<List<ShakeDetectionSubRegionResponse>>> getV2DeviceDeviceIdSettingsShakeDetectionSubRegions({
    @Path('deviceId') required String deviceId,
  });

  /// 旧 Supabase のデバイス設定を新 DB に移行
  @POST(DeviceApiClientUrls.postV2DeviceDeviceIdMigrate)
  Future<HttpResponse<MigrationResponse>> postV2DeviceDeviceIdMigrate({
    @Path('deviceId') required String deviceId,
    @Body() required MigrateRequest body,
  });
}


abstract class DeviceApiClientUrls {
	/// /v2/device/{deviceId}
	static const putV2DeviceDeviceId = "/v2/device/{deviceId}";
	/// /v2/device/{deviceId}
	static const getV2DeviceDeviceId = "/v2/device/{deviceId}";
	/// /v2/device/{deviceId}
	static const deleteV2DeviceDeviceId = "/v2/device/{deviceId}";
	/// /v2/device/{deviceId}/apns
	static const getV2DeviceDeviceIdApns = "/v2/device/{deviceId}/apns";
	/// /v2/device/{deviceId}/apns/{type}
	static const getV2DeviceDeviceIdApnsType = "/v2/device/{deviceId}/apns/{type}";
	/// /v2/device/{deviceId}/apns/{type}
	static const patchV2DeviceDeviceIdApnsType = "/v2/device/{deviceId}/apns/{type}";
	/// /v2/device/{deviceId}/apns/{type}
	static const deleteV2DeviceDeviceIdApnsType = "/v2/device/{deviceId}/apns/{type}";
	/// /v2/device/{deviceId}/fcm
	static const getV2DeviceDeviceIdFcm = "/v2/device/{deviceId}/fcm";
	/// /v2/device/{deviceId}/fcm
	static const patchV2DeviceDeviceIdFcm = "/v2/device/{deviceId}/fcm";
	/// /v2/device/{deviceId}/fcm
	static const deleteV2DeviceDeviceIdFcm = "/v2/device/{deviceId}/fcm";
	/// /v2/device/{deviceId}/live-activity
	static const getV2DeviceDeviceIdLiveActivity = "/v2/device/{deviceId}/live-activity";
	/// /v2/device/{deviceId}/live-activity/{liveActivityId}/token
	static const putV2DeviceDeviceIdLiveActivityLiveActivityIdToken = "/v2/device/{deviceId}/live-activity/{liveActivityId}/token";
	/// /v2/device/{deviceId}/live-activity/{liveActivityId}/token
	static const deleteV2DeviceDeviceIdLiveActivityLiveActivityIdToken = "/v2/device/{deviceId}/live-activity/{liveActivityId}/token";
	/// /v2/device/{deviceId}/live-activity/test-scenario
	static const postV2DeviceDeviceIdLiveActivityTestScenario = "/v2/device/{deviceId}/live-activity/test-scenario";
	/// /v2/device/{deviceId}/settings/notification
	static const getV2DeviceDeviceIdSettingsNotification = "/v2/device/{deviceId}/settings/notification";
	/// /v2/device/{deviceId}/settings/notification
	static const patchV2DeviceDeviceIdSettingsNotification = "/v2/device/{deviceId}/settings/notification";
	/// /v2/device/{deviceId}/settings/earthquake
	static const getV2DeviceDeviceIdSettingsEarthquake = "/v2/device/{deviceId}/settings/earthquake";
	/// /v2/device/{deviceId}/settings/earthquake
	static const patchV2DeviceDeviceIdSettingsEarthquake = "/v2/device/{deviceId}/settings/earthquake";
	/// /v2/device/{deviceId}/settings/earthquake/regions
	static const getV2DeviceDeviceIdSettingsEarthquakeRegions = "/v2/device/{deviceId}/settings/earthquake/regions";
	/// /v2/device/{deviceId}/settings/earthquake/regions
	static const putV2DeviceDeviceIdSettingsEarthquakeRegions = "/v2/device/{deviceId}/settings/earthquake/regions";
	/// /v2/device/{deviceId}/settings/earthquake/regions/{regionId}
	static const getV2DeviceDeviceIdSettingsEarthquakeRegionsRegionId = "/v2/device/{deviceId}/settings/earthquake/regions/{regionId}";
	/// /v2/device/{deviceId}/settings/earthquake/regions/{regionId}
	static const patchV2DeviceDeviceIdSettingsEarthquakeRegionsRegionId = "/v2/device/{deviceId}/settings/earthquake/regions/{regionId}";
	/// /v2/device/{deviceId}/settings/earthquake/regions/{regionId}
	static const deleteV2DeviceDeviceIdSettingsEarthquakeRegionsRegionId = "/v2/device/{deviceId}/settings/earthquake/regions/{regionId}";
	/// /v2/device/{deviceId}/settings/eew
	static const getV2DeviceDeviceIdSettingsEew = "/v2/device/{deviceId}/settings/eew";
	/// /v2/device/{deviceId}/settings/eew
	static const patchV2DeviceDeviceIdSettingsEew = "/v2/device/{deviceId}/settings/eew";
	/// /v2/device/{deviceId}/settings/eew/regions
	static const getV2DeviceDeviceIdSettingsEewRegions = "/v2/device/{deviceId}/settings/eew/regions";
	/// /v2/device/{deviceId}/settings/eew/regions
	static const putV2DeviceDeviceIdSettingsEewRegions = "/v2/device/{deviceId}/settings/eew/regions";
	/// /v2/device/{deviceId}/settings/eew/regions/{regionId}
	static const getV2DeviceDeviceIdSettingsEewRegionsRegionId = "/v2/device/{deviceId}/settings/eew/regions/{regionId}";
	/// /v2/device/{deviceId}/settings/eew/regions/{regionId}
	static const patchV2DeviceDeviceIdSettingsEewRegionsRegionId = "/v2/device/{deviceId}/settings/eew/regions/{regionId}";
	/// /v2/device/{deviceId}/settings/eew/regions/{regionId}
	static const deleteV2DeviceDeviceIdSettingsEewRegionsRegionId = "/v2/device/{deviceId}/settings/eew/regions/{regionId}";
	/// /v2/device/{deviceId}/settings/shake-detection
	static const getV2DeviceDeviceIdSettingsShakeDetection = "/v2/device/{deviceId}/settings/shake-detection";
	/// /v2/device/{deviceId}/settings/shake-detection
	static const putV2DeviceDeviceIdSettingsShakeDetection = "/v2/device/{deviceId}/settings/shake-detection";
	/// /v2/device/{deviceId}/settings/shake-detection/sub-regions
	static const getV2DeviceDeviceIdSettingsShakeDetectionSubRegions = "/v2/device/{deviceId}/settings/shake-detection/sub-regions";
	/// /v2/device/{deviceId}/migrate
	static const postV2DeviceDeviceIdMigrate = "/v2/device/{deviceId}/migrate";
}

