// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/telemetry_events_request.dart';
import '../models/telemetry_events_response.dart';

part 'telemetry_api_client.g.dart';

@RestApi()
abstract class TelemetryApiClient {
  factory TelemetryApiClient(Dio dio, {String? baseUrl}) = _TelemetryApiClient;

  /// クライアント側テレメトリイベントをバッチで受信
  @POST(TelemetryApiClientUrls.postV2DeviceMeTelemetryEvents)
  Future<HttpResponse<TelemetryEventsResponse>> postV2DeviceMeTelemetryEvents({
    @Body() required TelemetryEventsRequest body,
  });
}


abstract class TelemetryApiClientUrls {
	/// /v2/device/me/telemetry/events
	static const postV2DeviceMeTelemetryEvents = "/v2/device/me/telemetry/events";
}

