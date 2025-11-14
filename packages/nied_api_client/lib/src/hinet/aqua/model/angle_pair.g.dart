// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'angle_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnglePair _$AnglePairFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AnglePair', json, ($checkedConvert) {
      final val = _AnglePair(
        first: $checkedConvert('first', (v) => (v as num).toDouble()),
        second: $checkedConvert('second', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$AnglePairToJson(_AnglePair instance) =>
    <String, dynamic>{'first': instance.first, 'second': instance.second};
