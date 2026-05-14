// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_stations_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeStationsParameter _$EarthquakeStationsParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeStationsParameter', json, ($checkedConvert) {
  final val = _EarthquakeStationsParameter(
    metadata: $checkedConvert(
      'metadata',
      (v) => ParameterMetadata.fromJson(v as Map<String, dynamic>),
    ),
    prefectures: $checkedConvert(
      'prefectures',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                EarthquakeStationPrefecture.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeStationsParameterToJson(
  _EarthquakeStationsParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'prefectures': instance.prefectures,
};
