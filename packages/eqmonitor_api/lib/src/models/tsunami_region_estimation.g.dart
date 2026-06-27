// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_region_estimation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiRegionEstimation _$TsunamiRegionEstimationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiRegionEstimation',
  json,
  ($checkedConvert) {
    final val = _TsunamiRegionEstimation(
      firstHeight: $checkedConvert(
        'first_height',
        (v) => FirstHeight.fromJson(v as Map<String, dynamic>),
      ),
      maxHeight: $checkedConvert(
        'max_height',
        (v) => MaxHeight.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'firstHeight': 'first_height', 'maxHeight': 'max_height'},
);

Map<String, dynamic> _$TsunamiRegionEstimationToJson(
  _TsunamiRegionEstimation instance,
) => <String, dynamic>{
  'first_height': instance.firstHeight,
  'max_height': instance.maxHeight,
};
