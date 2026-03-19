// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_estimation_max_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiEstimationMaxHeight _$TsunamiEstimationMaxHeightFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiEstimationMaxHeight',
  json,
  ($checkedConvert) {
    final val = _TsunamiEstimationMaxHeight(
      dateTime: $checkedConvert(
        'date_time',
        (v) => DateTime.parse(v as String),
      ),
      value: $checkedConvert('value', (v) => v as num),
      over: $checkedConvert('over', (v) => v as bool),
      qualitative: $checkedConvert(
        'qualitative',
        (v) => $enumDecode(_$QualitativeHeightEnumMap, v),
      ),
      isObserving: $checkedConvert('is_observing', (v) => v as bool),
    );
    return val;
  },
  fieldKeyMap: const {'dateTime': 'date_time', 'isObserving': 'is_observing'},
);

Map<String, dynamic> _$TsunamiEstimationMaxHeightToJson(
  _TsunamiEstimationMaxHeight instance,
) => <String, dynamic>{
  'date_time': instance.dateTime.toIso8601String(),
  'value': instance.value,
  'over': instance.over,
  'qualitative': instance.qualitative,
  'is_observing': instance.isObserving,
};

const _$QualitativeHeightEnumMap = {
  QualitativeHeight.enormous: 'ENORMOUS',
  QualitativeHeight.high: 'HIGH',
};
