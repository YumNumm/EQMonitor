import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_intensity_partial.freezed.dart';
part 'earthquake_intensity_partial.g.dart';

@freezed
abstract class EarthquakeIntensityPartial with _$EarthquakeIntensityPartial {
  const factory({
    required JmaIntensity maxIntensity,
    required JmaLpgmIntensity? maxLpgmIntensity,
    ShindoDbIntensityClass? maxIntensityClass,
  }) = _EarthquakeIntensityPartial;

  factory fromJson(Map<String, dynamic> json) =>
      _$EarthquakeIntensityPartialFromJson(json);
}

extension EarthquakeIntensityPartialApiExtension on api.IntensityPartial {
  EarthquakeIntensityPartial toEarthquakeIntensityPartial({
    required EarthquakeParameter parameter,
  }) {
    return EarthquakeIntensityPartial(
      maxIntensity: maxIntensity.toJmaIntensity,
      maxLpgmIntensity: maxLpgmIntensity?.toJmaLpgmIntensity,
      maxIntensityClass: maxIntensityClass?.toShindoDbIntensityClass,
    );
  }
}
