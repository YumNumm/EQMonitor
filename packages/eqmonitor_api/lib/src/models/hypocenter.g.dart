// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Hypocenter _$HypocenterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Hypocenter', json, ($checkedConvert) {
      final val = _Hypocenter(
        magnitude: $checkedConvert(
          'magnitude',
          (v) => Magnitude.fromJson(v as Map<String, dynamic>),
        ),
        depth: $checkedConvert(
          'depth',
          (v) => Depth.fromJson(v as Map<String, dynamic>),
        ),
        code: $checkedConvert('code', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
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
        auxiliary: $checkedConvert(
          'auxiliary',
          (v) => v == null
              ? null
              : HypocenterAuxiliary.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$HypocenterToJson(_Hypocenter instance) =>
    <String, dynamic>{
      'magnitude': instance.magnitude,
      'depth': instance.depth,
      'code': ?instance.code,
      'name': ?instance.name,
      'detailed': ?instance.detailed,
      'coordinates': ?instance.coordinates,
      'auxiliary': ?instance.auxiliary,
    };
