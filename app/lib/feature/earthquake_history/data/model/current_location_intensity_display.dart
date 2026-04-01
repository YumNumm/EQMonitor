import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:meta/meta.dart';

/// 現在地に対応する震度表示（震度速報ベース）。
@immutable
class CurrentLocationIntensityDisplay {
  const CurrentLocationIntensityDisplay({
    required this.intensity,
    required this.usedCityLevelData,
  });

  final JmaIntensity intensity;

  /// 市区町村ポリゴン（areaInformationCity）に一致するデータか。
  /// false のときは細分区域（areaForecastLocalE）フォールバック。
  final bool usedCityLevelData;
}
