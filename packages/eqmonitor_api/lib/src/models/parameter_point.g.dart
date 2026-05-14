// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameter_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParameterPoint _$ParameterPointFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ParameterPoint', json, ($checkedConvert) {
      final val = _ParameterPoint(
        x: $checkedConvert('x', (v) => v as num),
        y: $checkedConvert('y', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$ParameterPointToJson(_ParameterPoint instance) =>
    <String, dynamic>{'x': instance.x, 'y': instance.y};
