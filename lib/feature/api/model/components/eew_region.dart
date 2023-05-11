import 'package:eqmonitor/feature/api/model/components/eew_intensity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_region.freezed.dart';

@freezed
class EewRegion with _$EewRegion {
  const factory EewRegion({
    required String code,
    required String name,
    required bool isPlum,
    required bool isWarning,
    required ForecastMaxInt forecastMaxInt,
    required ForecastMaxLgInt? forecastMaxLgInt,

    /// undefinedの場合は null
    /// PLUM法の場合は最初にその階級震度を予測した時刻
    required DateTime? arrivalTime,
  }) = _EewRegion;

  factory EewRegion.fromJson(Map<String, dynamic> json) =>
      _$EewRegionFromJson(json);
}
