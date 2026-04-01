// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_intensity_region_arrival_time_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewIntensityRegionArrivalTimeTime _$EewIntensityRegionArrivalTimeTimeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EewIntensityRegionArrivalTimeTime', json, (
  $checkedConvert,
) {
  final val = _EewIntensityRegionArrivalTimeTime(
    type: $checkedConvert('type', (v) => v),
    value: $checkedConvert('value', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$EewIntensityRegionArrivalTimeTimeToJson(
  _EewIntensityRegionArrivalTimeTime instance,
) => <String, dynamic>{
  'type': instance.type,
  'value': instance.value.toIso8601String(),
};
