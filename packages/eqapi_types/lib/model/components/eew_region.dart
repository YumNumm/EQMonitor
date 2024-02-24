import 'package:eqapi_types/model/components/eew_intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_region.freezed.dart';
part 'eew_region.g.dart';

@freezed
class EewRegion with _$EewRegion {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory EewRegion({
    required String code,
    required String name,
    required bool isPlum,
    required bool isWarning,
    required ForecastMaxInt forecastMaxInt,
    required ForecastMaxLgInt? forecastMaxLgInt,

    /// undefinedの場合は null
    /// PLUM法の場合は最初にその階級震度を予測した時刻
    required DateTime? arrivalTime,
  }) = _EewRegion;

  factory EewRegion.fromJson(Map<String, dynamic> json) =>
      _$EewRegionFromJson(json);
}
