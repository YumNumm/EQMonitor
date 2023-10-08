// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'intensity_color_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IntensityColorModel _$$_IntensityColorModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_IntensityColorModel',
      json,
      ($checkedConvert) {
        final val = _$_IntensityColorModel(
          unknown: $checkedConvert('unknown',
              (v) => TextColorModel.fromJson(v as Map<String, dynamic>)),
          zero: $checkedConvert('zero',
              (v) => TextColorModel.fromJson(v as Map<String, dynamic>)),
          one: $checkedConvert(
              'one', (v) => TextColorModel.fromJson(v as Map<String, dynamic>)),
          two: $checkedConvert(
              'two', (v) => TextColorModel.fromJson(v as Map<String, dynamic>)),
          three: $checkedConvert('three',
              (v) => TextColorModel.fromJson(v as Map<String, dynamic>)),
          four: $checkedConvert('four',
              (v) => TextColorModel.fromJson(v as Map<String, dynamic>)),
          fiveLower: $checkedConvert('fiveLower',
              (v) => TextColorModel.fromJson(v as Map<String, dynamic>)),
          fiveUpper: $checkedConvert('fiveUpper',
              (v) => TextColorModel.fromJson(v as Map<String, dynamic>)),
          sixLower: $checkedConvert('sixLower',
              (v) => TextColorModel.fromJson(v as Map<String, dynamic>)),
          sixUpper: $checkedConvert('sixUpper',
              (v) => TextColorModel.fromJson(v as Map<String, dynamic>)),
          seven: $checkedConvert('seven',
              (v) => TextColorModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_IntensityColorModelToJson(
        _$_IntensityColorModel instance) =>
    <String, dynamic>{
      'unknown': instance.unknown,
      'zero': instance.zero,
      'one': instance.one,
      'two': instance.two,
      'three': instance.three,
      'four': instance.four,
      'fiveLower': instance.fiveLower,
      'fiveUpper': instance.fiveUpper,
      'sixLower': instance.sixLower,
      'sixUpper': instance.sixUpper,
      'seven': instance.seven,
    };

_$_TextColorModel _$$_TextColorModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TextColorModel',
      json,
      ($checkedConvert) {
        final val = _$_TextColorModel(
          foreground:
              $checkedConvert('foreground', (v) => colorFromJson(v as String)),
          background:
              $checkedConvert('background', (v) => colorFromJson(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TextColorModelToJson(_$_TextColorModel instance) =>
    <String, dynamic>{
      'foreground': colorToJson(instance.foreground),
      'background': colorToJson(instance.background),
    };
