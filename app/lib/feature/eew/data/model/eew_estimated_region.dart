import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_estimated_region.freezed.dart';

@Freezed(toJson: false)
abstract class EewEstimatedRegion with _$EewEstimatedRegion {
  const factory({
    required String regionCode,
    required String regionName,
    required double intensity,
    JmaIntensity? jmaIntensity,
    DateTime? sWaveArrivalTime,
    @Default(false) bool isArrived,
  }) = _EewEstimatedRegion;
}

extension EewEstimatedRegionConversion on EewEstimatedRegion {
  EewForecastRegionInfo toForecastRegionInfo() => EewForecastRegionInfo(
    code: regionCode,
    name: regionName,
    isPlum: false,
    isWarning: false,
    intensity: jmaIntensity ?? JmaIntensity.unknown,
    intensityIsOver: false,
    arrivalTime: sWaveArrivalTime,
    isArrived: isArrived,
  );
}

extension EewEstimatedRegionList on List<EewEstimatedRegion> {
  /// JMA 予報区域に含まれない推定震度のみを返す（地図の additionalRegions 用）。
  List<EewForecastRegionInfo> additionalForecastRegionsFor({
    required EewTelegramItem eew,
  }) {
    final jmaCodes = (eew.forecastIntensity?.regions ?? [])
        .map((region) => region.code)
        .toSet();
    return where((region) => !jmaCodes.contains(region.regionCode))
        .where((region) => region.jmaIntensity != null)
        .map((region) => region.toForecastRegionInfo())
        .toList();
  }
}
