// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'kyoshin_color_map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KyoshinColorMapModelImpl _$$KyoshinColorMapModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$KyoshinColorMapModelImpl',
      json,
      ($checkedConvert) {
        final val = _$KyoshinColorMapModelImpl(
          intensity: $checkedConvert('intensity', (v) => (v as num).toDouble()),
          r: $checkedConvert('r', (v) => (v as num).toInt()),
          g: $checkedConvert('g', (v) => (v as num).toInt()),
          b: $checkedConvert('b', (v) => (v as num).toInt()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$KyoshinColorMapModelImplToJson(
        _$KyoshinColorMapModelImpl instance) =>
    <String, dynamic>{
      'intensity': instance.intensity,
      'r': instance.r,
      'g': instance.g,
      'b': instance.b,
    };
