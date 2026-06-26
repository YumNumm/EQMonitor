// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/challenge_response.dart';
import '../models/device_me_response.dart';
import '../models/device_register_body.dart';
import '../models/device_register_response.dart';
import '../models/earthquake_settings_request.dart';
import '../models/earthquake_settings_response.dart';
import '../models/eew_settings_request.dart';
import '../models/eew_settings_response.dart';
import '../models/live_activity_test_scenario_request.dart';
import '../models/live_activity_test_scenario_response.dart';
import '../models/live_activity_token_request.dart';
import '../models/live_activity_token_response.dart';
import '../models/notification_settings_request.dart';
import '../models/notification_settings_response.dart';
import '../models/region_setting_patch_request.dart';
import '../models/region_setting_request.dart';
import '../models/region_setting_response.dart';
import '../models/shake_detection_setting_request.dart';
import '../models/shake_detection_setting_response.dart';
import '../models/shake_detection_sub_region_response.dart';
import '../models/tsunami_region_setting_patch_request.dart';
import '../models/tsunami_region_setting_request.dart';
import '../models/tsunami_region_setting_response.dart';
import '../models/tsunami_settings_request.dart';
import '../models/tsunami_settings_response.dart';
import '../models/v2_device_me_apns_kind_request_body.dart';
import '../models/v2_device_me_fcm_request_body.dart';

part 'device_api_client.g.dart';

@RestApi()
abstract class DeviceApiClient {
  factory DeviceApiClient(Dio dio, {String? baseUrl}) = _DeviceApiClient;

  /// チャレンジコードを発行する（IP レート制限あり）
  @POST(DeviceApiClientUrls.postV2DeviceChallenge)
  Future<HttpResponse<ChallengeResponse>> postV2DeviceChallenge();

  /// デバイスを登録してJWTを返す。X-Firebase-AppCheck または X-Challenge-Code/X-Challenge-Response が必要。
  @POST(DeviceApiClientUrls.postV2Device)
  Future<HttpResponse<DeviceRegisterResponse>> postV2Device({
    @Body() required DeviceRegisterBody body,
  });

  /// デバイス情報を取得
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
    @Path('kind') required String kind,
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

  /// 地震通知リージョン設定一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsEarthquakeRegions)
  Future<HttpResponse<List<RegionSettingResponse>>> getV2DeviceMeSettingsEarthquakeRegions();

  /// 地震通知リージョン設定を一括更新（全件上書き）
  @PUT(DeviceApiClientUrls.putV2DeviceMeSettingsEarthquakeRegions)
  Future<HttpResponse<List<RegionSettingResponse>>> putV2DeviceMeSettingsEarthquakeRegions({
    @Body() required List<RegionSettingRequest> body,
  });

  /// 特定のリージョン設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsEarthquakeRegionsRegionId)
  Future<HttpResponse<RegionSettingResponse>> getV2DeviceMeSettingsEarthquakeRegionsRegionId({
    @Path('regionId') required num regionId,
  });

  /// 特定のリージョン設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceMeSettingsEarthquakeRegionsRegionId)
  Future<HttpResponse<RegionSettingResponse>> patchV2DeviceMeSettingsEarthquakeRegionsRegionId({
    @Path('regionId') required num regionId,
    @Body() required RegionSettingPatchRequest body,
  });

  /// 特定のリージョン設定を削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceMeSettingsEarthquakeRegionsRegionId)
  Future<HttpResponse<void>> deleteV2DeviceMeSettingsEarthquakeRegionsRegionId({
    @Path('regionId') required num regionId,
  });

  /// EEW通知設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsEew)
  Future<HttpResponse<EewSettingsResponse>> getV2DeviceMeSettingsEew();

  /// EEW通知設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceMeSettingsEew)
  Future<HttpResponse<EewSettingsResponse>> patchV2DeviceMeSettingsEew({
    @Body() required EewSettingsRequest body,
  });

  /// EEW通知リージョン設定一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsEewRegions)
  Future<HttpResponse<List<RegionSettingResponse>>> getV2DeviceMeSettingsEewRegions();

  /// EEW通知リージョン設定を一括更新（全件上書き）
  @PUT(DeviceApiClientUrls.putV2DeviceMeSettingsEewRegions)
  Future<HttpResponse<List<RegionSettingResponse>>> putV2DeviceMeSettingsEewRegions({
    @Body() required List<RegionSettingRequest> body,
  });

  /// 特定のリージョン設定を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeSettingsEewRegionsRegionId)
  Future<HttpResponse<RegionSettingResponse>> getV2DeviceMeSettingsEewRegionsRegionId({
    @Path('regionId') required num regionId,
  });

