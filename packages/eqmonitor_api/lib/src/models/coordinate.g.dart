// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'coordinate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Coordinate _$CoordinateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Coordinate', json, ($checkedConvert) {
      final val = _Coordinate(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$CoordinateTypeEnumMap, v),
        ),
        latitude: $checkedConvert('latitude', (v) => v as num?),
        longitude: $checkedConvert('longitude', (v) => v as num?),
        condition: $checkedConvert('condition', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$CoordinateToJson(_Coordinate instance) =>
    <String, dynamic>{
      'type': instance.type,
      'latitude': ?instance.latitude,
      'longitude': ?instance.longitude,
      'condition': ?instance.condition,
    };

const _$CoordinateTypeEnumMap = {
  CoordinateType.latLng: 'LAT_LNG',
  CoordinateType.unknown: 'UNKNOWN',
};
