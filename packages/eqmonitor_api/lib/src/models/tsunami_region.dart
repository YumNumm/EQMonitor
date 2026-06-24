// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_region_estimation.dart';
import 'tsunami_region_forecast.dart';
import 'tsunami_region_station.dart';
import 'tsunami_warning_kind.dart';

part 'tsunami_region.freezed.dart';
part 'tsunami_region.g.dart';

@Freezed()
abstract class TsunamiRegion with _$TsunamiRegion {
  const factory TsunamiRegion({
    /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
    required String code,
    required String name,
    required TsunamiWarningKind kind,
    @JsonKey(name: 'last_kind')
    required TsunamiWarningKind lastKind,
    required List<TsunamiRegionStation> stations,
    @JsonKey(includeIfNull: false)
    TsunamiRegionForecast? forecast,
    @JsonKey(includeIfNull: false)
    TsunamiRegionEstimation? estimation,
  }) = _TsunamiRegion;
  
  factory TsunamiRegion.fromJson(Map<String, Object?> json) => _$TsunamiRegionFromJson(json);
}
