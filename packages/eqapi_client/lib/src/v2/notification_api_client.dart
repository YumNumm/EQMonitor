import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:retrofit/retrofit.dart';

part 'notification_api_client.g.dart';

/// 通知設定API
@RestApi()
abstract class NotificationSettingsApiClient {
  factory NotificationSettingsApiClient(Dio dio, {String baseUrl}) =
      _NotificationSettingsApiClient;

  /// 全般通知設定を取得
  @GET('/v2/notification/settings')
  Future<NotificationSettings> getSettings();

  /// 全般通知設定を更新
  @PUT('/v2/notification/settings')
  Future<NotificationSettings> updateSettings(
    @Body() NotificationSettingsRequest request,
  );

  /// 地震通知設定を取得
  @GET('/v2/notification/settings/earthquake')
  Future<EarthquakeNotificationSettings> getEarthquakeSettings();

  /// 地震通知設定を更新
  @PUT('/v2/notification/settings/earthquake')
  Future<EarthquakeNotificationSettings> updateEarthquakeSettings(
    @Body() EarthquakeNotificationSettingsRequest request,
  );

  /// EEW通知設定を取得
  @GET('/v2/notification/settings/eew')
  Future<EewNotificationSettings> getEewSettings();

  /// EEW通知設定を更新
  @PUT('/v2/notification/settings/eew')
  Future<EewNotificationSettings> updateEewSettings(
    @Body() EewNotificationSettingsRequest request,
  );
}
