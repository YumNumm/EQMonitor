// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_forecast_first_height.dart';

part 'tsunami_forecast_station.freezed.dart';
part 'tsunami_forecast_station.g.dart';

@Freezed()
abstract class TsunamiForecastStation with _$TsunamiForecastStation {
  const factory TsunamiForecastStation({
    required String code,
    required String name,
    @JsonKey(name: 'high_tide_date_time') required DateTime highTideDateTime,
    @JsonKey(includeIfNull: false, name: 'first_height')
    TsunamiForecastFirstHeight? firstHeight,
  }) = _TsunamiForecastStation;

  factory TsunamiForecastStation.fromJson(Map<String, Object?> json) =>
      _$TsunamiForecastStationFromJson(json);
}
