import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_location_intensity_display.freezed.dart';

/// 現在地に対応する震度表示（震度速報ベース）。
@freezed
abstract class CurrentLocationIntensityDisplay
    with _$CurrentLocationIntensityDisplay {
  const factory CurrentLocationIntensityDisplay({
    required JmaIntensity intensity,

    /// 市区町村ポリゴン（areaInformationCity）に一致するデータか。
    /// false のときは細分区域（areaForecastLocalE）フォールバック。
    required bool usedCityLevelData,
  }) = _CurrentLocationIntensityDisplay;
}
