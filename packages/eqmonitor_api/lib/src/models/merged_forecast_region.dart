// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'estimation.dart';
import 'observation.dart';
import 'tsunami_forecast_first_height.dart';
import 'tsunami_forecast_max_height.dart';
import 'tsunami_forecast_station.dart';
import 'tsunami_warning_kind.dart';

part 'merged_forecast_region.freezed.dart';
part 'merged_forecast_region.g.dart';

@Freezed()
abstract class MergedForecastRegion with _$MergedForecastRegion {
  const factory MergedForecastRegion({
    required String code,
    required String name,
    required TsunamiWarningKind kind,
    @JsonKey(includeIfNull: false,name: 'kind_code')
    String? kindCode,
    @JsonKey(includeIfNull: false,name: 'last_kind')
    TsunamiWarningKind? lastKind,
    @JsonKey(includeIfNull: false,name: 'first_height')
    TsunamiForecastFirstHeight? firstHeight,
    @JsonKey(includeIfNull: false,name: 'max_height')
    TsunamiForecastMaxHeight? maxHeight,
    @JsonKey(includeIfNull: false)
    List<TsunamiForecastStation>? stations,
    @JsonKey(includeIfNull: false)
    Observation? observation,
    @JsonKey(includeIfNull: false)
    Estimation? estimation,
  }) = _MergedForecastRegion;
  
  factory MergedForecastRegion.fromJson(Map<String, Object?> json) => _$MergedForecastRegionFromJson(json);
}
