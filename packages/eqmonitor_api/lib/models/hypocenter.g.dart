// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Hypocenter _$HypocenterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Hypocenter', json, ($checkedConvert) {
      final val = _Hypocenter(
        value: $checkedConvert(
          'value',
          (v) => CodeName.fromJson(v as Map<String, dynamic>),
        ),
        coordinates: $checkedConvert(
          'coordinates',
          (v) => Coordinate.fromJson(v as Map<String, dynamic>),
        ),
        magnitude: $checkedConvert(
          'magnitude',
          (v) => Magnitude.fromJson(v as Map<String, dynamic>),
        ),
        depth: $checkedConvert(
          'depth',
          (v) => Depth.fromJson(v as Map<String, dynamic>),
        ),
        detailed: $checkedConvert(
          'detailed',
          (v) =>
              v == null ? null : CodeName.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$HypocenterToJson(_Hypocenter instance) =>
    <String, dynamic>{
      'value': instance.value,
      'coordinates': instance.coordinates,
      'magnitude': instance.magnitude,
      'depth': instance.depth,
      'detailed': ?instance.detailed,
    };
