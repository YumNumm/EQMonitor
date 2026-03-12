// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_ticket_response.freezed.dart';
part 'websocket_ticket_response.g.dart';

@Freezed()
abstract class WebsocketTicketResponse with _$WebsocketTicketResponse {
  const factory WebsocketTicketResponse({
    required String ticket,
    @JsonKey(name: 'expires_at')
    required DateTime expiresAt,
  }) = _WebsocketTicketResponse;
  
  factory WebsocketTicketResponse.fromJson(Map<String, Object?> json) => _$WebsocketTicketResponseFromJson(json);
}
