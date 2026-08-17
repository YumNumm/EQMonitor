import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_station.freezed.dart';
part 'intensity_station.g.dart';

@freezed
abstract class IntensityStation with _$IntensityStation {
  const factory({
    required String code,
    required String name,
    required double? sva,
    required List<PrePeriod>? prePeriods,
    required JmaIntensity? maxIntensity,
    required JmaLpgmIntensity? maxLpgmIntensity,
  }) = _IntensityStation;

  factory fromJson(Map<String, dynamic> json) =>
      _$IntensityStationFromJson(json);
}

@freezed
abstract class PrePeriod with _$PrePeriod {
  const factory({
    required double band,
    required JmaLpgmIntensity lpgmIntensity,
    required double sva,
  }) = _PrePeriod;

  factory fromJson(Map<String, dynamic> json) =>
      _$PrePeriodFromJson(json);
}

extension IntensityStationApiExtension on api.IntensityStationItem {
  IntensityStation get toIntensityStation => IntensityStation(
    code: code,
    name: code,
    sva: sva?.toDouble(),
    prePeriods: prePeriods?.map((e) => e.toPrePeriod).toList(),
    maxIntensity: null,
    maxLpgmIntensity: null,
  );
}

extension PrePeriodApiExtension on api.LpgmPrePeriod {
  PrePeriod get toPrePeriod => PrePeriod(
    band: band.toDouble(),
    lpgmIntensity: lpgmIntensity.toJmaLpgmIntensity,
    sva: sva.toDouble(),
  );
}
