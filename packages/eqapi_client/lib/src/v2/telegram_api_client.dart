import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:retrofit/retrofit.dart';

part 'telegram_api_client.g.dart';

/// 電文API
@RestApi()
abstract class TelegramApiClient {
  factory TelegramApiClient(Dio dio, {String baseUrl}) = _TelegramApiClient;

  /// 電文一覧を取得
  @GET('/v2/telegram')
  Future<TelegramListResponse> getList({
    @Query('limit') int? limit,
    @Query('cursor') String? cursor,
  });

  /// type別電文一覧を取得
  @GET('/v2/telegram/type/{type}')
  Future<TelegramListResponse> getListByType({
    @Path('type') required String type,
    @Query('limit') int? limit,
    @Query('cursor') String? cursor,
  });

  /// eventId別電文一覧を取得
  @GET('/v2/telegram/eventId/{eventId}')
  Future<TelegramListResponse> getListByEventId({
    @Path('eventId') required String eventId,
    @Query('limit') int? limit,
    @Query('cursor') String? cursor,
  });

  /// 電文詳細を取得
  @GET('/v2/telegram/{id}')
  Future<TelegramDetailResponse> getDetail({
    @Path('id') required String id,
  });
}
