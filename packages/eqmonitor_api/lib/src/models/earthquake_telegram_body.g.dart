// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_telegram_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeTelegramBody _$EarthquakeTelegramBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeTelegramBody', json, ($checkedConvert) {
  final val = _EarthquakeTelegramBody(
    type: $checkedConvert('type', (v) => v),
    earthquake: $checkedConvert(
      'earthquake',
      (v) => v == null
          ? null
          : EarthquakeTelegramBodyQuake.fromJson(v as Map<String, dynamic>),
    ),
    intensityRegions: $checkedConvert(
      'intensityRegions',
      (v) => (v as List<dynamic>?)
          ?.map(
            (e) => EarthquakeTelegramBodyIntensityRegion.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
    intensityPrefectures: $checkedConvert(
      'intensityPrefectures',
      (v) => (v as List<dynamic>?)
          ?.map(
            (e) => EarthquakeTelegramBodyIntensityRegion.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
    intensityCities: $checkedConvert(
      'intensityCities',
      (v) => (v as List<dynamic>?)
          ?.map(
            (e) => EarthquakeTelegramBodyIntensityRegion.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
    intensityStations: $checkedConvert(
      'intensityStations',
      (v) => (v as List<dynamic>?)
          ?.map(
            (e) => EarthquakeTelegramBodyIntensityStation.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeTelegramBodyToJson(
  _EarthquakeTelegramBody instance,
) => <String, dynamic>{
  'type': instance.type,
  'earthquake': ?instance.earthquake,
  'intensityRegions': ?instance.intensityRegions,
  'intensityPrefectures': ?instance.intensityPrefectures,
  'intensityCities': ?instance.intensityCities,
  'intensityStations': ?instance.intensityStations,
};
