// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'eew_hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewHypocenter _$EewHypocenterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EewHypocenter', json, ($checkedConvert) {
      final val = _EewHypocenter(
        value: $checkedConvert(
          'value',
          (v) => CodeName.fromJson(v as Map<String, dynamic>),
        ),
        detailed: $checkedConvert(
          'detailed',
          (v) =>
              v == null ? null : CodeName.fromJson(v as Map<String, dynamic>),
        ),
        coordinates: $checkedConvert(
          'coordinates',
          (v) => Coordinate.fromJson(v as Map<String, dynamic>),
        ),
        magnitude: $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
        depth: $checkedConvert('depth', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$EewHypocenterToJson(_EewHypocenter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'detailed': instance.detailed,
      'coordinates': instance.coordinates,
      'magnitude': instance.magnitude,
      'depth': instance.depth,
    };
