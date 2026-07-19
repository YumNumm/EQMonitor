// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_shake_detection_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WsShakeMergedEvent _$WsShakeMergedEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_WsShakeMergedEvent', json, ($checkedConvert) {
      final val = _WsShakeMergedEvent(
        eventId: $checkedConvert('eventId', (v) => v as String),
        mergedAt: $checkedConvert(
          'mergedAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WsShakeMergedEventToJson(_WsShakeMergedEvent instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'mergedAt': instance.mergedAt.toIso8601String(),
    };

_WsShakeCorrelatedEew _$WsShakeCorrelatedEewFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WsShakeCorrelatedEew', json, ($checkedConvert) {
  final val = _WsShakeCorrelatedEew(
    eventId: $checkedConvert('eventId', (v) => v as String),
    score: $checkedConvert('score', (v) => (v as num).toDouble()),
  );
  return val;
});

Map<String, dynamic> _$WsShakeCorrelatedEewToJson(
  _WsShakeCorrelatedEew instance,
) => <String, dynamic>{'eventId': instance.eventId, 'score': instance.score};

_WsShakeDetectionEvent _$WsShakeDetectionEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WsShakeDetectionEvent', json, ($checkedConvert) {
  final val = _WsShakeDetectionEvent(
    type: $checkedConvert('type', (v) => v as String),
    eventId: $checkedConvert('eventId', (v) => v as String),
    serialNo: $checkedConvert('serialNo', (v) => (v as num).toInt()),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
    expiresAt: $checkedConvert('expiresAt', (v) => DateTime.parse(v as String)),
    level: $checkedConvert('level', (v) => v as String),
    changeReasons: $checkedConvert(
      'changeReasons',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    mergedEvents: $checkedConvert(
      'mergedEvents',
      (v) => (v as List<dynamic>)
          .map((e) => WsShakeMergedEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    pointCount: $checkedConvert('pointCount', (v) => (v as num).toInt()),
    region: $checkedConvert(
      'region',
      (v) => WsShakeRegionPayload.fromJson(v as Map<String, dynamic>),
    ),
    points: $checkedConvert(
      'points',
      (v) => (v as List<dynamic>)
          .map(
            (e) => WsShakeObservationPoint.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
    correlatedEew: $checkedConvert(
      'correlatedEew',
      (v) => v == null
          ? null
          : WsShakeCorrelatedEew.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$WsShakeDetectionEventToJson(
  _WsShakeDetectionEvent instance,
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
  'correlatedEew': instance.correlatedEew,
};
