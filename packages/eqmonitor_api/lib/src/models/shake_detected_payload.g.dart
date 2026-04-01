// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detected_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShakeDetectedPayload _$ShakeDetectedPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ShakeDetectedPayload',
  json,
  ($checkedConvert) {
    final val = _ShakeDetectedPayload(
      type: $checkedConvert('type', (v) => v),
      eventId: $checkedConvert('event_id', (v) => v as String),
      createdAt: $checkedConvert('created_at', (v) => v as String),
      level: $checkedConvert(
        'level',
        (v) => $enumDecode(_$ShakeDetectionLevelEnumMap, v),
      ),
      changeReasons: $checkedConvert(
        'change_reasons',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
      isReplay: $checkedConvert('is_replay', (v) => v as bool),
      pointCount: $checkedConvert('point_count', (v) => v as num),
      region: $checkedConvert(
        'region',
        (v) => RegionPayload.fromJson(v as Map<String, dynamic>),
      ),
      points: $checkedConvert(
        'points',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  ObservationPointPayload.fromJson(e as Map<String, dynamic>),
            )
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

Map<String, dynamic> _$ShakeDetectedPayloadToJson(
  _ShakeDetectedPayload instance,
) => <String, dynamic>{
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

const _$ShakeDetectionLevelEnumMap = {
  ShakeDetectionLevel.weaker: 'Weaker',
  ShakeDetectionLevel.weak: 'Weak',
  ShakeDetectionLevel.medium: 'Medium',
  ShakeDetectionLevel.strong: 'Strong',
  ShakeDetectionLevel.stronger: 'Stronger',
};
