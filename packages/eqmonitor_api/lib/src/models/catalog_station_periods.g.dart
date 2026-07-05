// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'catalog_station_periods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogStationPeriods _$CatalogStationPeriodsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_CatalogStationPeriods', json, ($checkedConvert) {
  final val = _CatalogStationPeriods(
    ns: $checkedConvert(
      'ns',
      (v) => v == null
          ? null
          : CatalogStationPeriodComponent.fromJson(v as Map<String, dynamic>),
    ),
    ew: $checkedConvert(
      'ew',
      (v) => v == null
          ? null
          : CatalogStationPeriodComponent.fromJson(v as Map<String, dynamic>),
    ),
    ud: $checkedConvert(
      'ud',
      (v) => v == null
          ? null
          : CatalogStationPeriodComponent.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$CatalogStationPeriodsToJson(
  _CatalogStationPeriods instance,
) => <String, dynamic>{
  'ns': ?instance.ns,
  'ew': ?instance.ew,
  'ud': ?instance.ud,
};
