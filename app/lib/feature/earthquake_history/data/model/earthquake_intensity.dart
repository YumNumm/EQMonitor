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
    required Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,
    required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>
    lpgmIntensityTree,
  }) = _EarthquakeIntensity;

  factory EarthquakeIntensity.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeIntensityFromJson(json);
}

extension EarthquakeIntensityApiExtension on api.Intensity {
  EarthquakeIntensity toEarthquakeIntensity({
    required EarthquakeParameter parameter,
  }) {
    final converter = IntensityTreeConverter(parameter: parameter);
    return EarthquakeIntensity(
      maxIntensity: maxIntensity.toJmaIntensity,
      maxLpgmIntensity: maxLpgmIntensity?.toJmaLpgmIntensity,
      intensityTree: converter.convertToIntensityTree(
        intensity: this,
      ),
      lpgmIntensityTree: converter.convertToLpgmIntensityTree(
        intensity: this,
      ),
    );
  }
}
