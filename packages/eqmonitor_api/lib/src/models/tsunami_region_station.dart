// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_station_forecast.dart';
import 'tsunami_station_observation.dart';

part 'tsunami_region_station.freezed.dart';
part 'tsunami_region_station.g.dart';

@Freezed()
abstract class TsunamiRegionStation with _$TsunamiRegionStation {
  const factory TsunamiRegionStation({
    /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
    required String code,
    required String name,
    @JsonKey(includeIfNull: false) TsunamiStationForecast? forecast,
    @JsonKey(includeIfNull: false) TsunamiStationObservation? observation,
  }) = _TsunamiRegionStation;

  factory TsunamiRegionStation.fromJson(Map<String, Object?> json) =>
      _$TsunamiRegionStationFromJson(json);
}
