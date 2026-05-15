// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/changelog_response.dart';

part 'changelog_api_client.g.dart';

@RestApi()
abstract class ChangelogApiClient {
  factory ChangelogApiClient(Dio dio, {String? baseUrl}) = _ChangelogApiClient;

  /// アプリのバージョン履歴を返す
  @GET(ChangelogApiClientUrls.getV1Changelog)
  Future<HttpResponse<ChangelogResponse>> getV1Changelog({
    @Query('since') String? since,
    @Query('limit') int? limit,
    @Header('if-none-match') String? ifNoneMatch,
  });
}


abstract class ChangelogApiClientUrls {
	/// /v1/changelog
	static const getV1Changelog = "/v1/changelog";
}

