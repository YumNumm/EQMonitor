// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_earthquake_delete_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeEarthquakeDeletePayload _$RealtimeEarthquakeDeletePayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RealtimeEarthquakeDeletePayload',
  json,
  ($checkedConvert) {
    final val = _RealtimeEarthquakeDeletePayload(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$RealtimeEarthquakeDeletePayloadTypeEnumMap, v),
      ),
      operation: $checkedConvert(
        'operation',
        (v) =>
            $enumDecode(_$RealtimeEarthquakeDeletePayloadOperationEnumMap, v),
      ),
      eventId: $checkedConvert('event_id', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {'eventId': 'event_id'},
);

Map<String, dynamic> _$RealtimeEarthquakeDeletePayloadToJson(
  _RealtimeEarthquakeDeletePayload instance,
) => <String, dynamic>{
  'type': instance.type,
  'operation': instance.operation,
  'event_id': instance.eventId,
};

const _$RealtimeEarthquakeDeletePayloadTypeEnumMap = {
  RealtimeEarthquakeDeletePayloadType.earthquake: 'earthquake',
};

const _$RealtimeEarthquakeDeletePayloadOperationEnumMap = {
  RealtimeEarthquakeDeletePayloadOperation.delete: 'delete',
};
