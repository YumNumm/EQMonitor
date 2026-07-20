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
      operation: $checkedConvert(
        'operation',
        (v) => $enumDecode(_$WsRealtimeOperationEnumMap, v),
      ),
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
  'operation': _$WsRealtimeOperationEnumMap[instance.operation]!,
  'event_id': instance.eventId,
  'record': instance.record,
  'type': instance.$type,
};

const _$WsRealtimeOperationEnumMap = {
  WsRealtimeOperation.upsert: 'upsert',
  WsRealtimeOperation.delete: 'delete',
};

WsTsunamiRealtimeEvent _$WsTsunamiRealtimeEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'WsTsunamiRealtimeEvent',
  json,
  ($checkedConvert) {
    final val = WsTsunamiRealtimeEvent(
      operation: $checkedConvert(
        'operation',
        (v) => $enumDecode(_$WsRealtimeOperationEnumMap, v),
      ),
      eventId: $checkedConvert('event_id', (v) => v as String),
      groupId: $checkedConvert('group_id', (v) => v as String?),
      record: $checkedConvert('record', (v) => v as Map<String, dynamic>?),
      $type: $checkedConvert('type', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'groupId': 'group_id',
    r'$type': 'type',
  },
);

Map<String, dynamic> _$WsTsunamiRealtimeEventToJson(
  WsTsunamiRealtimeEvent instance,
) => <String, dynamic>{
  'operation': _$WsRealtimeOperationEnumMap[instance.operation]!,
  'event_id': instance.eventId,
  'group_id': instance.groupId,
  'record': instance.record,
  'type': instance.$type,
};

WsShakeDetectionRealtimeEvent _$WsShakeDetectionRealtimeEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WsShakeDetectionRealtimeEvent', json, ($checkedConvert) {
  final val = WsShakeDetectionRealtimeEvent(
    revision: $checkedConvert('revision', (v) => (v as num).toInt()),
    responseAt: $checkedConvert(
      'responseAt',
      (v) => DateTime.parse(v as String),
    ),
    events: $checkedConvert(
      'events',
      (v) => (v as List<dynamic>)
          .map((e) => WsShakeDetectionEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$WsShakeDetectionRealtimeEventToJson(
  WsShakeDetectionRealtimeEvent instance,
) => <String, dynamic>{
  'revision': instance.revision,
  'responseAt': instance.responseAt.toIso8601String(),
  'events': instance.events,
  'type': instance.$type,
};

WsEstimatedIntensityRealtimeEvent _$WsEstimatedIntensityRealtimeEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WsEstimatedIntensityRealtimeEvent', json, (
  $checkedConvert,
) {
  final val = WsEstimatedIntensityRealtimeEvent(
    estimatedIntensity: $checkedConvert(
      'estimatedIntensity',
      (v) => WsEstimatedIntensityPayload.fromJson(v as Map<String, dynamic>),
    ),
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$WsEstimatedIntensityRealtimeEventToJson(
  WsEstimatedIntensityRealtimeEvent instance,
) => <String, dynamic>{
  'estimatedIntensity': instance.estimatedIntensity,
  'type': instance.$type,
};
