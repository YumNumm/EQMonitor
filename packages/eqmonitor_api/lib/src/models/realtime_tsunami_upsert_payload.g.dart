// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_tsunami_upsert_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeTsunamiUpsertPayload _$RealtimeTsunamiUpsertPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RealtimeTsunamiUpsertPayload',
  json,
  ($checkedConvert) {
    final val = _RealtimeTsunamiUpsertPayload(
      type: $checkedConvert('type', (v) => $enumDecode(_$Type4EnumMap, v)),
      operation: $checkedConvert(
        'operation',
        (v) => $enumDecode(_$OperationEnumMap, v),
      ),
      eventId: $checkedConvert('event_id', (v) => v as String),
      groupId: $checkedConvert('group_id', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'eventId': 'event_id', 'groupId': 'group_id'},
);

Map<String, dynamic> _$RealtimeTsunamiUpsertPayloadToJson(
  _RealtimeTsunamiUpsertPayload instance,
) => <String, dynamic>{
  'type': instance.type,
  'operation': instance.operation,
  'event_id': instance.eventId,
  'group_id': ?instance.groupId,
};

const _$Type4EnumMap = {Type4.tsunami: 'tsunami'};

const _$OperationEnumMap = {Operation.upsert: 'upsert'};
