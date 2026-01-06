import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:retrofit/retrofit.dart';

part 'device_api_client.g.dart';

/// デバイスAPI
@RestApi()
abstract class DeviceApiClient {
  factory DeviceApiClient(Dio dio, {String baseUrl}) = _DeviceApiClient;

  /// デバイス情報を取得
  @GET('/v2/device/{deviceId}')
  Future<Device> getDevice({
    @Path('deviceId') required String deviceId,
  });

  // === APNs ===

  /// APNsトークン一覧を取得
  @GET('/v2/device/{deviceId}/apns')
  Future<List<ApnsToken>> getApnsTokens({
    @Path('deviceId') required String deviceId,
  });

  /// APNsトークンを登録
  @POST('/v2/device/{deviceId}/apns/{tokenType}')
  Future<ApnsToken> registerApnsToken({
    @Path('deviceId') required String deviceId,
    @Path('tokenType') required String tokenType,
    @Body() required ApnsTokenRequest request,
  });

  /// APNsトークンを削除
  @DELETE('/v2/device/{deviceId}/apns/{tokenType}')
  Future<void> deleteApnsToken({
    @Path('deviceId') required String deviceId,
    @Path('tokenType') required String tokenType,
  });

  // === FCM ===

  /// FCMトークンを取得
  @GET('/v2/device/{deviceId}/fcm')
  Future<FcmToken?> getFcmToken({
    @Path('deviceId') required String deviceId,
  });

  /// FCMトークンを登録
  @PUT('/v2/device/{deviceId}/fcm')
  Future<FcmToken> registerFcmToken({
    @Path('deviceId') required String deviceId,
    @Body() required FcmTokenRequest request,
  });

  /// FCMトークンを削除
  @DELETE('/v2/device/{deviceId}/fcm')
  Future<void> deleteFcmToken({
    @Path('deviceId') required String deviceId,
  });

  // === 全般通知設定 ===

  /// 全般通知設定を取得
  @GET('/v2/device/{deviceId}/settings/notification')
  Future<NotificationSettings> getNotificationSettings({
    @Path('deviceId') required String deviceId,
  });

  /// 全般通知設定を更新
  @PATCH('/v2/device/{deviceId}/settings/notification')
  Future<NotificationSettings> updateNotificationSettings({
    @Path('deviceId') required String deviceId,
    @Body() required NotificationSettingsRequest request,
  });

  // === 地震通知設定 ===

  /// 地震通知設定を取得
  @GET('/v2/device/{deviceId}/settings/earthquake')
  Future<EarthquakeNotificationSettings> getEarthquakeSettings({
    @Path('deviceId') required String deviceId,
  });

  /// 地震通知設定を更新
  @PATCH('/v2/device/{deviceId}/settings/earthquake')
  Future<EarthquakeNotificationSettings> updateEarthquakeSettings({
    @Path('deviceId') required String deviceId,
    @Body() required EarthquakeNotificationSettingsRequest request,
  });

  /// 地震リージョン設定一覧を取得
  @GET('/v2/device/{deviceId}/settings/earthquake/regions')
  Future<List<RegionSetting>> getEarthquakeRegions({
    @Path('deviceId') required String deviceId,
  });

  /// 地震リージョン設定を一括更新
  @PUT('/v2/device/{deviceId}/settings/earthquake/regions')
  Future<List<RegionSetting>> replaceEarthquakeRegions({
    @Path('deviceId') required String deviceId,
    @Body() required List<RegionSettingRequest> request,
  });

  /// 特定の地震リージョン設定を取得
  @GET('/v2/device/{deviceId}/settings/earthquake/regions/{regionId}')
  Future<RegionSetting> getEarthquakeRegion({
    @Path('deviceId') required String deviceId,
    @Path('regionId') required int regionId,
  });

  /// 特定の地震リージョン設定を更新
  @PATCH('/v2/device/{deviceId}/settings/earthquake/regions/{regionId}')
  Future<RegionSetting> updateEarthquakeRegion({
    @Path('deviceId') required String deviceId,
    @Path('regionId') required int regionId,
    @Body() required RegionSettingPatchRequest request,
  });

  /// 特定の地震リージョン設定を削除
  @DELETE('/v2/device/{deviceId}/settings/earthquake/regions/{regionId}')
  Future<void> deleteEarthquakeRegion({
    @Path('deviceId') required String deviceId,
    @Path('regionId') required int regionId,
  });

  // === EEW通知設定 ===

  /// EEW通知設定を取得
  @GET('/v2/device/{deviceId}/settings/eew')
  Future<EewNotificationSettings> getEewSettings({
    @Path('deviceId') required String deviceId,
  });

  /// EEW通知設定を更新
  @PATCH('/v2/device/{deviceId}/settings/eew')
  Future<EewNotificationSettings> updateEewSettings({
    @Path('deviceId') required String deviceId,
    @Body() required EewNotificationSettingsRequest request,
  });

  /// EEWリージョン設定一覧を取得
  @GET('/v2/device/{deviceId}/settings/eew/regions')
  Future<List<RegionSetting>> getEewRegions({
    @Path('deviceId') required String deviceId,
  });

  /// EEWリージョン設定を一括更新
  @PUT('/v2/device/{deviceId}/settings/eew/regions')
  Future<List<RegionSetting>> replaceEewRegions({
    @Path('deviceId') required String deviceId,
    @Body() required List<RegionSettingRequest> request,
  });

  /// 特定のEEWリージョン設定を取得
  @GET('/v2/device/{deviceId}/settings/eew/regions/{regionId}')
  Future<RegionSetting> getEewRegion({
    @Path('deviceId') required String deviceId,
    @Path('regionId') required int regionId,
  });

  /// 特定のEEWリージョン設定を更新
  @PATCH('/v2/device/{deviceId}/settings/eew/regions/{regionId}')
  Future<RegionSetting> updateEewRegion({
    @Path('deviceId') required String deviceId,
    @Path('regionId') required int regionId,
    @Body() required RegionSettingPatchRequest request,
  });

  /// 特定のEEWリージョン設定を削除
  @DELETE('/v2/device/{deviceId}/settings/eew/regions/{regionId}')
  Future<void> deleteEewRegion({
    @Path('deviceId') required String deviceId,
    @Path('regionId') required int regionId,
  });
}
