// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'triggers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Triggers _$TriggersFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Triggers',
  json,
  ($checkedConvert) {
    final val = _Triggers(
      id: $checkedConvert('id', (v) => v as String),
      replayFileId: $checkedConvert('replay_file_id', (v) => v as String),
      triggerType: $checkedConvert('trigger_type', (v) => v),
      eventId: $checkedConvert('event_id', (v) => v as String),
      createdAt: $checkedConvert('created_at', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'replayFileId': 'replay_file_id',
    'triggerType': 'trigger_type',
    'eventId': 'event_id',
    'createdAt': 'created_at',
  },
);

Map<String, dynamic> _$TriggersToJson(_Triggers instance) => <String, dynamic>{
  'id': instance.id,
  'replay_file_id': instance.replayFileId,
  'trigger_type': instance.triggerType,
  'event_id': instance.eventId,
  'created_at': instance.createdAt,
};
