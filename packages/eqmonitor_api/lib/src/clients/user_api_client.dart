// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/session_response.dart';
import '../models/user_device_response.dart';
import '../models/user_response.dart';

part 'user_api_client.g.dart';

@RestApi()
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String? baseUrl}) = _UserApiClient;

  /// 自分のユーザー情報を取得
  @GET(UserApiClientUrls.getV2UserMe)
  Future<HttpResponse<UserResponse>> getV2UserMe();

  /// プロフィールを更新（name, image）
  @PATCH(UserApiClientUrls.patchV2UserMe)
  Future<HttpResponse<UserResponse>> patchV2UserMe();

  /// アカウントを削除
  @DELETE(UserApiClientUrls.deleteV2UserMe)
  Future<HttpResponse<void>> deleteV2UserMe();

  /// 自分のデバイス一覧を取得
  @GET(UserApiClientUrls.getV2UserMeDevices)
  Future<HttpResponse<List<UserDeviceResponse>>> getV2UserMeDevices();

  /// アクティブセッション一覧を取得
  @GET(UserApiClientUrls.getV2UserMeSessions)
  Future<HttpResponse<List<SessionResponse>>> getV2UserMeSessions();

  /// セッションを無効化
  @DELETE(UserApiClientUrls.deleteV2UserMeSessionsToken)
  Future<HttpResponse<void>> deleteV2UserMeSessionsToken({
    @Path('token') required String token,
  });
}


abstract class UserApiClientUrls {
	/// /v2/user/me
	static const getV2UserMe = "/v2/user/me";
	/// /v2/user/me
	static const patchV2UserMe = "/v2/user/me";
	/// /v2/user/me
	static const deleteV2UserMe = "/v2/user/me";
	/// /v2/user/me/devices
	static const getV2UserMeDevices = "/v2/user/me/devices";
	/// /v2/user/me/sessions
	static const getV2UserMeSessions = "/v2/user/me/sessions";
	/// /v2/user/me/sessions/{token}
	static const deleteV2UserMeSessionsToken = "/v2/user/me/sessions/{token}";
}

