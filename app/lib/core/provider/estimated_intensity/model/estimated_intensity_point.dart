import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'estimated_intensity_point.freezed.dart';

@Freezed(toJson: false)
abstract class EstimatedIntensityPoint with _$EstimatedIntensityPoint {
  const factory EstimatedIntensityPoint({
    required String regionCode,
    required String cityCode,
    required EarthquakeParameterStationItem station,
    required double intensity,
  }) = _EstimatedIntensityPoint;
}
