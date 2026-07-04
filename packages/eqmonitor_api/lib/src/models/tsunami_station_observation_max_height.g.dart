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
          observedAt: $checkedConvert(
            'observed_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          value: $checkedConvert('value', (v) => v as num?),
          isOver: $checkedConvert('is_over', (v) => v as bool?),
          isRising: $checkedConvert('is_rising', (v) => v as bool?),
          condition: $checkedConvert(
            'condition',
            (v) =>
                $enumDecodeNullable(_$ObservationMaxHeightConditionEnumMap, v),
          ),
          isMissing: $checkedConvert('is_missing', (v) => v as bool?),
          revise: $checkedConvert(
            'revise',
            (v) => $enumDecodeNullable(_$ReviseEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'observedAt': 'observed_at',
        'isOver': 'is_over',
        'isRising': 'is_rising',
        'isMissing': 'is_missing',
      },
    );

Map<String, dynamic> _$TsunamiStationObservationMaxHeightToJson(
  _TsunamiStationObservationMaxHeight instance,
) => <String, dynamic>{
  'observed_at': ?instance.observedAt?.toIso8601String(),
  'value': ?instance.value,
  'is_over': ?instance.isOver,
  'is_rising': ?instance.isRising,
  'condition': ?instance.condition,
  'is_missing': ?instance.isMissing,
  'revise': ?instance.revise,
};

const _$ObservationMaxHeightConditionEnumMap = {
  ObservationMaxHeightCondition.minor: 'MINOR',
  ObservationMaxHeightCondition.observing: 'OBSERVING',
  ObservationMaxHeightCondition.important: 'IMPORTANT',
};

const _$ReviseEnumMap = {Revise.addition: 'ADDITION', Revise.update: 'UPDATE'};
