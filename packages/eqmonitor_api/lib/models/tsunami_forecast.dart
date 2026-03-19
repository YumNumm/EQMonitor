// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_forecast_first_height.dart';
import 'tsunami_forecast_max_height.dart';
import 'tsunami_forecast_station.dart';
import 'tsunami_warning_kind.dart';

part 'tsunami_forecast.freezed.dart';
part 'tsunami_forecast.g.dart';

@Freezed()
abstract class TsunamiForecast with _$TsunamiForecast {
  const factory TsunamiForecast({
    required String code,
    required String name,
    required TsunamiWarningKind kind,
    @JsonKey(name: 'last_kind') required TsunamiWarningKind lastKind,
    @JsonKey(includeIfNull: false, name: 'first_height')
    TsunamiForecastFirstHeight? firstHeight,
    @JsonKey(includeIfNull: false, name: 'max_height')
    TsunamiForecastMaxHeight? maxHeight,
    @JsonKey(includeIfNull: false) List<TsunamiForecastStation>? stations,
  }) = _TsunamiForecast;

  factory TsunamiForecast.fromJson(Map<String, Object?> json) =>
      _$TsunamiForecastFromJson(json);
}
