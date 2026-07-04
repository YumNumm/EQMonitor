// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_station_record.freezed.dart';
part 'catalog_station_record.g.dart';

@Freezed()
abstract class CatalogStationRecord with _$CatalogStationRecord {
  const factory CatalogStationRecord({
    @JsonKey(name: 'station_code')
    required String stationCode,
    @JsonKey(includeIfNull: true,name: 'intensity_raw')
    required String? intensityRaw,
    @JsonKey(includeIfNull: true,name: 'instrumental_intensity')
    required num? instrumentalIntensity,
    @JsonKey(includeIfNull: true,name: 'max_accel_synthesized_gal')
    required num? maxAccelSynthesizedGal,
    @JsonKey(includeIfNull: true,name: 'max_accel_ns_gal')
    required num? maxAccelNsGal,
    @JsonKey(includeIfNull: true,name: 'max_accel_ew_gal')
    required num? maxAccelEwGal,
    @JsonKey(includeIfNull: true,name: 'max_accel_ud_gal')
    required num? maxAccelUdGal,
    @JsonKey(includeIfNull: true,name: 'max_accel_period_ns')
    required num? maxAccelPeriodNs,
    @JsonKey(includeIfNull: true,name: 'predominant_period_ns')
    required num? predominantPeriodNs,
    @JsonKey(includeIfNull: true,name: 'max_accel_period_ew')
    required num? maxAccelPeriodEw,
    @JsonKey(includeIfNull: true,name: 'predominant_period_ew')
    required num? predominantPeriodEw,
    @JsonKey(includeIfNull: true,name: 'max_accel_period_ud')
    required num? maxAccelPeriodUd,
    @JsonKey(includeIfNull: true,name: 'predominant_period_ud')
    required num? predominantPeriodUd,
    @JsonKey(includeIfNull: false,name: 'occurrence_time')
    DateTime? occurrenceTime,
  }) = _CatalogStationRecord;
  
  factory CatalogStationRecord.fromJson(Map<String, Object?> json) => _$CatalogStationRecordFromJson(json);
}
