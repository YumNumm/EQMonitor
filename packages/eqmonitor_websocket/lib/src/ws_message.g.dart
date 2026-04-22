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
