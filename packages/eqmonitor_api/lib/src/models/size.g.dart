// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'size.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Size _$SizeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Size', json, ($checkedConvert) {
      final val = _Size(
        x: $checkedConvert('x', (v) => v as num),
        y: $checkedConvert('y', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$SizeToJson(_Size instance) => <String, dynamic>{
  'x': instance.x,
  'y': instance.y,
};
