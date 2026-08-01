// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_earthquake_upsert_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeEarthquakeUpsertPayload _$RealtimeEarthquakeUpsertPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RealtimeEarthquakeUpsertPayload',
  json,
  ($checkedConvert) {
    final val = _RealtimeEarthquakeUpsertPayload(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$RealtimeEarthquakeUpsertPayloadTypeEnumMap, v),
      ),
      operation: $checkedConvert(
        'operation',
        (v) =>
            $enumDecode(_$RealtimeEarthquakeUpsertPayloadOperationEnumMap, v),
      ),
      eventId: $checkedConvert('event_id', (v) => v as String),
      record: $checkedConvert(
        'record',
        (v) => Earthquake.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'eventId': 'event_id'},
);

Map<String, dynamic> _$RealtimeEarthquakeUpsertPayloadToJson(
  _RealtimeEarthquakeUpsertPayload instance,
) => <String, dynamic>{
  'type': instance.type,
  'operation': instance.operation,
  'event_id': instance.eventId,
  'record': instance.record,
};

const _$RealtimeEarthquakeUpsertPayloadTypeEnumMap = {
  RealtimeEarthquakeUpsertPayloadType.earthquake: 'earthquake',
};

const _$RealtimeEarthquakeUpsertPayloadOperationEnumMap = {
  RealtimeEarthquakeUpsertPayloadOperation.upsert: 'upsert',
};
