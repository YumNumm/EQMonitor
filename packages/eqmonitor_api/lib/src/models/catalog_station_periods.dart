// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog_station_period_component.dart';

part 'catalog_station_periods.freezed.dart';
part 'catalog_station_periods.g.dart';

/// 最大加速度発現時の周期・卓越周期（南北・東西・上下成分）。flagのみが記録され数値(value)が欠測の組み合わせが実データに存在するため、その場合はvalueを省略してflagのみ保持する
@Freezed()
abstract class CatalogStationPeriods with _$CatalogStationPeriods {
  const factory CatalogStationPeriods({
    @JsonKey(includeIfNull: false)
    CatalogStationPeriodComponent? ns,
    @JsonKey(includeIfNull: false)
    CatalogStationPeriodComponent? ew,
    @JsonKey(includeIfNull: false)
    CatalogStationPeriodComponent? ud,
  }) = _CatalogStationPeriods;

  factory CatalogStationPeriods.fromJson(Map<String, Object?> json) => _$CatalogStationPeriodsFromJson(json);
}
