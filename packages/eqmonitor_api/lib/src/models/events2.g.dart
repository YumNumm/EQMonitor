// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'events2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Events2 _$Events2FromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_Events2', json, ($checkedConvert) {
  final val = _Events2(
    type: $checkedConvert('type', (v) => $enumDecode(_$Type3EnumMap, v)),
    eventId: $checkedConvert('eventId', (v) => v as String),
    serialNo: $checkedConvert('serialNo', (v) => (v as num).toInt()),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
    expiresAt: $checkedConvert('expiresAt', (v) => DateTime.parse(v as String)),
    level: $checkedConvert('level', (v) => $enumDecode(_$LevelEnumMap, v)),
    changeReasons: $checkedConvert(
      'changeReasons',
      (v) => (v as List<dynamic>)
          .map((e) => $enumDecode(_$ChangeReasonsEnumMap, e))
          .toList(),
    ),
    mergedEvents: $checkedConvert(
      'mergedEvents',
      (v) => (v as List<dynamic>)
          .map((e) => MergedEvents2.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    pointCount: $checkedConvert('pointCount', (v) => (v as num).toInt()),
    region: $checkedConvert(
      'region',
      (v) => Region2.fromJson(v as Map<String, dynamic>),
    ),
    points: $checkedConvert(
      'points',
      (v) => (v as List<dynamic>)
          .map((e) => Points2.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    test: $checkedConvert(
      'test',
      (v) => v == null ? null : Test2.fromJson(v as Map<String, dynamic>),
    ),
    correlatedEew: $checkedConvert(
      'correlatedEew',
      (v) =>
          v == null ? null : CorrelatedEew2.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$Events2ToJson(_Events2 instance) => <String, dynamic>{
  'type': instance.type,
  'eventId': instance.eventId,
  'serialNo': instance.serialNo,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'expiresAt': instance.expiresAt.toIso8601String(),
  'level': instance.level,
  'changeReasons': instance.changeReasons,
  'mergedEvents': instance.mergedEvents,
  'pointCount': instance.pointCount,
  'region': instance.region,
  'points': instance.points,
  'test': ?instance.test,
  'correlatedEew': ?instance.correlatedEew,
};

const _$Type3EnumMap = {Type3.shakeDetection: 'shake_detection'};

const _$LevelEnumMap = {
  Level.weaker: 'Weaker',
  Level.weak: 'Weak',
  Level.medium: 'Medium',
  Level.strong: 'Strong',
  Level.stronger: 'Stronger',
};

const _$ChangeReasonsEnumMap = {
  ChangeReasons.newEvent: 'new_event',
  ChangeReasons.levelUp: 'level_up',
  ChangeReasons.levelDown: 'level_down',
  ChangeReasons.regionChanged: 'region_changed',
  ChangeReasons.pointsChanged: 'points_changed',
  ChangeReasons.pointStateChanged: 'point_state_changed',
  ChangeReasons.expiresAtExtended: 'expires_at_extended',
  ChangeReasons.eventsMerged: 'events_merged',
};
