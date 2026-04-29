// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_shake_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeShakeData _$RealtimeShakeDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_RealtimeShakeData',
      json,
      ($checkedConvert) {
        final val = _RealtimeShakeData(
          eventId: $checkedConvert('event_id', (v) => v as String),
          createdAt: $checkedConvert(
            'created_at',
            (v) => DateTime.parse(v as String),
          ),
          level: $checkedConvert('level', (v) => v as String),
          isReplay: $checkedConvert('is_replay', (v) => v as bool),
          pointCount: $checkedConvert('point_count', (v) => (v as num).toInt()),
          minLat: $checkedConvert('min_lat', (v) => (v as num).toDouble()),
          maxLat: $checkedConvert('max_lat', (v) => (v as num).toDouble()),
          minLng: $checkedConvert('min_lng', (v) => (v as num).toDouble()),
          maxLng: $checkedConvert('max_lng', (v) => (v as num).toDouble()),
          changeReasons: $checkedConvert(
            'change_reasons',
            (v) =>
                (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                const [],
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'createdAt': 'created_at',
        'isReplay': 'is_replay',
        'pointCount': 'point_count',
        'minLat': 'min_lat',
        'maxLat': 'max_lat',
        'minLng': 'min_lng',
        'maxLng': 'max_lng',
        'changeReasons': 'change_reasons',
      },
    );

Map<String, dynamic> _$RealtimeShakeDataToJson(_RealtimeShakeData instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'created_at': instance.createdAt.toIso8601String(),
      'level': instance.level,
      'is_replay': instance.isReplay,
      'point_count': instance.pointCount,
      'min_lat': instance.minLat,
      'max_lat': instance.maxLat,
      'min_lng': instance.minLng,
      'max_lng': instance.maxLng,
      'change_reasons': instance.changeReasons,
    };
