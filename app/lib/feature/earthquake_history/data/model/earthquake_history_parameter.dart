import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_parameter.freezed.dart';

@freezed
class EarthquakeHistoryParameter with _$EarthquakeHistoryParameter {
  const factory EarthquakeHistoryParameter({
    double? magnitudeLte,
    double? magnitudeGte,
    double? depthLte,
    double? depthGte,
    JmaIntensity? intensityLte,
    JmaIntensity? intensityGte,
  }) = _EarthquakeHistoryParameter;
}

extension EarthquakeHistoryParameterEx on EarthquakeHistoryParameter {
  EarthquakeHistoryParameter updateIntensity(
    JmaIntensity? min,
    JmaIntensity? max,
  ) =>
      copyWith(
        intensityGte: IntensityFilterChip.initialMin == min ? null : min,
        intensityLte: IntensityFilterChip.initialMax == max ? null : max,
      );

  EarthquakeHistoryParameter updateMagnitude(
    double? min,
    double? max,
  ) =>
      copyWith(
        magnitudeGte: MagnitudeFilterChip.initialMin == min ? null : min,
        magnitudeLte: MagnitudeFilterChip.initialMax == max ? null : max,
      );

  EarthquakeHistoryParameter updateDepth(
    double? min,
    double? max,
  ) =>
      copyWith(
        depthGte: DepthFilterChip.initialMin == min ? null : min,
        depthLte: DepthFilterChip.initialMax == max ? null : max,
      );
}
