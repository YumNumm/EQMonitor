// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_file_trigger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReplayFileTrigger _$ReplayFileTriggerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ReplayFileTrigger', json, ($checkedConvert) {
      final val = _ReplayFileTrigger(
        id: $checkedConvert('id', (v) => v as String),
        replayFileId: $checkedConvert('replayFileId', (v) => v as String),
        triggerType: $checkedConvert(
          'triggerType',
          (v) => $enumDecode(_$TriggerTypeEnumMap, v),
        ),
        eventId: $checkedConvert('eventId', (v) => v as String),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ReplayFileTriggerToJson(_ReplayFileTrigger instance) =>
    <String, dynamic>{
      'id': instance.id,
      'replayFileId': instance.replayFileId,
      'triggerType': instance.triggerType,
      'eventId': instance.eventId,
      'createdAt': instance.createdAt,
    };

const _$TriggerTypeEnumMap = {
  TriggerType.shakeDetection: 'SHAKE_DETECTION',
  TriggerType.earthquake: 'EARTHQUAKE',
};
