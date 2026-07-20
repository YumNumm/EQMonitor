// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_shake_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeShakeEventData _$RealtimeShakeEventDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RealtimeShakeEventData',
  json,
  ($checkedConvert) {
    final val = _RealtimeShakeEventData(
      eventId: $checkedConvert('event_id', (v) => v as String),
      serialNo: $checkedConvert('serial_no', (v) => (v as num).toInt()),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
      expiresAt: $checkedConvert(
        'expires_at',
        (v) => DateTime.parse(v as String),
      ),
      level: $checkedConvert('level', (v) => v as String),
      pointCount: $checkedConvert('point_count', (v) => (v as num).toInt()),
      minLat: $checkedConvert('min_lat', (v) => (v as num).toDouble()),
      maxLat: $checkedConvert('max_lat', (v) => (v as num).toDouble()),
      minLng: $checkedConvert('min_lng', (v) => (v as num).toDouble()),
      maxLng: $checkedConvert('max_lng', (v) => (v as num).toDouble()),
      changeReasons: $checkedConvert(
        'change_reasons',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
      correlatedEewEventId: $checkedConvert(
        'correlated_eew_event_id',
        (v) => v as String?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'serialNo': 'serial_no',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
    'expiresAt': 'expires_at',
    'pointCount': 'point_count',
    'minLat': 'min_lat',
    'maxLat': 'max_lat',
    'minLng': 'min_lng',
    'maxLng': 'max_lng',
    'changeReasons': 'change_reasons',
    'correlatedEewEventId': 'correlated_eew_event_id',
  },
);

Map<String, dynamic> _$RealtimeShakeEventDataToJson(
  _RealtimeShakeEventData instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'serial_no': instance.serialNo,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'expires_at': instance.expiresAt.toIso8601String(),
  'level': instance.level,
  'point_count': instance.pointCount,
  'min_lat': instance.minLat,
  'max_lat': instance.maxLat,
  'min_lng': instance.minLng,
  'max_lng': instance.maxLng,
  'change_reasons': instance.changeReasons,
  'correlated_eew_event_id': instance.correlatedEewEventId,
};

_RealtimeShakeSnapshot _$RealtimeShakeSnapshotFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_RealtimeShakeSnapshot', json, ($checkedConvert) {
  final val = _RealtimeShakeSnapshot(
    revision: $checkedConvert('revision', (v) => (v as num).toInt()),
    responseAt: $checkedConvert(
      'response_at',
      (v) => DateTime.parse(v as String),
    ),
    events: $checkedConvert(
      'events',
      (v) => (v as List<dynamic>)
          .map(
            (e) => RealtimeShakeEventData.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
}, fieldKeyMap: const {'responseAt': 'response_at'});

Map<String, dynamic> _$RealtimeShakeSnapshotToJson(
  _RealtimeShakeSnapshot instance,
) => <String, dynamic>{
  'revision': instance.revision,
  'response_at': instance.responseAt.toIso8601String(),
  'events': instance.events,
};
