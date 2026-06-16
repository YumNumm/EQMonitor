// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'estimation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Estimation _$EstimationFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Estimation',
  json,
  ($checkedConvert) {
    final val = _Estimation(
      firstHeight: $checkedConvert(
        'first_height',
        (v) => v == null
            ? null
            : TsunamiEstimationFirstHeight.fromJson(v as Map<String, dynamic>),
      ),
      maxHeight: $checkedConvert(
        'max_height',
        (v) => v == null
            ? null
            : TsunamiEstimationMaxHeight.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'firstHeight': 'first_height', 'maxHeight': 'max_height'},
);

Map<String, dynamic> _$EstimationToJson(_Estimation instance) =>
    <String, dynamic>{
      'first_height': ?instance.firstHeight,
      'max_height': ?instance.maxHeight,
    };
