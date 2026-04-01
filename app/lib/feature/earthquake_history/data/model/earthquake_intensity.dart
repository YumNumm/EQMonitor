import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jma_parameter_types/earthquake_param.pb.dart';

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
  EarthquakeIntensity toEarthquakeIntensity({
    required EarthquakeParameter parameter,
  }) => EarthquakeIntensity(
    maxIntensity: maxIntensity.toJmaIntensity,
    maxLpgmIntensity: maxLpgmIntensity?.toJmaLpgmIntensity,
    intensityTree: convertToIntensityTree(
      intensity: this,
      parameter: parameter,
    ),
    lpgmIntensityTree: convertToLpgmIntensityTree(
      intensity: this,
      parameter: parameter,
    ),
  );
}
