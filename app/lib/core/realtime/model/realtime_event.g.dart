// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealtimeReadyEvent _$RealtimeReadyEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RealtimeReadyEvent', json, ($checkedConvert) {
      final val = RealtimeReadyEvent(
        source: $checkedConvert(
          'source',
          (v) => $enumDecode(_$RealtimeSourceEnumMap, v),
        ),
        $type: $checkedConvert('runtimeType', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$RealtimeReadyEventToJson(RealtimeReadyEvent instance) =>
    <String, dynamic>{
      'source': _$RealtimeSourceEnumMap[instance.source]!,
      'runtimeType': instance.$type,
    };

const _$RealtimeSourceEnumMap = {
  RealtimeSource.eqmonitor: 'eqmonitor',
  RealtimeSource.dmdata: 'dmdata',
};

RealtimeEewUpsertEvent _$RealtimeEewUpsertEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RealtimeEewUpsertEvent', json, ($checkedConvert) {
  final val = RealtimeEewUpsertEvent(
    record: $checkedConvert(
      'record',
      (v) => EewItemWithRelations.fromJson(v as Map<String, dynamic>),
    ),
    source: $checkedConvert(
      'source',
      (v) => $enumDecode(_$RealtimeSourceEnumMap, v),
    ),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$RealtimeEewUpsertEventToJson(
  RealtimeEewUpsertEvent instance,
) => <String, dynamic>{
  'record': instance.record,
  'source': _$RealtimeSourceEnumMap[instance.source]!,
  'runtimeType': instance.$type,
};

RealtimeEarthquakeUpsertEvent _$RealtimeEarthquakeUpsertEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RealtimeEarthquakeUpsertEvent', json, ($checkedConvert) {
  final val = RealtimeEarthquakeUpsertEvent(
    record: $checkedConvert(
      'record',
      (v) => Earthquake.fromJson(v as Map<String, dynamic>),
    ),
    source: $checkedConvert(
      'source',
      (v) => $enumDecode(_$RealtimeSourceEnumMap, v),
    ),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$RealtimeEarthquakeUpsertEventToJson(
  RealtimeEarthquakeUpsertEvent instance,
) => <String, dynamic>{
  'record': instance.record,
  'source': _$RealtimeSourceEnumMap[instance.source]!,
  'runtimeType': instance.$type,
};

RealtimeEarthquakeDeleteEvent _$RealtimeEarthquakeDeleteEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'RealtimeEarthquakeDeleteEvent',
  json,
  ($checkedConvert) {
    final val = RealtimeEarthquakeDeleteEvent(
      eventId: $checkedConvert('event_id', (v) => v as String),
      source: $checkedConvert(
        'source',
        (v) => $enumDecode(_$RealtimeSourceEnumMap, v),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'eventId': 'event_id', r'$type': 'runtimeType'},
);

Map<String, dynamic> _$RealtimeEarthquakeDeleteEventToJson(
  RealtimeEarthquakeDeleteEvent instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'source': _$RealtimeSourceEnumMap[instance.source]!,
  'runtimeType': instance.$type,
};

RealtimeTsunamiUpsertEvent _$RealtimeTsunamiUpsertEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'RealtimeTsunamiUpsertEvent',
  json,
  ($checkedConvert) {
    final val = RealtimeTsunamiUpsertEvent(
      eventId: $checkedConvert('event_id', (v) => v as String),
      source: $checkedConvert(
        'source',
        (v) => $enumDecode(_$RealtimeSourceEnumMap, v),
      ),
      groupId: $checkedConvert('group_id', (v) => v as String?),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'groupId': 'group_id',
    r'$type': 'runtimeType',
  },
);

Map<String, dynamic> _$RealtimeTsunamiUpsertEventToJson(
  RealtimeTsunamiUpsertEvent instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'source': _$RealtimeSourceEnumMap[instance.source]!,
  'group_id': instance.groupId,
  'runtimeType': instance.$type,
};

RealtimeTsunamiDeleteEvent _$RealtimeTsunamiDeleteEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'RealtimeTsunamiDeleteEvent',
  json,
  ($checkedConvert) {
    final val = RealtimeTsunamiDeleteEvent(
      eventId: $checkedConvert('event_id', (v) => v as String),
      source: $checkedConvert(
        'source',
        (v) => $enumDecode(_$RealtimeSourceEnumMap, v),
      ),
      groupId: $checkedConvert('group_id', (v) => v as String?),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'groupId': 'group_id',
    r'$type': 'runtimeType',
  },
);

Map<String, dynamic> _$RealtimeTsunamiDeleteEventToJson(
  RealtimeTsunamiDeleteEvent instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'source': _$RealtimeSourceEnumMap[instance.source]!,
  'group_id': instance.groupId,
  'runtimeType': instance.$type,
};

RealtimeShakeSnapshotEvent _$RealtimeShakeSnapshotEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RealtimeShakeSnapshotEvent', json, ($checkedConvert) {
  final val = RealtimeShakeSnapshotEvent(
    record: $checkedConvert(
      'record',
      (v) => RealtimeShakeDetectionSnapshotPayload.fromJson(
        v as Map<String, dynamic>,
      ),
    ),
    source: $checkedConvert(
      'source',
      (v) => $enumDecode(_$RealtimeSourceEnumMap, v),
    ),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$RealtimeShakeSnapshotEventToJson(
  RealtimeShakeSnapshotEvent instance,
) => <String, dynamic>{
  'record': instance.record,
  'source': _$RealtimeSourceEnumMap[instance.source]!,
  'runtimeType': instance.$type,
};

RealtimeEstimatedIntensityUpsertEvent
_$RealtimeEstimatedIntensityUpsertEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RealtimeEstimatedIntensityUpsertEvent',
      json,
      ($checkedConvert) {
        final val = RealtimeEstimatedIntensityUpsertEvent(
          eventId: $checkedConvert('event_id', (v) => v as String),
          estimatedIntensityTile: $checkedConvert(
            'estimated_intensity_tile',
            (v) => v as String,
          ),
          source: $checkedConvert(
            'source',
            (v) => $enumDecode(_$RealtimeSourceEnumMap, v),
          ),
          $type: $checkedConvert('runtimeType', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'estimatedIntensityTile': 'estimated_intensity_tile',
        r'$type': 'runtimeType',
      },
    );

Map<String, dynamic> _$RealtimeEstimatedIntensityUpsertEventToJson(
  RealtimeEstimatedIntensityUpsertEvent instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'estimated_intensity_tile': instance.estimatedIntensityTile,
  'source': _$RealtimeSourceEnumMap[instance.source]!,
  'runtimeType': instance.$type,
};
