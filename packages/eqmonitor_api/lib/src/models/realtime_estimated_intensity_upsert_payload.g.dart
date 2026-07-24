// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_estimated_intensity_upsert_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeEstimatedIntensityUpsertPayload
_$RealtimeEstimatedIntensityUpsertPayloadFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_RealtimeEstimatedIntensityUpsertPayload',
      json,
      ($checkedConvert) {
        final val = _RealtimeEstimatedIntensityUpsertPayload(
          type: $checkedConvert('type', (v) => $enumDecode(_$Type5EnumMap, v)),
          operation: $checkedConvert(
            'operation',
            (v) => $enumDecode(_$OperationEnumMap, v),
          ),
          eventId: $checkedConvert('event_id', (v) => v as String),
          record: $checkedConvert(
            'record',
            (v) => EstimatedIntensityEvent.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'eventId': 'event_id'},
    );

Map<String, dynamic> _$RealtimeEstimatedIntensityUpsertPayloadToJson(
  _RealtimeEstimatedIntensityUpsertPayload instance,
) => <String, dynamic>{
  'type': instance.type,
  'operation': instance.operation,
  'event_id': instance.eventId,
  'record': instance.record,
};

const _$Type5EnumMap = {Type5.estimatedIntensity: 'estimated_intensity'};

const _$OperationEnumMap = {Operation.upsert: 'upsert'};
