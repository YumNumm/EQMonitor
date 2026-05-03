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

extension EarthquakeIntensityMapLayer on EarthquakeIntensity {
  /// `areaForecastLocalE` の `code` と塗り分け震度（都道府県のみ／細分化地域）
  Iterable<({String code, JmaIntensity intensity})>
  get forecastLocalEIntensityPairs sync* {
    for (final entry in intensityTree.entries) {
      final level = entry.key;
      for (final pref in entry.value) {
        if (pref.cities.isEmpty) {
          final j = pref.region.maxIntensity ?? level;
          yield (code: pref.region.region.code, intensity: j);
        } else {
          for (final city in pref.cities) {
            final j = city.maxIntensity;
            if (j != null) {
              yield (code: city.city.code, intensity: j);
            }
          }
        }
      }
    }
  }
}
