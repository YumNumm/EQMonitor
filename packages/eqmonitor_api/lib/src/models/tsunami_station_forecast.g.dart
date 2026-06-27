// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_station_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiStationForecast _$TsunamiStationForecastFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiStationForecast',
  json,
  ($checkedConvert) {
    final val = _TsunamiStationForecast(
      highTideAt: $checkedConvert(
        'high_tide_at',
        (v) => DateTime.parse(v as String),
      ),
      firstHeight: $checkedConvert(
        'first_height',
        (v) =>
            v == null ? null : FirstHeight2.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'highTideAt': 'high_tide_at',
    'firstHeight': 'first_height',
  },
);

Map<String, dynamic> _$TsunamiStationForecastToJson(
  _TsunamiStationForecast instance,
) => <String, dynamic>{
  'high_tide_at': instance.highTideAt.toIso8601String(),
  'first_height': ?instance.firstHeight,
};
