// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_station_prefecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeStationPrefecture _$EarthquakeStationPrefectureFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeStationPrefecture', json, ($checkedConvert) {
  final val = _EarthquakeStationPrefecture(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert(
      'name',
      (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
    ),
    regions: $checkedConvert(
      'regions',
      (v) => (v as List<dynamic>)
          .map(
            (e) => EarthquakeStationRegion.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeStationPrefectureToJson(
  _EarthquakeStationPrefecture instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'regions': instance.regions,
};
