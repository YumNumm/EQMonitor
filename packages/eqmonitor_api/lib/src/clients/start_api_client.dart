// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/start_response.dart';

part 'start_api_client.g.dart';

@RestApi()
abstract class StartApiClient {
  factory StartApiClient(Dio dio, {String? baseUrl}) = _StartApiClient;

  /// アプリ起動時のフラグ・バージョン情報を返す
  @GET(StartApiClientUrls.getV1Start)
  Future<HttpResponse<StartResponse>> getV1Start({
    @Header('if-none-match') String? ifNoneMatch,
  });
}

abstract class StartApiClientUrls {
  /// /v1/start
  static const getV1Start = "/v1/start";
}
