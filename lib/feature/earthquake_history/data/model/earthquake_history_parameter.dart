import 'package:eqapi_types/eqapi_types.dart';
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
