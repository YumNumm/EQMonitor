// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeHypocenter _$EarthquakeHypocenterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeHypocenter',
  json,
  ($checkedConvert) {
    final val = _EarthquakeHypocenter(
      code: $checkedConvert('code', (v) => v as String?),
      name: $checkedConvert('name', (v) => v as String?),
      coordinates: $checkedConvert(
        'coordinates',
        (v) =>
            v == null ? null : Coordinate.fromJson(v as Map<String, dynamic>),
      ),
      magnitude: $checkedConvert(
        'magnitude',
        (v) => EarthquakeMagnitude.fromJson(v as Map<String, dynamic>),
      ),
      depth: $checkedConvert(
        'depth',
        (v) => EarthquakeDepth.fromJson(v as Map<String, dynamic>),
      ),
      detailedCode: $checkedConvert('detailed_code', (v) => v as String?),
      detailedName: $checkedConvert('detailed_name', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'detailedCode': 'detailed_code',
    'detailedName': 'detailed_name',
  },
);

Map<String, dynamic> _$EarthquakeHypocenterToJson(
  _EarthquakeHypocenter instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'coordinates': instance.coordinates,
  'magnitude': instance.magnitude,
  'depth': instance.depth,
  'detailed_code': instance.detailedCode,
  'detailed_name': instance.detailedName,
};
