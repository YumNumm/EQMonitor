// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'vector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DoubleVector _$$_DoubleVectorFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_DoubleVector',
      json,
      ($checkedConvert) {
        final val = _$_DoubleVector(
          x: $checkedConvert('x', (v) => (v as num).toDouble()),
          y: $checkedConvert('y', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_DoubleVectorToJson(_$_DoubleVector instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };

_$_IntVector _$$_IntVectorFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_IntVector',
      json,
      ($checkedConvert) {
        final val = _$_IntVector(
          x: $checkedConvert('x', (v) => v as int),
          y: $checkedConvert('y', (v) => v as int),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_IntVectorToJson(_$_IntVector instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };
