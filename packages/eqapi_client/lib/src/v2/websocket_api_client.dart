import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:retrofit/retrofit.dart';

part 'websocket_api_client.g.dart';

/// WebSocket API
@RestApi()
abstract class WebsocketApiClient {
  factory WebsocketApiClient(Dio dio, {String baseUrl}) = _WebsocketApiClient;

  /// WebSocket接続用のチケットを発行
  @GET('/v2/websocket/ticket')
  Future<WebsocketTicketResponse> getTicket();
}
