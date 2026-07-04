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
      observedAt: $checkedConvert(
        'observed_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      value: $checkedConvert('value', (v) => v as num?),
      isOver: $checkedConvert('is_over', (v) => v as bool?),
      qualitative: $checkedConvert(
        'qualitative',
        (v) => $enumDecodeNullable(_$QualitativeHeightEnumMap, v),
      ),
      isObserving: $checkedConvert('is_observing', (v) => v as bool?),
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
    'isObserving': 'is_observing',
  },
);

Map<String, dynamic> _$TsunamiRegionEstimationMaxHeightToJson(
  _TsunamiRegionEstimationMaxHeight instance,
) => <String, dynamic>{
  'observed_at': ?instance.observedAt?.toIso8601String(),
  'value': ?instance.value,
  'is_over': ?instance.isOver,
  'qualitative': ?instance.qualitative,
  'is_observing': ?instance.isObserving,
  'revise': ?instance.revise,
};

const _$QualitativeHeightEnumMap = {
  QualitativeHeight.enormous: 'ENORMOUS',
  QualitativeHeight.high: 'HIGH',
};

const _$ReviseEnumMap = {Revise.addition: 'ADDITION', Revise.update: 'UPDATE'};
