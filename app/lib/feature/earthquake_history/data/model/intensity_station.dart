import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_station.freezed.dart';
part 'intensity_station.g.dart';

@freezed
abstract class IntensityStation with _$IntensityStation {
  const factory IntensityStation({
    required String code,
    required String name,
    required double sva,
    required List<PrePeriod> prePeriods,
    required JmaIntensity? maxIntensity,
    required JmaLpgmIntensity? maxLpgmIntensity,
  }) = _IntensityStation;

  factory IntensityStation.fromJson(Map<String, dynamic> json) =>
      _$IntensityStationFromJson(json);
}

@freezed
abstract class PrePeriod with _$PrePeriod {
  const factory PrePeriod({
    required double band,
    required JmaLpgmIntensity lpgmIntensity,
    required double sva,
  }) = _PrePeriod;

  factory PrePeriod.fromJson(Map<String, dynamic> json) =>
      _$PrePeriodFromJson(json);
}

extension IntensityStationApiExtension on api.IntensityStationItem {
  IntensityStation get toIntensityStation => IntensityStation(
    code: value.code,
    name: value.name,
    sva: sva.toDouble(),
    prePeriods: prePeriods.map((e) => e.toPrePeriod).toList(),
    maxIntensity: maxIntensity?.toJmaIntensity,
    maxLpgmIntensity: maxLpgmIntensity?.toJmaLpgmIntensity,
  );
}

extension PrePeriodApiExtension on api.PrePeriods {
  PrePeriod get toPrePeriod => PrePeriod(
    band: band.toDouble(),
    lpgmIntensity: lpgmIntensity.toJmaLpgmIntensity,
    sva: sva.toDouble(),
  );
}
