// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'first_height_condition.dart';
import 'revise.dart';

part 'tsunami_station_forecast_first_height.freezed.dart';
part 'tsunami_station_forecast_first_height.g.dart';

@Freezed()
abstract class TsunamiStationForecastFirstHeight with _$TsunamiStationForecastFirstHeight {
  const factory TsunamiStationForecastFirstHeight({
    /// まだ津波が到達していない場合、到達していないと推測される場合に出現する
    @JsonKey(includeIfNull: false,name: 'arrival_time')
    DateTime? arrivalTime,
    @JsonKey(includeIfNull: false)
    FirstHeightCondition? condition,
    @JsonKey(includeIfNull: false)
    Revise? revise,
  }) = _TsunamiStationForecastFirstHeight;

  factory TsunamiStationForecastFirstHeight.fromJson(Map<String, Object?> json) => _$TsunamiStationForecastFirstHeightFromJson(json);
}
