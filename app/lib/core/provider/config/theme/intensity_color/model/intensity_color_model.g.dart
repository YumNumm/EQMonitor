// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_color_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityColorModel _$IntensityColorModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_IntensityColorModel',
      json,
      ($checkedConvert) {
        final val = _IntensityColorModel(
          unknown: $checkedConvert(
            'unknown',
            (v) => TextColorModel.fromJson(v as Map<String, dynamic>),
          ),
          zero: $checkedConvert(
            'zero',
            (v) => TextColorModel.fromJson(v as Map<String, dynamic>),
          ),
          one: $checkedConvert(
            'one',
            (v) => TextColorModel.fromJson(v as Map<String, dynamic>),
          ),
          two: $checkedConvert(
            'two',
            (v) => TextColorModel.fromJson(v as Map<String, dynamic>),
          ),
          three: $checkedConvert(
            'three',
            (v) => TextColorModel.fromJson(v as Map<String, dynamic>),
          ),
          four: $checkedConvert(
            'four',
            (v) => TextColorModel.fromJson(v as Map<String, dynamic>),
          ),
          fiveLower: $checkedConvert(
            'five_lower',
            (v) => TextColorModel.fromJson(v as Map<String, dynamic>),
          ),
          fiveUpper: $checkedConvert(
            'five_upper',
            (v) => TextColorModel.fromJson(v as Map<String, dynamic>),
          ),
          sixLower: $checkedConvert(
            'six_lower',
            (v) => TextColorModel.fromJson(v as Map<String, dynamic>),
          ),
          sixUpper: $checkedConvert(
            'six_upper',
            (v) => TextColorModel.fromJson(v as Map<String, dynamic>),
          ),
          seven: $checkedConvert(
            'seven',
            (v) => TextColorModel.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$IntensityColorModelToJson(
  _IntensityColorModel instance,
) => <String, dynamic>{
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

_TextColorModel _$TextColorModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TextColorModel', json, ($checkedConvert) {
      final val = _TextColorModel(
        foreground: $checkedConvert(
          'foreground',
          (v) => colorFromJson(v as String),
        ),
        background: $checkedConvert(
          'background',
          (v) => colorFromJson(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TextColorModelToJson(_TextColorModel instance) =>
    <String, dynamic>{
      'foreground': colorToJson(instance.foreground),
      'background': colorToJson(instance.background),
    };
