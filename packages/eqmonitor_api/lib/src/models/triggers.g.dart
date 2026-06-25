// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'triggers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Triggers _$TriggersFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Triggers', json, ($checkedConvert) {
      final val = _Triggers(
        id: $checkedConvert('id', (v) => v as String),
        replayFileId: $checkedConvert('replayFileId', (v) => v as String),
        triggerType: $checkedConvert('triggerType', (v) => v as String),
        eventId: $checkedConvert('eventId', (v) => v as String),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$TriggersToJson(_Triggers instance) => <String, dynamic>{
  'id': instance.id,
  'replayFileId': instance.replayFileId,
  'triggerType': instance.triggerType,
  'eventId': instance.eventId,
  'createdAt': instance.createdAt,
};
