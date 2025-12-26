import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:retrofit/retrofit.dart';

part 'eew_api_client.g.dart';

/// 緊急地震速報API
@RestApi()
abstract class EewApiClient {
  factory EewApiClient(Dio dio, {String baseUrl}) = _EewApiClient;

  /// 最終報のEEW一覧を取得
  @GET('/v2/eew')
  Future<EewListResponse> getList({
    @Query('limit') int? limit,
    @Query('cursor') String? cursor,
  });

  /// 発表から5分以内の最新EEWを取得
  @GET('/v2/eew/latest')
  Future<EewLatestResponse> getLatest();

  /// イベントIDに紐づく全てのEEWを取得
  @GET('/v2/eew/{eventId}')
  Future<EewArrayResponse> getByEventId({
    @Path('eventId') required String eventId,
  });

  /// 特定のEEW（イベントID + シリアル番号）を取得
  @GET('/v2/eew/{eventId}/{serialNo}')
  Future<EewItemWithRelations> getByEventIdAndSerialNo({
    @Path('eventId') required String eventId,
    @Path('serialNo') required int serialNo,
  });
}
