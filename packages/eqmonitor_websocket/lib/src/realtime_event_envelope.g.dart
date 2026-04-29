// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_event_envelope.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsEewRealtimeEvent _$WsEewRealtimeEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WsEewRealtimeEvent', json, ($checkedConvert) {
      final val = WsEewRealtimeEvent(
        item: $checkedConvert(
          'item',
          (v) => EewItemWithRelations.fromJson(v as Map<String, dynamic>),
        ),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$WsEewRealtimeEventToJson(WsEewRealtimeEvent instance) =>
    <String, dynamic>{'item': instance.item, 'type': instance.$type};

WsEarthquakeBroadcastEvent _$WsEarthquakeBroadcastEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WsEarthquakeBroadcastEvent', json, ($checkedConvert) {
  final val = WsEarthquakeBroadcastEvent(
    item: $checkedConvert(
      'item',
      (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
    ),
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$WsEarthquakeBroadcastEventToJson(
  WsEarthquakeBroadcastEvent instance,
) => <String, dynamic>{'item': instance.item, 'type': instance.$type};

WsEarthquakeRealtimeEvent _$WsEarthquakeRealtimeEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'WsEarthquakeRealtimeEvent',
  json,
  ($checkedConvert) {
    final val = WsEarthquakeRealtimeEvent(
      operation: $checkedConvert('operation', (v) => v as String),
      eventId: $checkedConvert('event_id', (v) => v as String),
      record: $checkedConvert(
        'record',
        (v) => v == null
            ? null
            : EarthquakePartial.fromJson(v as Map<String, dynamic>),
      ),
      $type: $checkedConvert('type', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'eventId': 'event_id', r'$type': 'type'},
);

Map<String, dynamic> _$WsEarthquakeRealtimeEventToJson(
  WsEarthquakeRealtimeEvent instance,
) => <String, dynamic>{
  'operation': instance.operation,
  'event_id': instance.eventId,
  'record': instance.record,
  'type': instance.$type,
};

WsTsunamiRealtimeEvent _$WsTsunamiRealtimeEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'WsTsunamiRealtimeEvent',
  json,
  ($checkedConvert) {
    final val = WsTsunamiRealtimeEvent(
      operation: $checkedConvert('operation', (v) => v as String),
      eventId: $checkedConvert('event_id', (v) => v as String),
      record: $checkedConvert('record', (v) => v as Map<String, dynamic>?),
      $type: $checkedConvert('type', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'eventId': 'event_id', r'$type': 'type'},
);

Map<String, dynamic> _$WsTsunamiRealtimeEventToJson(
  WsTsunamiRealtimeEvent instance,
) => <String, dynamic>{
  'operation': instance.operation,
  'event_id': instance.eventId,
  'record': instance.record,
  'type': instance.$type,
};

WsShakeDetectedRealtimeEvent _$WsShakeDetectedRealtimeEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WsShakeDetectedRealtimeEvent', json, ($checkedConvert) {
  final val = WsShakeDetectedRealtimeEvent(
    eventId: $checkedConvert('eventId', (v) => v as String),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    level: $checkedConvert('level', (v) => v as String),
    changeReasons: $checkedConvert(
      'changeReasons',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    ),
    isReplay: $checkedConvert('isReplay', (v) => v as bool),
    pointCount: $checkedConvert('pointCount', (v) => (v as num).toInt()),
    region: $checkedConvert(
      'region',
      (v) => WsShakeRegionPayload.fromJson(v as Map<String, dynamic>),
    ),
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$WsShakeDetectedRealtimeEventToJson(
  WsShakeDetectedRealtimeEvent instance,
) => <String, dynamic>{
  'eventId': instance.eventId,
  'createdAt': instance.createdAt.toIso8601String(),
  'level': instance.level,
  'changeReasons': instance.changeReasons,
  'isReplay': instance.isReplay,
  'pointCount': instance.pointCount,
  'region': instance.region,
  'type': instance.$type,
};

WsEstimatedIntensityRealtimeEvent _$WsEstimatedIntensityRealtimeEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WsEstimatedIntensityRealtimeEvent', json, (
  $checkedConvert,
) {
  final val = WsEstimatedIntensityRealtimeEvent(
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$WsEstimatedIntensityRealtimeEventToJson(
  WsEstimatedIntensityRealtimeEvent instance,
) => <String, dynamic>{'type': instance.$type};
