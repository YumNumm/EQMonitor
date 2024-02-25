import 'package:eqapi_types/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity.freezed.dart';
part 'intensity.g.dart';

@freezed
class Intensity with _$Intensity {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory Intensity({
    required JmaIntensity maxInt,
    @Default(null) JmaLgIntensity? maxLgInt,
    @Default(null) LgType? lgCategory,
    required List<RegionIntensity> prefectures,
    required List<RegionIntensity> regions,
    required List<RegionIntensity>? cities,
    required List<RegionIntensity>? stations,
  }) = _Intensity;

  factory Intensity.fromJson(Map<String, dynamic> json) =>
      _$IntensityFromJson(json);
}
