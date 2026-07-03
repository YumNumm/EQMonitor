// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/feed_create_response.dart';
import '../models/feed_detail_response.dart';
import '../models/feed_list_response.dart';
import '../models/v2_feeds_admin_request_body.dart';

import '../models/telegram_status.dart';

part 'feed_api_client.g.dart';

@RestApi()
abstract class FeedApiClient {
  factory FeedApiClient(Dio dio, {String? baseUrl}) = _FeedApiClient;

  /// Feed一覧（お知らせ・地震関連情報など）
  @GET(FeedApiClientUrls.getV2Feeds)
  Future<HttpResponse<FeedListResponse>> getV2Feeds({
    @Query('after') String? after,
    @Query('important') String? important,
    @Query('locale') String? locale = 'ja',
    @Query('limit') String? limit = '20',
    @Query('statuses') List<TelegramStatus> statuses = const [.normal],
  });

  /// 電文ハッシュから Feed を1件取得（通知ディープリンク用）
  @GET(FeedApiClientUrls.getV2FeedsSourceTelegramHash)
  Future<HttpResponse<FeedDetailResponse>> getV2FeedsSourceTelegramHash({
    @Path('telegramHash') required String telegramHash,
    @Query('locale') String? locale = 'ja',
  });

  /// Feed作成（管理者のみ）
  @POST(FeedApiClientUrls.postV2FeedsAdmin)
  Future<HttpResponse<FeedCreateResponse>> postV2FeedsAdmin({
    @Body() required V2FeedsAdminRequestBody body,
  });
}


abstract class FeedApiClientUrls {
	/// /v2/feeds
	static const getV2Feeds = "/v2/feeds";
	/// /v2/feeds/source/{telegramHash}
	static const getV2FeedsSourceTelegramHash = "/v2/feeds/source/{telegramHash}";
	/// /v2/feeds/admin
	static const postV2FeedsAdmin = "/v2/feeds/admin";
}

