// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'websocket_ticket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WebsocketTicketResponse _$WebsocketTicketResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WebsocketTicketResponse', json, ($checkedConvert) {
  final val = _WebsocketTicketResponse(
    ticket: $checkedConvert('ticket', (v) => v as String),
    expiresAt: $checkedConvert(
      'expires_at',
      (v) => DateTime.parse(v as String),
    ),
  );
  return val;
}, fieldKeyMap: const {'expiresAt': 'expires_at'});

Map<String, dynamic> _$WebsocketTicketResponseToJson(
  _WebsocketTicketResponse instance,
) => <String, dynamic>{
  'ticket': instance.ticket,
  'expires_at': instance.expiresAt.toIso8601String(),
};
