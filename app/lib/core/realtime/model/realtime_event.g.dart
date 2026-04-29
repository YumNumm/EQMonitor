// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealtimeSnapshotEvent _$RealtimeSnapshotEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RealtimeSnapshotEvent', json, ($checkedConvert) {
  final val = RealtimeSnapshotEvent(
    eews: $checkedConvert(
      'eews',
      (v) => (v as List<dynamic>)
          .map((e) => EewItemWithRelations.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    earthquakes: $checkedConvert(
      'earthquakes',
      (v) => (v as List<dynamic>)
          .map((e) => EarthquakePartial.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    shakes: $checkedConvert(
      'shakes',
      (v) => (v as List<dynamic>)
          .map((e) => RealtimeShakeData.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    source: $checkedConvert(
      'source',
      (v) => $enumDecode(_$RealtimeSourceEnumMap, v),
    ),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$RealtimeSnapshotEventToJson(
  RealtimeSnapshotEvent instance,
) => <String, dynamic>{
  'eews': instance.eews,
  'earthquakes': instance.earthquakes,
  'shakes': instance.shakes,
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
    item: $checkedConvert(
      'item',
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
  'item': instance.item,
  'source': _$RealtimeSourceEnumMap[instance.source]!,
  'runtimeType': instance.$type,
};

RealtimeEarthquakeUpsertEvent _$RealtimeEarthquakeUpsertEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RealtimeEarthquakeUpsertEvent', json, ($checkedConvert) {
  final val = RealtimeEarthquakeUpsertEvent(
    record: $checkedConvert(
      'record',
      (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
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

RealtimeShakeDetectedEvent _$RealtimeShakeDetectedEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RealtimeShakeDetectedEvent', json, ($checkedConvert) {
  final val = RealtimeShakeDetectedEvent(
    data: $checkedConvert(
      'data',
      (v) => RealtimeShakeData.fromJson(v as Map<String, dynamic>),
    ),
    source: $checkedConvert(
      'source',
      (v) => $enumDecode(_$RealtimeSourceEnumMap, v),
    ),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$RealtimeShakeDetectedEventToJson(
  RealtimeShakeDetectedEvent instance,
) => <String, dynamic>{
  'data': instance.data,
  'source': _$RealtimeSourceEnumMap[instance.source]!,
  'runtimeType': instance.$type,
};
