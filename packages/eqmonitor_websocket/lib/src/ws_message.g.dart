// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsSnapshotMessage _$WsSnapshotMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WsSnapshotMessage', json, ($checkedConvert) {
      final val = WsSnapshotMessage(
        data: $checkedConvert(
          'data',
          (v) => WsSnapshotData.fromJson(v as Map<String, dynamic>),
        ),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$WsSnapshotMessageToJson(WsSnapshotMessage instance) =>
    <String, dynamic>{'data': instance.data, 'type': instance.$type};

WsRealtimeMessage _$WsRealtimeMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WsRealtimeMessage', json, ($checkedConvert) {
      final val = WsRealtimeMessage(
        data: $checkedConvert(
          'data',
          (v) => RealtimeEventEnvelope.fromJson(v as Map<String, dynamic>),
        ),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$WsRealtimeMessageToJson(WsRealtimeMessage instance) =>
    <String, dynamic>{'data': instance.data, 'type': instance.$type};

WsPingMessage _$WsPingMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WsPingMessage', json, ($checkedConvert) {
      final val = WsPingMessage(
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$WsPingMessageToJson(WsPingMessage instance) =>
    <String, dynamic>{'type': instance.$type};

WsReadyMessage _$WsReadyMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WsReadyMessage', json, ($checkedConvert) {
      final val = WsReadyMessage(
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$WsReadyMessageToJson(WsReadyMessage instance) =>
    <String, dynamic>{'type': instance.$type};
