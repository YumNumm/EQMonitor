// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'catalog_station_max_acceleration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogStationMaxAcceleration _$CatalogStationMaxAccelerationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_CatalogStationMaxAcceleration',
  json,
  ($checkedConvert) {
    final val = _CatalogStationMaxAcceleration(
      synthesizedGal: $checkedConvert('synthesized_gal', (v) => v as num?),
      nsGal: $checkedConvert('ns_gal', (v) => v as num?),
      ewGal: $checkedConvert('ew_gal', (v) => v as num?),
      udGal: $checkedConvert('ud_gal', (v) => v as num?),
    );
    return val;
  },
  fieldKeyMap: const {
    'synthesizedGal': 'synthesized_gal',
    'nsGal': 'ns_gal',
    'ewGal': 'ew_gal',
    'udGal': 'ud_gal',
  },
);

Map<String, dynamic> _$CatalogStationMaxAccelerationToJson(
  _CatalogStationMaxAcceleration instance,
) => <String, dynamic>{
  'synthesized_gal': ?instance.synthesizedGal,
  'ns_gal': ?instance.nsGal,
  'ew_gal': ?instance.ewGal,
  'ud_gal': ?instance.udGal,
};
