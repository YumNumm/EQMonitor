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
    required List<IntensityRegion> regions,
    required Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>>
    lpgmIntensityTree,
    required List<LpgmIntensityRegion> lpgmRegions,
  }) = _EarthquakeIntensity;

  factory EarthquakeIntensity.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeIntensityFromJson(json);
}

extension EarthquakeIntensityApiExtension on api.Intensity {
  EarthquakeIntensity toEarthquakeIntensity({
    required EarthquakeParameter parameter,
  }) {
    final paramRegionMap = {for (final r in parameter.regions) r.code: r};
    return EarthquakeIntensity(
      maxIntensity: maxIntensity.toJmaIntensity,
      maxLpgmIntensity: maxLpgmIntensity?.toJmaLpgmIntensity,
      intensityTree: convertToIntensityTree(
        intensity: this,
        parameter: parameter,
        cities: cities,
        stations: stations,
      ),
      regions: regions.map((e) {
        final paramRegion = paramRegionMap[e.value.code];
        if (paramRegion == null) {
          return null;
        }
        return IntensityRegion(
          region: paramRegion,
          maxIntensity: e.maxIntensity?.toJmaIntensity,
        );
      }).whereType<IntensityRegion>().toList(),
      lpgmIntensityTree: convertToLpgmIntensityTree(
        intensity: this,
        parameter: parameter,
        cities: cities,
        stations: stations,
      ),
      lpgmRegions: regions.map((e) {
        final paramRegion = paramRegionMap[e.value.code];
        if (paramRegion == null) {
          return null;
        }
        return LpgmIntensityRegion(
          region: paramRegion,
          maxLpgmIntensity: e.maxLpgmIntensity?.toJmaLpgmIntensity,
        );
      }).whereType<LpgmIntensityRegion>().toList(),
    );
  }
}
