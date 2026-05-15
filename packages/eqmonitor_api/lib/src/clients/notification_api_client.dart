// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/dispatch_summary_detail_response.dart';
import '../models/dispatch_summary_list_response.dart';
import '../models/notification_history_response.dart';
import '../models/test_notification_request.dart';
import '../models/test_notification_response.dart';

part 'notification_api_client.g.dart';

@RestApi()
abstract class NotificationApiClient {
  factory NotificationApiClient(Dio dio, {String? baseUrl}) = _NotificationApiClient;

  /// デバイスの通知履歴を取得
  @GET(NotificationApiClientUrls.getV2DeviceMeNotificationHistory)
  Future<HttpResponse<NotificationHistoryResponse>> getV2DeviceMeNotificationHistory({
    @Query('cursor') String? cursor,
    @Query('limit') int? limit = 100,
  });

  /// 配信サマリー一覧（admin）
  @GET(NotificationApiClientUrls.getV2DeviceMeNotificationDispatches)
  Future<HttpResponse<DispatchSummaryListResponse>> getV2DeviceMeNotificationDispatches();

  /// 配信サマリー詳細（admin）
  @GET(NotificationApiClientUrls.getV2DeviceMeNotificationDispatchesCorrelationKey)
  Future<HttpResponse<DispatchSummaryDetailResponse>> getV2DeviceMeNotificationDispatchesCorrelationKey({
    @Path('correlationKey') required String correlationKey,
  });

  /// テスト通知を送信
  @POST(NotificationApiClientUrls.postV2DeviceMeNotificationTest)
  Future<HttpResponse<TestNotificationResponse>> postV2DeviceMeNotificationTest({
    @Body() required TestNotificationRequest body,
  });
}


abstract class NotificationApiClientUrls {
	/// /v2/device/me/notification/history
	static const getV2DeviceMeNotificationHistory = "/v2/device/me/notification/history";
	/// /v2/device/me/notification/dispatches
	static const getV2DeviceMeNotificationDispatches = "/v2/device/me/notification/dispatches";
	/// /v2/device/me/notification/dispatches/{correlationKey}
	static const getV2DeviceMeNotificationDispatchesCorrelationKey = "/v2/device/me/notification/dispatches/{correlationKey}";
	/// /v2/device/me/notification/test
	static const postV2DeviceMeNotificationTest = "/v2/device/me/notification/test";
}

