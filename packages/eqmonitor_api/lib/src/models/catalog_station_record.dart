// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog_station_intensity.dart';
import 'catalog_station_max_acceleration.dart';
import 'catalog_station_periods.dart';

part 'catalog_station_record.freezed.dart';
part 'catalog_station_record.g.dart';

@Freezed()
abstract class CatalogStationRecord with _$CatalogStationRecord {
  const factory CatalogStationRecord({
    @JsonKey(name: 'station_code')
    required String stationCode,
    required CatalogStationIntensity intensity,
    @JsonKey(includeIfNull: false,name: 'observed_at')
    DateTime? observedAt,
    @JsonKey(includeIfNull: false,name: 'max_acceleration')
    CatalogStationMaxAcceleration? maxAcceleration,

    /// 最大加速度（合成値）を観測した時刻
    @JsonKey(includeIfNull: false,name: 'max_accel_time')
    DateTime? maxAccelTime,
    @JsonKey(includeIfNull: false)
    CatalogStationPeriods? periods,

    /// 観測回数。震源レコードのレコード種別フラグがM,H,Dの場合のみ記録される
    @JsonKey(includeIfNull: false,name: 'observation_count')
    int? observationCount,
  }) = _CatalogStationRecord;

  factory CatalogStationRecord.fromJson(Map<String, Object?> json) => _$CatalogStationRecordFromJson(json);
}
