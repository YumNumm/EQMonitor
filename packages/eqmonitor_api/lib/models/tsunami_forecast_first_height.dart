// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'first_height_condition.dart';

part 'tsunami_forecast_first_height.freezed.dart';
part 'tsunami_forecast_first_height.g.dart';

@Freezed()
abstract class TsunamiForecastFirstHeight with _$TsunamiForecastFirstHeight {
  const factory TsunamiForecastFirstHeight({
    @JsonKey(name: 'arrival_time')
    required DateTime arrivalTime,
    required FirstHeightCondition condition,
  }) = _TsunamiForecastFirstHeight;
  
  factory TsunamiForecastFirstHeight.fromJson(Map<String, Object?> json) => _$TsunamiForecastFirstHeightFromJson(json);
}
