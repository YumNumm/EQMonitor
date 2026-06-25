// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_region_forecast_first_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiRegionForecastFirstHeight _$TsunamiRegionForecastFirstHeightFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiRegionForecastFirstHeight',
  json,
  ($checkedConvert) {
    final val = _TsunamiRegionForecastFirstHeight(
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      condition: $checkedConvert('condition', (v) => v as String?),
      revise: $checkedConvert('revise', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'arrivalTime': 'arrival_time'},
);

Map<String, dynamic> _$TsunamiRegionForecastFirstHeightToJson(
  _TsunamiRegionForecastFirstHeight instance,
) => <String, dynamic>{
  'arrival_time': ?instance.arrivalTime?.toIso8601String(),
  'condition': ?instance.condition,
  'revise': ?instance.revise,
};
