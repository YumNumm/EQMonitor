// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_estimation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiEstimation _$TsunamiEstimationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiEstimation',
  json,
  ($checkedConvert) {
    final val = _TsunamiEstimation(
      code: $checkedConvert('code', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      firstHeight: $checkedConvert(
        'first_height',
        (v) => TsunamiEstimationFirstHeight.fromJson(v as Map<String, dynamic>),
      ),
      maxHeight: $checkedConvert(
        'max_height',
        (v) => TsunamiEstimationMaxHeight.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'firstHeight': 'first_height', 'maxHeight': 'max_height'},
);

Map<String, dynamic> _$TsunamiEstimationToJson(_TsunamiEstimation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'first_height': instance.firstHeight,
      'max_height': instance.maxHeight,
    };
