// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shakes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Shakes _$ShakesFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Shakes',
  json,
  ($checkedConvert) {
    final val = _Shakes(
      type: $checkedConvert('type', (v) => v),
      eventId: $checkedConvert('event_id', (v) => v as String),
      createdAt: $checkedConvert('created_at', (v) => v as String),
      level: $checkedConvert('level', (v) => $enumDecode(_$LevelEnumMap, v)),
      changeReasons: $checkedConvert(
        'change_reasons',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
      isReplay: $checkedConvert('is_replay', (v) => v as bool),
      pointCount: $checkedConvert('point_count', (v) => v as num),
      region: $checkedConvert(
        'region',
        (v) => Region.fromJson(v as Map<String, dynamic>),
      ),
      points: $checkedConvert(
        'points',
        (v) => (v as List<dynamic>)
            .map((e) => Points.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'createdAt': 'created_at',
    'changeReasons': 'change_reasons',
    'isReplay': 'is_replay',
    'pointCount': 'point_count',
  },
);

Map<String, dynamic> _$ShakesToJson(_Shakes instance) => <String, dynamic>{
  'type': instance.type,
  'event_id': instance.eventId,
  'created_at': instance.createdAt,
  'level': instance.level,
  'change_reasons': instance.changeReasons,
  'is_replay': instance.isReplay,
  'point_count': instance.pointCount,
  'region': instance.region,
  'points': instance.points,
};

const _$LevelEnumMap = {
  Level.weaker: 'Weaker',
  Level.weak: 'Weak',
  Level.medium: 'Medium',
  Level.strong: 'Strong',
  Level.stronger: 'Stronger',
};
