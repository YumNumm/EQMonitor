// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

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

  /// テスト通知を送信
  @POST(NotificationApiClientUrls.postV2DeviceMeNotificationTest)
  Future<HttpResponse<TestNotificationResponse>> postV2DeviceMeNotificationTest({
    @Body() required TestNotificationRequest body,
  });
}


abstract class NotificationApiClientUrls {
	/// /v2/device/me/notification/history
	static const getV2DeviceMeNotificationHistory = "/v2/device/me/notification/history";
	/// /v2/device/me/notification/test
	static const postV2DeviceMeNotificationTest = "/v2/device/me/notification/test";
}

