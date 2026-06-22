// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/is_active.dart';
import '../models/is_canceled.dart';
import '../models/sort_order.dart';
import '../models/tsunami_list_response.dart';
import '../models/tsunami_state.dart';
import '../models/tsunami_telegrams_response.dart';

import '../models/telegram_status.dart';

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
  /// [isActive] - アクティブ状態フィルタ.
  ///
  /// [createdAtGte] - ISO8601形式のタイムスタンプ (例: 2024-01-01T00:00:00Z).
  ///
  /// [createdAtLte] - ISO8601形式のタイムスタンプ (例: 2024-01-01T00:00:00Z).
  @GET(TsunamiApiClientUrls.getV2Tsunami)
  Future<HttpResponse<TsunamiListResponse>> getV2Tsunami({
    @Query('statuses') List<TelegramStatus> statuses = const [.normal],
    @Query('sortOrder') SortOrder? sortOrder = SortOrder.desc,
    @Query('limit') String? limit,
    @Query('cursor') String? cursor,
    @Query('isCanceled') IsCanceled? isCanceled,
    @Query('isActive') IsActive? isActive,
    @Query('createdAtGte') DateTime? createdAtGte,
    @Query('createdAtLte') DateTime? createdAtLte,
  });

  /// DMDATA eventIdから津波情報を取得
  @GET(TsunamiApiClientUrls.getV2TsunamiByEventIdEventId)
  Future<HttpResponse<TsunamiState>> getV2TsunamiByEventIdEventId({
    @Path('eventId') required String eventId,
  });

  /// 津波情報の電文履歴（pressed_at 降順）
  @GET(TsunamiApiClientUrls.getV2TsunamiTsunamiIdTelegrams)
  Future<HttpResponse<TsunamiTelegramsResponse>> getV2TsunamiTsunamiIdTelegrams({
    @Path('tsunamiId') required String tsunamiId,
  });

  /// 津波情報詳細（マージ済み状態）
  @GET(TsunamiApiClientUrls.getV2TsunamiTsunamiId)
  Future<HttpResponse<TsunamiState>> getV2TsunamiTsunamiId({
    @Path('tsunamiId') required String tsunamiId,
  });
}


abstract class TsunamiApiClientUrls {
	/// /v2/tsunami
	static const getV2Tsunami = "/v2/tsunami";
	/// /v2/tsunami/by-event-id/{eventId}
	static const getV2TsunamiByEventIdEventId = "/v2/tsunami/by-event-id/{eventId}";
	/// /v2/tsunami/{tsunamiId}/telegrams
	static const getV2TsunamiTsunamiIdTelegrams = "/v2/tsunami/{tsunamiId}/telegrams";
	/// /v2/tsunami/{tsunamiId}
	static const getV2TsunamiTsunamiId = "/v2/tsunami/{tsunamiId}";
}

