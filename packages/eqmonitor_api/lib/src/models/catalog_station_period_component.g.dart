// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'catalog_station_period_component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogStationPeriodComponent _$CatalogStationPeriodComponentFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_CatalogStationPeriodComponent',
  json,
  ($checkedConvert) {
    final val = _CatalogStationPeriodComponent(
      maxAccelPeriod: $checkedConvert(
        'max_accel_period',
        (v) => v == null
            ? null
            : CatalogPeriodValue.fromJson(v as Map<String, dynamic>),
      ),
      predominantPeriod: $checkedConvert(
        'predominant_period',
        (v) => v == null
            ? null
            : CatalogPeriodValue.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'maxAccelPeriod': 'max_accel_period',
    'predominantPeriod': 'predominant_period',
  },
);

Map<String, dynamic> _$CatalogStationPeriodComponentToJson(
  _CatalogStationPeriodComponent instance,
) => <String, dynamic>{
  'max_accel_period': ?instance.maxAccelPeriod,
  'predominant_period': ?instance.predominantPeriod,
};
