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
          isOver: $checkedConvert('is_over', (v) => v as bool),
          isRising: $checkedConvert('is_rising', (v) => v as bool),
          isMissing: $checkedConvert('is_missing', (v) => v as bool),
          observedAt: $checkedConvert(
            'observed_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          value: $checkedConvert('value', (v) => v as num?),
          condition: $checkedConvert(
            'condition',
            (v) =>
                $enumDecodeNullable(_$ObservationMaxHeightConditionEnumMap, v),
          ),
          revise: $checkedConvert(
            'revise',
            (v) => $enumDecodeNullable(_$ReviseEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'isOver': 'is_over',
        'isRising': 'is_rising',
        'isMissing': 'is_missing',
        'observedAt': 'observed_at',
      },
    );

Map<String, dynamic> _$TsunamiStationObservationMaxHeightToJson(
  _TsunamiStationObservationMaxHeight instance,
) => <String, dynamic>{
  'is_over': instance.isOver,
  'is_rising': instance.isRising,
  'is_missing': instance.isMissing,
  'observed_at': ?instance.observedAt?.toIso8601String(),
  'value': ?instance.value,
  'condition': ?instance.condition,
  'revise': ?instance.revise,
};

const _$ObservationMaxHeightConditionEnumMap = {
  ObservationMaxHeightCondition.minor: 'MINOR',
  ObservationMaxHeightCondition.observing: 'OBSERVING',
  ObservationMaxHeightCondition.important: 'IMPORTANT',
};

const _$ReviseEnumMap = {Revise.addition: 'ADDITION', Revise.update: 'UPDATE'};