  /// 特定のリージョン設定を更新
  @PATCH(DeviceApiClientUrls.patchV2DeviceMeSettingsEewRegionsRegionId)
  Future<HttpResponse<RegionSettingResponse>> patchV2DeviceMeSettingsEewRegionsRegionId({
    @Path('regionId') required num regionId,
    @Body() required RegionSettingPatchRequest body,
  });

  /// 特定のリージョン設定を削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceMeSettingsEewRegionsRegionId)
  Future<HttpResponse<void>> deleteV2DeviceMeSettingsEewRegionsRegionId({
    @Path('regionId') required num regionId,
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

  /// Live Activity updateToken一覧を取得
  @GET(DeviceApiClientUrls.getV2DeviceMeLiveActivity)
  Future<HttpResponse<List<LiveActivityTokenResponse>>> getV2DeviceMeLiveActivity();

  /// Live Activity updateTokenを更新。notification-resolverで作成されたレコードのtokenを更新する。
  @PUT(DeviceApiClientUrls.putV2DeviceMeLiveActivityLiveActivityIdToken)
  Future<HttpResponse<LiveActivityTokenResponse>> putV2DeviceMeLiveActivityLiveActivityIdToken({
    @Path('liveActivityId') required String liveActivityId,
    @Body() required LiveActivityTokenRequest body,
  });

  /// Live Activity updateTokenを削除
  @DELETE(DeviceApiClientUrls.deleteV2DeviceMeLiveActivityLiveActivityIdToken)
  Future<HttpResponse<void>> deleteV2DeviceMeLiveActivityLiveActivityIdToken({
    @Path('liveActivityId') required String liveActivityId,
  });

  /// デバッグ用: Live Activity の 4 報シーケンス（start + 3 updates）を再生する
  @POST(DeviceApiClientUrls.postV2DeviceMeLiveActivityTestScenario)
  Future<HttpResponse<LiveActivityTestScenarioResponse>> postV2DeviceMeLiveActivityTestScenario({
    @Body() required LiveActivityTestScenarioRequest body,
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
	/// /v2/device/me/settings/earthquake/regions
	static const getV2DeviceMeSettingsEarthquakeRegions = "/v2/device/me/settings/earthquake/regions";
	/// /v2/device/me/settings/earthquake/regions
	static const putV2DeviceMeSettingsEarthquakeRegions = "/v2/device/me/settings/earthquake/regions";
	/// /v2/device/me/settings/earthquake/regions/{regionId}
	static const getV2DeviceMeSettingsEarthquakeRegionsRegionId = "/v2/device/me/settings/earthquake/regions/{regionId}";
	/// /v2/device/me/settings/earthquake/regions/{regionId}
	static const patchV2DeviceMeSettingsEarthquakeRegionsRegionId = "/v2/device/me/settings/earthquake/regions/{regionId}";
	/// /v2/device/me/settings/earthquake/regions/{regionId}
	static const deleteV2DeviceMeSettingsEarthquakeRegionsRegionId = "/v2/device/me/settings/earthquake/regions/{regionId}";
	/// /v2/device/me/settings/eew
	static const getV2DeviceMeSettingsEew = "/v2/device/me/settings/eew";
	/// /v2/device/me/settings/eew
	static const patchV2DeviceMeSettingsEew = "/v2/device/me/settings/eew";
	/// /v2/device/me/settings/eew/regions
	static const getV2DeviceMeSettingsEewRegions = "/v2/device/me/settings/eew/regions";
	/// /v2/device/me/settings/eew/regions
	static const putV2DeviceMeSettingsEewRegions = "/v2/device/me/settings/eew/regions";
	/// /v2/device/me/settings/eew/regions/{regionId}
	static const getV2DeviceMeSettingsEewRegionsRegionId = "/v2/device/me/settings/eew/regions/{regionId}";
	/// /v2/device/me/settings/eew/regions/{regionId}
	static const patchV2DeviceMeSettingsEewRegionsRegionId = "/v2/device/me/settings/eew/regions/{regionId}";
	/// /v2/device/me/settings/eew/regions/{regionId}
	static const deleteV2DeviceMeSettingsEewRegionsRegionId = "/v2/device/me/settings/eew/regions/{regionId}";
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
	/// /v2/device/me/live-activity
	static const getV2DeviceMeLiveActivity = "/v2/device/me/live-activity";
	/// /v2/device/me/live-activity/{liveActivityId}/token
	static const putV2DeviceMeLiveActivityLiveActivityIdToken = "/v2/device/me/live-activity/{liveActivityId}/token";
	/// /v2/device/me/live-activity/{liveActivityId}/token
	static const deleteV2DeviceMeLiveActivityLiveActivityIdToken = "/v2/device/me/live-activity/{liveActivityId}/token";
	/// /v2/device/me/live-activity/test-scenario
	static const postV2DeviceMeLiveActivityTestScenario = "/v2/device/me/live-activity/test-scenario";
}

