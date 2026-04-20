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
  factory NotificationApiClient(Dio dio, {String? baseUrl}) =
      _NotificationApiClient;

  /// デバイスの通知履歴を取得
  @GET(NotificationApiClientUrls.getV2DeviceDeviceIdNotificationHistory)
  Future<HttpResponse<NotificationHistoryResponse>>
  getV2DeviceDeviceIdNotificationHistory({
    @Path('deviceId') required String deviceId,
    @Query('cursor') String? cursor,
    @Query('limit') int? limit = 100,
  });

  /// 配信サマリー一覧（admin）
  @GET(NotificationApiClientUrls.getV2DeviceDeviceIdNotificationDispatches)
  Future<HttpResponse<DispatchSummaryListResponse>>
  getV2DeviceDeviceIdNotificationDispatches({
    @Path('deviceId') required String deviceId,
  });

  /// 配信サマリー詳細（admin）
  @GET(
    NotificationApiClientUrls
        .getV2DeviceDeviceIdNotificationDispatchesCorrelationKey,
  )
  Future<HttpResponse<DispatchSummaryDetailResponse>>
  getV2DeviceDeviceIdNotificationDispatchesCorrelationKey({
    @Path('deviceId') required String deviceId,
    @Path('correlationKey') required String correlationKey,
  });

  /// テスト通知を送信
  @POST(NotificationApiClientUrls.postV2DeviceDeviceIdNotificationTest)
  Future<HttpResponse<TestNotificationResponse>>
  postV2DeviceDeviceIdNotificationTest({
    @Path('deviceId') required String deviceId,
    @Body() required TestNotificationRequest body,
  });
}

abstract class NotificationApiClientUrls {
  /// /v2/device/{deviceId}/notification/history
  static const getV2DeviceDeviceIdNotificationHistory =
      "/v2/device/{deviceId}/notification/history";

  /// /v2/device/{deviceId}/notification/dispatches
  static const getV2DeviceDeviceIdNotificationDispatches =
      "/v2/device/{deviceId}/notification/dispatches";

  /// /v2/device/{deviceId}/notification/dispatches/{correlationKey}
  static const getV2DeviceDeviceIdNotificationDispatchesCorrelationKey =
      "/v2/device/{deviceId}/notification/dispatches/{correlationKey}";

  /// /v2/device/{deviceId}/notification/test
  static const postV2DeviceDeviceIdNotificationTest =
      "/v2/device/{deviceId}/notification/test";
}
