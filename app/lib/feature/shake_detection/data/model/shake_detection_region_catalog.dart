import 'package:eqmonitor/feature/parameter/data/model/kyoshin/kyoshin_observation_points_parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_region_catalog.freezed.dart';
part 'shake_detection_region_catalog.g.dart';

@freezed
abstract class ShakeDetectionRegionCatalog with _$ShakeDetectionRegionCatalog {
  @JsonSerializable(explicitToJson: true)
  const factory({
    required List<KyoshinObservationPoint> stations,
    required Map<String, String> prefectureNames,
    required Map<String, String> regionNames,
  }) = _ShakeDetectionRegionCatalog;

  factory fromJson(Map<String, dynamic> json) =>
      _$ShakeDetectionRegionCatalogFromJson(json);
}
