// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_observation_station_max_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiObservationStationMaxHeight
_$TsunamiObservationStationMaxHeightFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_TsunamiObservationStationMaxHeight',
      json,
      ($checkedConvert) {
        final val = _TsunamiObservationStationMaxHeight(
          dateTime: $checkedConvert(
            'date_time',
            (v) => DateTime.parse(v as String),
          ),
          value: $checkedConvert('value', (v) => v as num),
          over: $checkedConvert('over', (v) => v as bool),
          isRising: $checkedConvert('is_rising', (v) => v as bool),
          condition: $checkedConvert(
            'condition',
            (v) => $enumDecode(_$ObservationMaxHeightConditionEnumMap, v),
          ),
          isMissing: $checkedConvert('is_missing', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'dateTime': 'date_time',
        'isRising': 'is_rising',
        'isMissing': 'is_missing',
      },
    );

Map<String, dynamic> _$TsunamiObservationStationMaxHeightToJson(
  _TsunamiObservationStationMaxHeight instance,
) => <String, dynamic>{
  'date_time': instance.dateTime.toIso8601String(),
  'value': instance.value,
  'over': instance.over,
  'is_rising': instance.isRising,
  'condition': instance.condition,
  'is_missing': instance.isMissing,
};

const _$ObservationMaxHeightConditionEnumMap = {
  ObservationMaxHeightCondition.minor: 'MINOR',
  ObservationMaxHeightCondition.observing: 'OBSERVING',
  ObservationMaxHeightCondition.important: 'IMPORTANT',
};
