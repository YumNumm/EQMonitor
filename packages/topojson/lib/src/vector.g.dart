// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'vector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoubleVectorImpl _$$DoubleVectorImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$DoubleVectorImpl',
      json,
      ($checkedConvert) {
        final val = _$DoubleVectorImpl(
          x: $checkedConvert('x', (v) => (v as num).toDouble()),
          y: $checkedConvert('y', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$DoubleVectorImplToJson(_$DoubleVectorImpl instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };

_$IntVectorImpl _$$IntVectorImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$IntVectorImpl',
      json,
      ($checkedConvert) {
        final val = _$IntVectorImpl(
          x: $checkedConvert('x', (v) => v as int),
          y: $checkedConvert('y', (v) => v as int),
        );
        return val;
      },
    );

Map<String, dynamic> _$$IntVectorImplToJson(_$IntVectorImpl instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };
