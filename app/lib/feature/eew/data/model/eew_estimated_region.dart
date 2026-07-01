import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_estimated_region.freezed.dart';

@Freezed(toJson: false)
abstract class EewEstimatedRegion with _$EewEstimatedRegion {
  const factory EewEstimatedRegion({
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
