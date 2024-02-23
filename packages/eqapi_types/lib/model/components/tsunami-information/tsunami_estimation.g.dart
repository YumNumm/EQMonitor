// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'tsunami_estimation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TsunamiEstimationImpl _$$TsunamiEstimationImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiEstimationImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiEstimationImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          firstHeightTime: $checkedConvert('first_height_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          firstHeightCondition: $checkedConvert(
              'first_height_condition',
              (v) => $enumDecodeNullable(
                  _$TsunamiEstimationFirstHeightConditionEnumMap, v)),
          maxHeightTime: $checkedConvert('max_height_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          maxHeightValue: $checkedConvert(
              'max_height_value', (v) => (v as num?)?.toDouble()),
          maxHeightIsOver:
              $checkedConvert('max_height_is_over', (v) => v as bool?),
          maxHeightCondition: $checkedConvert(
              'max_height_condition',
              (v) => $enumDecodeNullable(
                  _$TsunamiEstimationMaxHeightConditionEnumMap, v)),
          isObserving: $checkedConvert('is_observing', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'firstHeightTime': 'first_height_time',
        'firstHeightCondition': 'first_height_condition',
        'maxHeightTime': 'max_height_time',
        'maxHeightValue': 'max_height_value',
        'maxHeightIsOver': 'max_height_is_over',
        'maxHeightCondition': 'max_height_condition',
        'isObserving': 'is_observing'
      },
    );

Map<String, dynamic> _$$TsunamiEstimationImplToJson(
        _$TsunamiEstimationImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'first_height_time': instance.firstHeightTime?.toIso8601String(),
      'first_height_condition': _$TsunamiEstimationFirstHeightConditionEnumMap[
          instance.firstHeightCondition],
      'max_height_time': instance.maxHeightTime?.toIso8601String(),
      'max_height_value': instance.maxHeightValue,
      'max_height_is_over': instance.maxHeightIsOver,
      'max_height_condition': _$TsunamiEstimationMaxHeightConditionEnumMap[
          instance.maxHeightCondition],
      'is_observing': instance.isObserving,
    };

const _$TsunamiEstimationFirstHeightConditionEnumMap = {
  TsunamiEstimationFirstHeightCondition.already: '早いところでは既に津波到達と推定',
};

const _$TsunamiEstimationMaxHeightConditionEnumMap = {
  TsunamiEstimationMaxHeightCondition.high: '高い',
  TsunamiEstimationMaxHeightCondition.huge: '巨大',
};
