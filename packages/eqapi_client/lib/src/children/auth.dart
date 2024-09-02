import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:retrofit/retrofit.dart';

part 'auth.g.dart';

@RestApi()
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @PUT("/v1/auth/register")
  Future<HttpResponse<FcmTokenUpdateResponse>> register({
    @Body() required FcmTokenRequest request,
  });

  @PUT("/v1/auth/update")
  Future<HttpResponse<FcmTokenUpdateResponse>> update({
    @Body() required FcmTokenRequest request,
    @Header("Authorization") required String authorization,
  });

  @PUT('/v1/auth/settings/eew')
  Future<HttpResponse<void>> updateEewSettings({
    @Body() required NotificationSettingsRequest request,
    @Header("Authorization") required String authorization,
  });

  @PUT('/v1/auth/settings/earthquake')
  Future<HttpResponse<void>> updateEarthquakeSettings({
    @Body() required NotificationSettingsRequest request,
    @Header("Authorization") required String authorization,
  });

  @GET("/v1/auth/settings")
  Future<HttpResponse<NotificationSettingsResponse>> getNotificationSettings({
    @Header("Authorization") required String authorization,
  });
}
