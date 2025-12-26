// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'earthquake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Earthquake _$EarthquakeFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Earthquake',
  json,
  ($checkedConvert) {
    final val = _Earthquake(
      eventId: $checkedConvert('event_id', (v) => v as String),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$TelegramStatusEnumMap, v),
      ),
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      hypocenter: $checkedConvert(
        'hypocenter',
        (v) =>
            v == null ? null : Hypocenter.fromJson(v as Map<String, dynamic>),
      ),
      intensity: $checkedConvert(
        'intensity',
        (v) => v == null ? null : Intensity.fromJson(v as Map<String, dynamic>),
      ),
      telegrams: $checkedConvert(
        'telegrams',
        (v) => (v as List<dynamic>)
            .map(
              (e) => EarthquakeTelegramRef.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'originTime': 'origin_time',
    'arrivalTime': 'arrival_time',
  },
);

Map<String, dynamic> _$EarthquakeToJson(_Earthquake instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'status': _$TelegramStatusEnumMap[instance.status]!,
      'origin_time': instance.originTime?.toIso8601String(),
      'arrival_time': instance.arrivalTime?.toIso8601String(),
      'hypocenter': instance.hypocenter,
      'intensity': instance.intensity,
      'telegrams': instance.telegrams,
    };

const _$TelegramStatusEnumMap = {
  TelegramStatus.normal: 'NORMAL',
  TelegramStatus.training: 'TRAINING',
  TelegramStatus.test: 'TEST',
};

_EarthquakePartial _$EarthquakePartialFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EarthquakePartial',
      json,
      ($checkedConvert) {
        final val = _EarthquakePartial(
          eventId: $checkedConvert('event_id', (v) => v as String),
          status: $checkedConvert(
            'status',
            (v) => $enumDecode(_$TelegramStatusEnumMap, v),
          ),
          originTime: $checkedConvert(
            'origin_time',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          arrivalTime: $checkedConvert(
            'arrival_time',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          hypocenter: $checkedConvert(
            'hypocenter',
            (v) => v == null
                ? null
                : Hypocenter.fromJson(v as Map<String, dynamic>),
          ),
          intensity: $checkedConvert(
            'intensity',
            (v) => v == null
                ? null
                : IntensityPartial.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'originTime': 'origin_time',
        'arrivalTime': 'arrival_time',
      },
    );

Map<String, dynamic> _$EarthquakePartialToJson(_EarthquakePartial instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'status': _$TelegramStatusEnumMap[instance.status]!,
      'origin_time': instance.originTime?.toIso8601String(),
      'arrival_time': instance.arrivalTime?.toIso8601String(),
      'hypocenter': instance.hypocenter,
      'intensity': instance.intensity,
    };
