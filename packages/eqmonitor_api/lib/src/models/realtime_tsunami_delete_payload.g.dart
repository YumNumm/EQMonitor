// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_tsunami_delete_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeTsunamiDeletePayload _$RealtimeTsunamiDeletePayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RealtimeTsunamiDeletePayload',
  json,
  ($checkedConvert) {
    final val = _RealtimeTsunamiDeletePayload(
      type: $checkedConvert('type', (v) => $enumDecode(_$Type4EnumMap, v)),
      operation: $checkedConvert(
        'operation',
        (v) => $enumDecode(_$Operation2EnumMap, v),
      ),
      eventId: $checkedConvert('event_id', (v) => v as String),
      groupId: $checkedConvert('group_id', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'eventId': 'event_id', 'groupId': 'group_id'},
);

Map<String, dynamic> _$RealtimeTsunamiDeletePayloadToJson(
  _RealtimeTsunamiDeletePayload instance,
) => <String, dynamic>{
  'type': instance.type,
  'operation': instance.operation,
  'event_id': instance.eventId,
  'group_id': ?instance.groupId,
};

const _$Type4EnumMap = {Type4.tsunami: 'tsunami'};

const _$Operation2EnumMap = {Operation2.delete: 'delete'};
