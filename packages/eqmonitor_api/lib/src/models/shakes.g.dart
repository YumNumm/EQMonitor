// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shakes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Shakes _$ShakesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Shakes', json, ($checkedConvert) {
      final val = _Shakes(
        type: $checkedConvert('type', (v) => v),
        eventId: $checkedConvert('eventId', (v) => v as String),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
        level: $checkedConvert('level', (v) => $enumDecode(_$LevelEnumMap, v)),
        changeReasons: $checkedConvert(
          'changeReasons',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        isReplay: $checkedConvert('isReplay', (v) => v as bool),
        pointCount: $checkedConvert('pointCount', (v) => v as num),
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
    });

Map<String, dynamic> _$ShakesToJson(_Shakes instance) => <String, dynamic>{
  'type': instance.type,
  'eventId': instance.eventId,
  'createdAt': instance.createdAt,
  'level': instance.level,
  'changeReasons': instance.changeReasons,
  'isReplay': instance.isReplay,
  'pointCount': instance.pointCount,
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
