import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jma_parameter_types/earthquake_param.pb.dart';

part 'earthquake_intensity_partial.freezed.dart';
part 'earthquake_intensity_partial.g.dart';

@freezed
abstract class EarthquakeIntensityPartial with _$EarthquakeIntensityPartial {
  const factory EarthquakeIntensityPartial({
    required JmaIntensity maxIntensity,
    required JmaLpgmIntensity? maxLpgmIntensity,
    required List<IntensityRegion> regions,
  }) = _EarthquakeIntensityPartial;

  factory EarthquakeIntensityPartial.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeIntensityPartialFromJson(json);
}

extension EarthquakeIntensityPartialApiExtension on api.IntensityPartial {
  EarthquakeIntensityPartial toEarthquakeIntensityPartial({
    required EarthquakeParameter parameter,
  }) {
    final paramRegionMap = {for (final r in parameter.regions) r.code: r};
    return EarthquakeIntensityPartial(
      maxIntensity: maxIntensity.toJmaIntensity,
      maxLpgmIntensity: maxLpgmIntensity?.toJmaLpgmIntensity,
      regions: regions
          .map((e) {
            final paramRegion = paramRegionMap[e.value.code];
            if (paramRegion == null) {
              return null;
            }
            return IntensityRegion(
              region: paramRegion,
              maxIntensity: e.maxIntensity?.toJmaIntensity,
            );
          })
          .whereType<IntensityRegion>()
          .toList(),
    );
  }
}
