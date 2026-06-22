// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_station_observation_max_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiStationObservationMaxHeight
_$TsunamiStationObservationMaxHeightFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_TsunamiStationObservationMaxHeight',
      json,
      ($checkedConvert) {
        final val = _TsunamiStationObservationMaxHeight(
          dateTime: $checkedConvert(
            'date_time',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          value: $checkedConvert('value', (v) => v as num?),
          isOver: $checkedConvert('is_over', (v) => v),
          isRising: $checkedConvert('is_rising', (v) => v),
          condition: $checkedConvert(
            'condition',
            (v) => v == null
                ? null
                : ObservationMaxHeightCondition.fromJson(
                    v as Map<String, dynamic>,
                  ),
          ),
          isMissing: $checkedConvert('is_missing', (v) => v),
          revise: $checkedConvert(
            'revise',
            (v) =>
                v == null ? null : Revise.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'dateTime': 'date_time',
        'isOver': 'is_over',
        'isRising': 'is_rising',
        'isMissing': 'is_missing',
      },
    );

Map<String, dynamic> _$TsunamiStationObservationMaxHeightToJson(
  _TsunamiStationObservationMaxHeight instance,
) => <String, dynamic>{
  'date_time': ?instance.dateTime?.toIso8601String(),
  'value': ?instance.value,
  'is_over': ?instance.isOver,
  'is_rising': ?instance.isRising,
  'condition': ?instance.condition,
  'is_missing': ?instance.isMissing,
  'revise': ?instance.revise,
};
