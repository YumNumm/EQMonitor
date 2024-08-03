import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqapi_types/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_early_parameter.freezed.dart';
part 'earthquake_history_early_parameter.g.dart';

@freezed
class EarthquakeHistoryEarlyParameter with _$EarthquakeHistoryEarlyParameter {
  const factory EarthquakeHistoryEarlyParameter({
    double? magnitudeLte,
    double? magnitudeGte,
    double? depthLte,
    double? depthGte,
    JmaIntensity? intensityLte,
    JmaIntensity? intensityGte,
    required EarthquakeEarlySortType sort,
    required bool ascending,
  }) = _EarthquakeHistoryEarlyParameter;

  factory EarthquakeHistoryEarlyParameter.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryEarlyParameterFromJson(json);
}

extension EarthquakeHistoryEarlyParameterEx on EarthquakeHistoryEarlyParameter {
  EarthquakeHistoryEarlyParameter updateIntensity(
    JmaIntensity? min,
    JmaIntensity? max,
  ) =>
      copyWith(
        intensityGte: min,
        intensityLte: max,
      );

  EarthquakeHistoryEarlyParameter updateMagnitude(
    double? min,
    double? max,
  ) =>
      copyWith(
        magnitudeGte: min,
        magnitudeLte: max,
      );

  EarthquakeHistoryEarlyParameter updateDepth(
    double? min,
    double? max,
  ) =>
      copyWith(
        depthGte: min,
        depthLte: max,
      );

  EarthquakeHistoryEarlyParameter updateSort({
    required EarthquakeEarlySortType type,
    required bool ascending,
  }) =>
      copyWith(
        sort: type,
        ascending: ascending,
      );
}
