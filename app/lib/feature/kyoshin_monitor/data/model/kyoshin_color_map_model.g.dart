// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_color_map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinColorMapModel _$KyoshinColorMapModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_KyoshinColorMapModel', json, ($checkedConvert) {
  final val = _KyoshinColorMapModel(
    intensity: $checkedConvert('intensity', (v) => (v as num).toDouble()),
    r: $checkedConvert('r', (v) => (v as num).toInt()),
    g: $checkedConvert('g', (v) => (v as num).toInt()),
    b: $checkedConvert('b', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$KyoshinColorMapModelToJson(
  _KyoshinColorMapModel instance,
) => <String, dynamic>{
  'intensity': instance.intensity,
  'r': instance.r,
  'g': instance.g,
  'b': instance.b,
};
