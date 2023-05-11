import 'package:eqmonitor/feature/api/model/telegram_v3.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'region_intensity.freezed.dart';
part 'region_intensity.g.dart';

@freezed
class RegionIntensity with _$RegionIntensity {
  const factory RegionIntensity({
    required String code,
    required String name,
    required JmaIntensity? maxInt,
    required JmaLgIntensity? maxLgInt,
  }) = _RegionIntensity;

  factory RegionIntensity.fromJson(Map<String, dynamic> json) =>
      _$RegionIntensityFromJson(json);
}
