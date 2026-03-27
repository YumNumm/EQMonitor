// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/is_canceled.dart';
import '../models/sort_order.dart';
import '../models/tsunami_detail_response.dart';
import '../models/tsunami_list_response.dart';

part 'tsunami_api_client.g.dart';

@RestApi()
abstract class TsunamiApiClient {
  factory TsunamiApiClient(Dio dio, {String? baseUrl}) = _TsunamiApiClient;

  /// 津波情報一覧.
  ///
  /// [limit] - 1~100 の整数(string).
  ///
  /// [cursor] - カーソル情報, {type}:{id} を base64 エンコードしたもの.
  ///
  /// [isCanceled] - 取消済みフィルタ.
  ///
  /// [createdAtGte] - ISO8601形式のタイムスタンプ (例: 2024-01-01T00:00:00Z).
  ///
  /// [createdAtLte] - ISO8601形式のタイムスタンプ (例: 2024-01-01T00:00:00Z).
  @GET(TsunamiApiClientUrls.getV2Tsunami)
  Future<HttpResponse<TsunamiListResponse>> getV2Tsunami({
    @Query('statuses') dynamic statuses = const ['NORMAL'],
    @Query('sortOrder') SortOrder? sortOrder = SortOrder.desc,
    @Query('limit') String? limit,
    @Query('cursor') String? cursor,
    @Query('isCanceled') IsCanceled? isCanceled,
    @Query('createdAtGte') DateTime? createdAtGte,
    @Query('createdAtLte') DateTime? createdAtLte,
  });

  /// DMDATA eventIdから津波情報を取得
  @GET(TsunamiApiClientUrls.getV2TsunamiByEventIdEventId)
  Future<HttpResponse<TsunamiDetailResponse>> getV2TsunamiByEventIdEventId({
    @Path('eventId') required String eventId,
  });

  /// 現在有効な津波情報一覧（VTSE41 の revoke_at が未経過）
  @GET(TsunamiApiClientUrls.getV2TsunamiActive)
  Future<HttpResponse<TsunamiListResponse>> getV2TsunamiActive();

  /// 津波情報詳細
  @GET(TsunamiApiClientUrls.getV2TsunamiTsunamiId)
  Future<HttpResponse<TsunamiDetailResponse>> getV2TsunamiTsunamiId({
    @Path('tsunamiId') required String tsunamiId,
  });
}


abstract class TsunamiApiClientUrls {
	/// /v2/tsunami
	static const getV2Tsunami = "/v2/tsunami";
	/// /v2/tsunami/by-event-id/{eventId}
	static const getV2TsunamiByEventIdEventId = "/v2/tsunami/by-event-id/{eventId}";
	/// /v2/tsunami/active
	static const getV2TsunamiActive = "/v2/tsunami/active";
	/// /v2/tsunami/{tsunamiId}
	static const getV2TsunamiTsunamiId = "/v2/tsunami/{tsunamiId}";
}

