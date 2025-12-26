import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/status_filter_chip.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_parameter.freezed.dart';

@freezed
abstract class EarthquakeHistoryParameter with _$EarthquakeHistoryParameter {
  const factory EarthquakeHistoryParameter({
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    IntensityValue? intensityLte,
    IntensityValue? intensityGte,
    List<TelegramStatus>? statuses,
  }) = _EarthquakeHistoryParameter;
}

extension EarthquakeHistoryParameterEx on EarthquakeHistoryParameter {
  EarthquakeHistoryParameter updateIntensity(
    IntensityValue? min,
    IntensityValue? max,
  ) => copyWith(
    intensityGte: IntensityFilterChip.initialMin == min ? null : min,
    intensityLte: IntensityFilterChip.initialMax == max ? null : max,
  );

  EarthquakeHistoryParameter updateMagnitude(double? min, double? max) =>
      copyWith(
        magnitudeGte: MagnitudeFilterChip.initialMin == min ? null : min,
        magnitudeLte: MagnitudeFilterChip.initialMax == max ? null : max,
      );

  EarthquakeHistoryParameter updateDepth(int? min, int? max) => copyWith(
    depthGte: DepthFilterChip.initialMin == min ? null : min,
    depthLte: DepthFilterChip.initialMax == max ? null : max,
  );

  EarthquakeHistoryParameter updateStatuses(List<TelegramStatus>? statuses) {
    final isDefault =
        statuses == null ||
        const ListEquality<TelegramStatus>().equals(
          statuses,
          StatusFilterChip.initialStatuses,
        );
    return copyWith(statuses: isDefault ? null : statuses);
  }
}
