// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/user_response.dart';

part 'user_api_client.g.dart';

@RestApi()
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String? baseUrl}) = _UserApiClient;

  /// ユーザーを作成
  @POST(UserApiClientUrls.postV2User)
  Future<HttpResponse<UserResponse>> postV2User();

  /// ユーザー情報を取得
  @GET(UserApiClientUrls.getV2UserUserId)
  Future<HttpResponse<UserResponse>> getV2UserUserId({
    @Path('userId') required String userId,
  });
}

abstract class UserApiClientUrls {
  /// /v2/user
  static const postV2User = "/v2/user";

  /// /v2/user/{userId}
  static const getV2UserUserId = "/v2/user/{userId}";
}
