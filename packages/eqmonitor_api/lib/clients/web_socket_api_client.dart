// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/websocket_ticket_response.dart';

part 'web_socket_api_client.g.dart';

@RestApi()
abstract class WebSocketApiClient {
  factory WebSocketApiClient(Dio dio, {String? baseUrl}) = _WebSocketApiClient;

  /// WebSocket接続用のチケットを発行
  @GET(WebSocketApiClientUrls.getV2WebsocketTicket)
  Future<HttpResponse<WebsocketTicketResponse>> getV2WebsocketTicket();
}

abstract class WebSocketApiClientUrls {
  /// /v2/websocket/ticket
  static const getV2WebsocketTicket = "/v2/websocket/ticket";
}
