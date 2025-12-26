import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_ticket.freezed.dart';
part 'websocket_ticket.g.dart';

/// WebSocket接続用チケットレスポンス
@freezed
abstract class WebsocketTicketResponse with _$WebsocketTicketResponse {
  const factory WebsocketTicketResponse({
    required String ticket,
    required DateTime expiresAt,
  }) = _WebsocketTicketResponse;

  factory WebsocketTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$WebsocketTicketResponseFromJson(json);
}
