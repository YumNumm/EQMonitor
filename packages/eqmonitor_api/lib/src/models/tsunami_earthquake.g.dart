// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_earthquake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiEarthquake _$TsunamiEarthquakeFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_TsunamiEarthquake',
      json,
      ($checkedConvert) {
        final val = _TsunamiEarthquake(
          originTime: $checkedConvert(
            'origin_time',
            (v) => DateTime.parse(v as String),
          ),
          hypocenter: $checkedConvert(
            'hypocenter',
            (v) => Hypocenter.fromJson(v as Map<String, dynamic>),
          ),
          arrivalTime: $checkedConvert(
            'arrival_time',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'originTime': 'origin_time',
        'arrivalTime': 'arrival_time',
      },
    );

Map<String, dynamic> _$TsunamiEarthquakeToJson(_TsunamiEarthquake instance) =>
    <String, dynamic>{
      'origin_time': instance.originTime.toIso8601String(),
      'hypocenter': instance.hypocenter,
      'arrival_time': ?instance.arrivalTime?.toIso8601String(),
    };
