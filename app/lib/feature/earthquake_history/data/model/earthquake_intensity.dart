import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor_api/export.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_intensity.freezed.dart';
part 'earthquake_intensity.g.dart';

@freezed
abstract class EarthquakeIntensity with _$EarthquakeIntensity {
  const factory EarthquakeIntensity({
    required JmaIntensity maxIntensity,
    required JmaLpgmIntensity? maxLpgmIntensity,
    required Map<JmaIntensity, List<RegionIntensityNode>> intensityTree,
    required Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>>
    lpgmIntensityTree,
  }) = _EarthquakeIntensity;

  factory EarthquakeIntensity.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeIntensityFromJson(json);
}

extension EarthquakeIntensityApiExtension on api.Intensity {
  EarthquakeIntensity get toEarthquakeIntensity => EarthquakeIntensity(
    maxIntensity: maxIntensity.toJmaIntensity,
    maxLpgmIntensity: maxLpgmIntensity?.toJmaLpgmIntensity,
    intensityTree: {},
    lpgmIntensityTree: {},
  );
}
