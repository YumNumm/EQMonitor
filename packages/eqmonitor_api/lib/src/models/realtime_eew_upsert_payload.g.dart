// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_eew_upsert_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeEewUpsertPayload _$RealtimeEewUpsertPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_RealtimeEewUpsertPayload', json, ($checkedConvert) {
  final val = _RealtimeEewUpsertPayload(
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$RealtimeEewUpsertPayloadTypeEnumMap, v),
    ),
    operation: $checkedConvert(
      'operation',
      (v) => $enumDecode(_$RealtimeEewUpsertPayloadOperationEnumMap, v),
    ),
    eventId: $checkedConvert('event_id', (v) => v as String),
    record: $checkedConvert(
      'record',
      (v) => EewItemWithRelations.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$RealtimeEewUpsertPayloadToJson(
  _RealtimeEewUpsertPayload instance,
) => <String, dynamic>{
  'type': instance.type,
  'operation': instance.operation,
  'event_id': instance.eventId,
  'record': instance.record,
};

const _$RealtimeEewUpsertPayloadTypeEnumMap = {
  RealtimeEewUpsertPayloadType.eew: 'eew',
};

const _$RealtimeEewUpsertPayloadOperationEnumMap = {
  RealtimeEewUpsertPayloadOperation.upsert: 'upsert',
};
