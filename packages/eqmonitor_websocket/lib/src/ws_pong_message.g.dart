// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_pong_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WsPongMessage _$WsPongMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_WsPongMessage', json, ($checkedConvert) {
      final val = _WsPongMessage(
        type: $checkedConvert('type', (v) => v as String? ?? 'pong'),
      );
      return val;
    });

Map<String, dynamic> _$WsPongMessageToJson(_WsPongMessage instance) =>
    <String, dynamic>{'type': instance.type};
