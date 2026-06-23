// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'first_height2.dart';

part 'tsunami_station_forecast.freezed.dart';
part 'tsunami_station_forecast.g.dart';

@Freezed()
abstract class TsunamiStationForecast with _$TsunamiStationForecast {
  const factory TsunamiStationForecast({
    @JsonKey(name: 'high_tide_at') required DateTime highTideAt,
    @JsonKey(includeIfNull: false, name: 'first_height')
    FirstHeight2? firstHeight,
  }) = _TsunamiStationForecast;

  factory TsunamiStationForecast.fromJson(Map<String, Object?> json) =>
      _$TsunamiStationForecastFromJson(json);
}
