// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_tsunami_upsert_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeTsunamiUpsertPayload _$RealtimeTsunamiUpsertPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_RealtimeTsunamiUpsertPayload', json, ($checkedConvert) {
  final val = _RealtimeTsunamiUpsertPayload(
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$RealtimeTsunamiUpsertPayloadTypeEnumMap, v),
    ),
    operation: $checkedConvert(
      'operation',
      (v) => $enumDecode(_$RealtimeTsunamiUpsertPayloadOperationEnumMap, v),
    ),
    eventId: $checkedConvert('event_id', (v) => v as String),
    groupId: $checkedConvert('group_id', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id', 'groupId': 'group_id'});

Map<String, dynamic> _$RealtimeTsunamiUpsertPayloadToJson(
  _RealtimeTsunamiUpsertPayload instance,
) => <String, dynamic>{
  'type': instance.type,
  'operation': instance.operation,
  'event_id': instance.eventId,
  'group_id': ?instance.groupId,
};

const _$RealtimeTsunamiUpsertPayloadTypeEnumMap = {
  RealtimeTsunamiUpsertPayloadType.tsunami: 'tsunami',
};

const _$RealtimeTsunamiUpsertPayloadOperationEnumMap = {
  RealtimeTsunamiUpsertPayloadOperation.upsert: 'upsert',
};
