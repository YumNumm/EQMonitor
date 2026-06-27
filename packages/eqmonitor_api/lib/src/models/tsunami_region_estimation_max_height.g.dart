// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_region_estimation_max_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiRegionEstimationMaxHeight _$TsunamiRegionEstimationMaxHeightFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiRegionEstimationMaxHeight',
  json,
  ($checkedConvert) {
    final val = _TsunamiRegionEstimationMaxHeight(
      isOver: $checkedConvert('is_over', (v) => v as bool),
      isObserving: $checkedConvert('is_observing', (v) => v as bool),
      observedAt: $checkedConvert(
        'observed_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      value: $checkedConvert('value', (v) => v as num?),
      qualitative: $checkedConvert(
        'qualitative',
        (v) => $enumDecodeNullable(_$QualitativeHeightEnumMap, v),
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
    'isObserving': 'is_observing',
    'observedAt': 'observed_at',
  },
);

Map<String, dynamic> _$TsunamiRegionEstimationMaxHeightToJson(
  _TsunamiRegionEstimationMaxHeight instance,
) => <String, dynamic>{
  'is_over': instance.isOver,
  'is_observing': instance.isObserving,
  'observed_at': ?instance.observedAt?.toIso8601String(),
  'value': ?instance.value,
  'qualitative': ?instance.qualitative,
  'revise': ?instance.revise,
};

const _$QualitativeHeightEnumMap = {
  QualitativeHeight.enormous: 'ENORMOUS',
  QualitativeHeight.high: 'HIGH',
};

const _$ReviseEnumMap = {Revise.addition: 'ADDITION', Revise.update: 'UPDATE'};
