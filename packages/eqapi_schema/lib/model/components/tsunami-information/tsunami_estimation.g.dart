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
          firstHeightTime: $checkedConvert('firstHeightTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          firstHeightCondition: $checkedConvert(
              'firstHeightCondition',
              (v) => $enumDecodeNullable(
                  _$TsunamiEstimationFirstHeightConditionEnumMap, v)),
          maxHeightTime: $checkedConvert('maxHeightTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          maxHeightValue:
              $checkedConvert('maxHeightValue', (v) => (v as num?)?.toDouble()),
          maxHeightIsOver:
              $checkedConvert('maxHeightIsOver', (v) => v as bool?),
          maxHeightCondition: $checkedConvert(
              'maxHeightCondition',
              (v) => $enumDecodeNullable(
                  _$TsunamiEstimationMaxHeightConditionEnumMap, v)),
          isObserving: $checkedConvert('isObserving', (v) => v as bool?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiEstimationImplToJson(
        _$TsunamiEstimationImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'firstHeightTime': instance.firstHeightTime?.toIso8601String(),
      'firstHeightCondition': _$TsunamiEstimationFirstHeightConditionEnumMap[
          instance.firstHeightCondition],
      'maxHeightTime': instance.maxHeightTime?.toIso8601String(),
      'maxHeightValue': instance.maxHeightValue,
      'maxHeightIsOver': instance.maxHeightIsOver,
      'maxHeightCondition': _$TsunamiEstimationMaxHeightConditionEnumMap[
          instance.maxHeightCondition],
      'isObserving': instance.isObserving,
    };

const _$TsunamiEstimationFirstHeightConditionEnumMap = {
  TsunamiEstimationFirstHeightCondition.already: '早いところでは既に津波到達と推定',
};

const _$TsunamiEstimationMaxHeightConditionEnumMap = {
  TsunamiEstimationMaxHeightCondition.high: '高い',
  TsunamiEstimationMaxHeightCondition.huge: '巨大',
};
