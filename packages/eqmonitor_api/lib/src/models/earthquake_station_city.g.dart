// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_station_city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeStationCity _$EarthquakeStationCityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeStationCity', json, ($checkedConvert) {
  final val = _EarthquakeStationCity(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert(
      'name',
      (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
    ),
    kana: $checkedConvert('kana', (v) => v as String?),
    stations: $checkedConvert(
      'stations',
      (v) => (v as List<dynamic>)
          .map((e) => EarthquakeStation.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeStationCityToJson(
  _EarthquakeStationCity instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'kana': instance.kana,
  'stations': instance.stations,
};
