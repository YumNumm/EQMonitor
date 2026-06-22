// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_region_forecast_max_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiRegionForecastMaxHeight _$TsunamiRegionForecastMaxHeightFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiRegionForecastMaxHeight',
  json,
  ($checkedConvert) {
    final val = _TsunamiRegionForecastMaxHeight(
      value: $checkedConvert('value', (v) => v as num?),
      isOver: $checkedConvert('is_over', (v) => v),
      qualitative: $checkedConvert(
        'qualitative',
        (v) => v == null
            ? null
            : QualitativeHeight.fromJson(v as Map<String, dynamic>),
      ),
      isImportant: $checkedConvert('is_important', (v) => v),
      revise: $checkedConvert(
        'revise',
        (v) => v == null ? null : Revise.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'isOver': 'is_over', 'isImportant': 'is_important'},
);

Map<String, dynamic> _$TsunamiRegionForecastMaxHeightToJson(
  _TsunamiRegionForecastMaxHeight instance,
) => <String, dynamic>{
  'value': ?instance.value,
  'is_over': ?instance.isOver,
  'qualitative': ?instance.qualitative,
  'is_important': ?instance.isImportant,
  'revise': ?instance.revise,
};
