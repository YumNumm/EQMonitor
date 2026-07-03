// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/notification_history_response.dart';
import '../models/test_notification_request.dart';
import '../models/test_notification_response.dart';
import '../models/test_scenario_request.dart';
import '../models/test_scenario_response.dart';
import '../models/test_scenario_type_request.dart';
import '../models/test_scenario_type_response.dart';

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

  /// 指定したイベントIDの実データをDBから取得し、実際の通知パイプラインを通してこのデバイスにのみ通知を配信する（EEW + VXSE51/52/53）
  @POST(NotificationApiClientUrls.postV2DeviceMeNotificationTestScenario)
  Future<HttpResponse<TestScenarioResponse>> postV2DeviceMeNotificationTestScenario({
    @Body() required TestScenarioRequest body,
  });

  /// シナリオを指定してテスト通知を送信。通知パイプラインを通してメッセージを生成し、[テスト/TEST] プレフィックス付きでこのデバイスにのみ配信する
  @POST(NotificationApiClientUrls.postV2DeviceMeNotificationTestScenarioType)
  Future<HttpResponse<TestScenarioTypeResponse>> postV2DeviceMeNotificationTestScenarioType({
    @Body() required TestScenarioTypeRequest body,
  });
}


abstract class NotificationApiClientUrls {
	/// /v2/device/me/notification/history
	static const getV2DeviceMeNotificationHistory = "/v2/device/me/notification/history";
	/// /v2/device/me/notification/test
	static const postV2DeviceMeNotificationTest = "/v2/device/me/notification/test";
	/// /v2/device/me/notification/test-scenario
	static const postV2DeviceMeNotificationTestScenario = "/v2/device/me/notification/test-scenario";
	/// /v2/device/me/notification/test-scenario-type
	static const postV2DeviceMeNotificationTestScenarioType = "/v2/device/me/notification/test-scenario-type";
}

