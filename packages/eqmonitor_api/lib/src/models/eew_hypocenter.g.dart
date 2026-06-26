// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewHypocenter _$EewHypocenterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EewHypocenter', json, ($checkedConvert) {
      final val = _EewHypocenter(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        magnitude: $checkedConvert('magnitude', (v) => v as num?),
        depth: $checkedConvert('depth', (v) => (v as num?)?.toInt()),
        detailed: $checkedConvert(
          'detailed',
          (v) =>
              v == null ? null : CodeName.fromJson(v as Map<String, dynamic>),
        ),
        coordinates: $checkedConvert(
          'coordinates',
          (v) =>
              v == null ? null : Coordinate.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EewHypocenterToJson(_EewHypocenter instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'magnitude': instance.magnitude,
      'depth': instance.depth,
      'detailed': ?instance.detailed,
      'coordinates': ?instance.coordinates,
    };
