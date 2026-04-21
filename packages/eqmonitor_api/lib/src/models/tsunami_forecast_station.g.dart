// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_forecast_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiForecastStation _$TsunamiForecastStationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiForecastStation',
  json,
  ($checkedConvert) {
    final val = _TsunamiForecastStation(
      code: $checkedConvert('code', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      highTideDateTime: $checkedConvert(
        'high_tide_date_time',
        (v) => DateTime.parse(v as String),
      ),
      firstHeight: $checkedConvert(
        'first_height',
        (v) => v == null
            ? null
            : TsunamiForecastFirstHeight.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'highTideDateTime': 'high_tide_date_time',
    'firstHeight': 'first_height',
  },
);

Map<String, dynamic> _$TsunamiForecastStationToJson(
  _TsunamiForecastStation instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'high_tide_date_time': instance.highTideDateTime.toIso8601String(),
  'first_height': ?instance.firstHeight,
};
