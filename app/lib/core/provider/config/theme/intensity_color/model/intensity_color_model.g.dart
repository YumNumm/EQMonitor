// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'intensity_color_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntensityColorModelImpl _$$IntensityColorModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$IntensityColorModelImpl',
      json,
      ($checkedConvert) {
        final val = _$IntensityColorModelImpl(
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

Map<String, dynamic> _$$IntensityColorModelImplToJson(
        _$IntensityColorModelImpl instance) =>
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

_$TextColorModelImpl _$$TextColorModelImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TextColorModelImpl',
      json,
      ($checkedConvert) {
        final val = _$TextColorModelImpl(
          foreground:
              $checkedConvert('foreground', (v) => colorFromJson(v as String)),
          background:
              $checkedConvert('background', (v) => colorFromJson(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TextColorModelImplToJson(
        _$TextColorModelImpl instance) =>
    <String, dynamic>{
      'foreground': colorToJson(instance.foreground),
      'background': colorToJson(instance.background),
    };
