// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_client_pong_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WsClientPongMessage _$WsClientPongMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_WsClientPongMessage', json, ($checkedConvert) {
      final val = _WsClientPongMessage(
        type: $checkedConvert('type', (v) => v as String? ?? 'pong'),
      );
      return val;
    });

Map<String, dynamic> _$WsClientPongMessageToJson(
  _WsClientPongMessage instance,
) => <String, dynamic>{'type': instance.type};
