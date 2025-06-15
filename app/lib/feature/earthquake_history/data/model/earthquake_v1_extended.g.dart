// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'earthquake_v1_extended.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeV1Extended _$EarthquakeV1ExtendedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeV1Extended',
  json,
  ($checkedConvert) {
    final val = _EarthquakeV1Extended(
      earthquake: $checkedConvert(
        'earthquake',
        (v) => EarthquakeV1.fromJson(v as Map<String, dynamic>),
      ),
      maxIntensityRegionNames: $checkedConvert(
        'max_intensity_region_names',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'maxIntensityRegionNames': 'max_intensity_region_names'},
);

Map<String, dynamic> _$EarthquakeV1ExtendedToJson(
  _EarthquakeV1Extended instance,
) => <String, dynamic>{
  'earthquake': instance.earthquake,
  'max_intensity_region_names': instance.maxIntensityRegionNames,
};
