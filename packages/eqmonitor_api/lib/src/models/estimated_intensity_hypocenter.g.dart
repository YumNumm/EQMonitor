// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'estimated_intensity_hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EstimatedIntensityHypocenter _$EstimatedIntensityHypocenterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EstimatedIntensityHypocenter', json, ($checkedConvert) {
  final val = _EstimatedIntensityHypocenter(
    regionCode: $checkedConvert('regionCode', (v) => v as num),
    originTime: $checkedConvert('originTime', (v) => v as String),
    regionName: $checkedConvert('regionName', (v) => v as String?),
    magnitude: $checkedConvert('magnitude', (v) => v as num?),
    depthKm: $checkedConvert('depthKm', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$EstimatedIntensityHypocenterToJson(
  _EstimatedIntensityHypocenter instance,
) => <String, dynamic>{
  'regionCode': instance.regionCode,
  'originTime': instance.originTime,
  'regionName': ?instance.regionName,
  'magnitude': ?instance.magnitude,
  'depthKm': ?instance.depthKm,
};
