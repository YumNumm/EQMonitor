import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
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
  }) = _EarthquakeIntensityPartial;

  factory EarthquakeIntensityPartial.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeIntensityPartialFromJson(json);
}

extension EarthquakeIntensityPartialApiExtension on api.IntensityPartial {
  EarthquakeIntensityPartial toEarthquakeIntensityPartial({
    required EarthquakeParameter parameter,
  }) {
    return EarthquakeIntensityPartial(
      maxIntensity: maxIntensity.toJmaIntensity,
      maxLpgmIntensity: maxLpgmIntensity?.toJmaLpgmIntensity,
    );
  }
}
