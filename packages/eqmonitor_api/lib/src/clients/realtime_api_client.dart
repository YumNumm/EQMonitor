// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/realtime_ticket_response.dart';

part 'realtime_api_client.g.dart';

@RestApi()
abstract class RealtimeApiClient {
  factory RealtimeApiClient(Dio dio, {String? baseUrl}) = _RealtimeApiClient;

  /// WebSocket 接続用チケット（JWT）を発行する。x-eqmonitor-device-id ヘッダーが必要。
  @GET(RealtimeApiClientUrls.getV2RealtimeTicket)
  Future<HttpResponse<RealtimeTicketResponse>> getV2RealtimeTicket();

  /// WebSocket 配信型を OpenAPI に公開するための mock endpoint
  @GET(RealtimeApiClientUrls.getV2RealtimeExample)
  Future<HttpResponse<void>> getV2RealtimeExample();
}


abstract class RealtimeApiClientUrls {
	/// /v2/realtime/ticket
	static const getV2RealtimeTicket = "/v2/realtime/ticket";
	/// /v2/realtime/example
	static const getV2RealtimeExample = "/v2/realtime/example";
}
