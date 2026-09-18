// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_client_ping_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WsClientPingMessage _$WsClientPingMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_WsClientPingMessage', json, ($checkedConvert) {
      final val = _WsClientPingMessage(
        pingId: $checkedConvert('pingId', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String? ?? 'ping'),
      );
      return val;
    });

Map<String, dynamic> _$WsClientPingMessageToJson(
  _WsClientPingMessage instance,
) => <String, dynamic>{'pingId': instance.pingId, 'type': instance.type};
