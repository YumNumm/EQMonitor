// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShakeDetectionState _$ShakeDetectionStateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ShakeDetectionState', json, ($checkedConvert) {
  final val = _ShakeDetectionState(
    type: $checkedConvert('type', (v) => v as String),
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
          .map((e) => MergedEvents.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    pointCount: $checkedConvert('pointCount', (v) => (v as num).toInt()),
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
    test: $checkedConvert(
      'test',
      (v) => v == null ? null : Test.fromJson(v as Map<String, dynamic>),
    ),
    correlatedEew: $checkedConvert(
      'correlatedEew',
      (v) =>
          v == null ? null : CorrelatedEew.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$ShakeDetectionStateToJson(
  _ShakeDetectionState instance,
) => <String, dynamic>{
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
