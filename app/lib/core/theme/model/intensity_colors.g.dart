// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_colors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityColors _$IntensityColorsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_IntensityColors',
      json,
      ($checkedConvert) {
        final val = _IntensityColors(
          unknown: $checkedConvert(
            'unknown',
            (v) => IntensityColorEntry.fromJson(v as Map<String, dynamic>),
          ),
          zero: $checkedConvert(
            'zero',
            (v) => IntensityColorEntry.fromJson(v as Map<String, dynamic>),
          ),
          one: $checkedConvert(
            'one',
            (v) => IntensityColorEntry.fromJson(v as Map<String, dynamic>),
          ),
          two: $checkedConvert(
            'two',
            (v) => IntensityColorEntry.fromJson(v as Map<String, dynamic>),
          ),
          three: $checkedConvert(
            'three',
            (v) => IntensityColorEntry.fromJson(v as Map<String, dynamic>),
          ),
          four: $checkedConvert(
            'four',
            (v) => IntensityColorEntry.fromJson(v as Map<String, dynamic>),
          ),
          fiveLower: $checkedConvert(
            'five_lower',
            (v) => IntensityColorEntry.fromJson(v as Map<String, dynamic>),
          ),
          fiveUpper: $checkedConvert(
            'five_upper',
            (v) => IntensityColorEntry.fromJson(v as Map<String, dynamic>),
          ),
          sixLower: $checkedConvert(
            'six_lower',
            (v) => IntensityColorEntry.fromJson(v as Map<String, dynamic>),
          ),
          sixUpper: $checkedConvert(
            'six_upper',
            (v) => IntensityColorEntry.fromJson(v as Map<String, dynamic>),
          ),
          seven: $checkedConvert(
            'seven',
            (v) => IntensityColorEntry.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'fiveLower': 'five_lower',
        'fiveUpper': 'five_upper',
        'sixLower': 'six_lower',
        'sixUpper': 'six_upper',
      },
    );

Map<String, dynamic> _$IntensityColorsToJson(_IntensityColors instance) =>
    <String, dynamic>{
      'unknown': instance.unknown,
      'zero': instance.zero,
      'one': instance.one,
      'two': instance.two,
      'three': instance.three,
      'four': instance.four,
      'five_lower': instance.fiveLower,
      'five_upper': instance.fiveUpper,
      'six_lower': instance.sixLower,
      'six_upper': instance.sixUpper,
      'seven': instance.seven,
    };
