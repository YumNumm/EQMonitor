import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_observation_point_types/kyoshin_observation_point.pb.dart';

part 'shake_detection_kmoni_merged_event.freezed.dart';
part 'shake_detection_kmoni_merged_event.g.dart';

@freezed
class ShakeDetectionKmoniMergedEvent with _$ShakeDetectionKmoniMergedEvent {
  const factory ShakeDetectionKmoniMergedEvent({
    required ShakeDetectionEvent event,
    required List<ShakeDetectionKmoniMergedRegion> regions,
  }) = _ShakeDetectionKmoniMergedEvent;

  factory ShakeDetectionKmoniMergedEvent.fromJson(Map<String, dynamic> json) =>
      _$ShakeDetectionKmoniMergedEventFromJson(json);
}

@freezed
class ShakeDetectionKmoniMergedRegion with _$ShakeDetectionKmoniMergedRegion {
  const factory ShakeDetectionKmoniMergedRegion({
    required String name,
    @JsonKey(
      name: 'maxIntensity',
      unknownEnumValue: JmaForecastIntensity.unknown,
      defaultValue: JmaForecastIntensity.unknown,
    )
    required JmaForecastIntensity maxIntensity,
    required List<ShakeDetectionKmoniMergedPoint> points,
  }) = _ShakeDetectionKmoniMergedRegion;

  factory ShakeDetectionKmoniMergedRegion.fromJson(Map<String, dynamic> json) =>
      _$ShakeDetectionKmoniMergedRegionFromJson(json);
}

@freezed
class ShakeDetectionKmoniMergedPoint with _$ShakeDetectionKmoniMergedPoint {
  const factory ShakeDetectionKmoniMergedPoint({
    @JsonKey(
      unknownEnumValue: JmaForecastIntensity.unknown,
      defaultValue: JmaForecastIntensity.unknown,
    )
    required JmaForecastIntensity intensity,
    required String code,
    @JsonKey(
      fromJson: KyoshinObservationPoint.fromJson,
      toJson: _pointToJson,
    )
    required KyoshinObservationPoint point,
  }) = _ShakeDetectionKmoniMergedPoint;

  factory ShakeDetectionKmoniMergedPoint.fromJson(Map<String, dynamic> json) =>
      _$ShakeDetectionKmoniMergedPointFromJson(json);
}

Map<String, dynamic> _pointToJson(KyoshinObservationPoint point) =>
    point.writeToJsonMap();
