// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_station_region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeStationRegion _$EarthquakeStationRegionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeStationRegion', json, ($checkedConvert) {
  final val = _EarthquakeStationRegion(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert(
      'name',
      (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
    ),
    kana: $checkedConvert('kana', (v) => v as String?),
    cities: $checkedConvert(
      'cities',
      (v) => (v as List<dynamic>)
          .map((e) => EarthquakeStationCity.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeStationRegionToJson(
  _EarthquakeStationRegion instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'kana': instance.kana,
  'cities': instance.cities,
};
