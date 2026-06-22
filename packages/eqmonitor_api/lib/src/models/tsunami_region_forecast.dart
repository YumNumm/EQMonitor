// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_region_forecast_first_height.dart';
import 'tsunami_region_forecast_max_height.dart';

part 'tsunami_region_forecast.freezed.dart';
part 'tsunami_region_forecast.g.dart';

@Freezed()
abstract class TsunamiRegionForecast with _$TsunamiRegionForecast {
  const factory TsunamiRegionForecast({
    @JsonKey(includeIfNull: false,name: 'first_height')
    TsunamiRegionForecastFirstHeight? firstHeight,
    @JsonKey(includeIfNull: false,name: 'max_height')
    TsunamiRegionForecastMaxHeight? maxHeight,
  }) = _TsunamiRegionForecast;
  
  factory TsunamiRegionForecast.fromJson(Map<String, Object?> json) => _$TsunamiRegionForecastFromJson(json);
}
