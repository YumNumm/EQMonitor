// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog_period_value.dart';

part 'catalog_station_period_component.freezed.dart';
part 'catalog_station_period_component.g.dart';

@Freezed()
abstract class CatalogStationPeriodComponent with _$CatalogStationPeriodComponent {
  const factory CatalogStationPeriodComponent({
    @JsonKey(includeIfNull: false,name: 'max_accel_period')
    CatalogPeriodValue? maxAccelPeriod,
    @JsonKey(includeIfNull: false,name: 'predominant_period')
    CatalogPeriodValue? predominantPeriod,
  }) = _CatalogStationPeriodComponent;

  factory CatalogStationPeriodComponent.fromJson(Map<String, Object?> json) => _$CatalogStationPeriodComponentFromJson(json);
}
