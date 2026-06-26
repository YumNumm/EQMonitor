// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telemetry_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelemetryEvent _$TelemetryEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TelemetryEvent',
  json,
  ($checkedConvert) {
    final val = _TelemetryEvent(
      eventType: $checkedConvert('event_type', (v) => v as String),
      timestampMs: $checkedConvert('timestamp_ms', (v) => (v as num).toInt()),
      eventId: $checkedConvert('event_id', (v) => v as String?),
      payload: $checkedConvert('payload', (v) => v as String?),
      createdAtMs: $checkedConvert('created_at_ms', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventType': 'event_type',
    'timestampMs': 'timestamp_ms',
    'eventId': 'event_id',
    'createdAtMs': 'created_at_ms',
  },
);

Map<String, dynamic> _$TelemetryEventToJson(_TelemetryEvent instance) =>
    <String, dynamic>{
      'event_type': instance.eventType,
      'timestamp_ms': instance.timestampMs,
      'event_id': instance.eventId,
      'payload': instance.payload,
      'created_at_ms': instance.createdAtMs,
    };
