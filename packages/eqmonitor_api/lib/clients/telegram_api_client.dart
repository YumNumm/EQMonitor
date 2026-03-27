// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/telegram_detail_response.dart';
import '../models/telegram_list_response.dart';
import '../models/telegram_type.dart';

part 'telegram_api_client.g.dart';

@RestApi()
abstract class TelegramApiClient {
  factory TelegramApiClient(Dio dio, {String? baseUrl}) = _TelegramApiClient;

  /// [limit] - 1~100 の整数(string).
  ///
  /// [cursor] - カーソル情報, {type}:{id} を base64 エンコードしたもの.
  @GET(TelegramApiClientUrls.getV2Telegram)
  Future<HttpResponse<TelegramListResponse>> getV2Telegram({
    @Query('statuses') dynamic statuses = const ['NORMAL'],
    @Query('limit') String? limit,
    @Query('cursor') String? cursor,
  });

  /// [limit] - 1~100 の整数(string).
  ///
  /// [cursor] - カーソル情報, {type}:{id} を base64 エンコードしたもの.
  @GET(TelegramApiClientUrls.getV2TelegramTypeType)
  Future<HttpResponse<TelegramListResponse>> getV2TelegramTypeType({
    @Path('type') required TelegramType type,
    @Query('statuses') dynamic statuses = const ['NORMAL'],
    @Query('limit') String? limit,
    @Query('cursor') String? cursor,
  });

  /// [limit] - 1~100 の整数(string).
  ///
  /// [cursor] - カーソル情報, {type}:{id} を base64 エンコードしたもの.
  @GET(TelegramApiClientUrls.getV2TelegramEventIdEventId)
  Future<HttpResponse<TelegramListResponse>> getV2TelegramEventIdEventId({
    @Path('eventId') required String eventId,
    @Query('statuses') dynamic statuses = const ['NORMAL'],
    @Query('limit') String? limit,
    @Query('cursor') String? cursor,
  });

  @GET(TelegramApiClientUrls.getV2TelegramId)
  Future<HttpResponse<TelegramDetailResponse>> getV2TelegramId({
    @Path('id') required String id,
  });
}


abstract class TelegramApiClientUrls {
	/// /v2/telegram
	static const getV2Telegram = "/v2/telegram";
	/// /v2/telegram/type/{type}
	static const getV2TelegramTypeType = "/v2/telegram/type/{type}";
	/// /v2/telegram/eventId/{eventId}
	static const getV2TelegramEventIdEventId = "/v2/telegram/eventId/{eventId}";
	/// /v2/telegram/{id}
	static const getV2TelegramId = "/v2/telegram/{id}";
}

