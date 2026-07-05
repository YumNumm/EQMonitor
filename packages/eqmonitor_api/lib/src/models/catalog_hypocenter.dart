// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog_determination_flag.dart';
import 'catalog_hypocenter_auxiliary_info.dart';
import 'catalog_hypocenter_depth.dart';
import 'catalog_hypocenter_evaluation.dart';
import 'catalog_hypocenter_magnitude.dart';
import 'catalog_hypocenter_record_type.dart';
import 'catalog_intensity_class.dart';
import 'catalog_travel_time_table.dart';
import 'coordinate.dart';

part 'catalog_hypocenter.freezed.dart';
part 'catalog_hypocenter.g.dart';

@Freezed()
abstract class CatalogHypocenter with _$CatalogHypocenter {
  const factory CatalogHypocenter({
    /// 0が代表震源
    required int seq,
    @JsonKey(name: 'record_type')
    required CatalogHypocenterRecordType recordType,

    /// 気象庁または他機関が計算したマグニチュード（0〜2件、magnitude1/magnitude2に対応）
    required List<CatalogHypocenterMagnitude> magnitudes,
    @JsonKey(name: 'epicenter_name')
    required String epicenterName,

    /// 震度1以上を観測した観測点の数
    @JsonKey(name: 'station_count')
    required int stationCount,
    @JsonKey(includeIfNull: false,name: 'origin_time')
    DateTime? originTime,
    @JsonKey(includeIfNull: false,name: 'origin_time_stderr_seconds')
    num? originTimeStderrSeconds,
    @JsonKey(includeIfNull: false)
    Coordinate? coordinates,
    @JsonKey(includeIfNull: false)
    CatalogHypocenterDepth? depth,
    @JsonKey(includeIfNull: false,name: 'max_intensity')
    CatalogIntensityClass? maxIntensity,
    @JsonKey(includeIfNull: false,name: 'large_area_code')
    int? largeAreaCode,
    @JsonKey(includeIfNull: false,name: 'small_area_code')
    int? smallAreaCode,
    @JsonKey(includeIfNull: false,name: 'determination_flag')
    CatalogDeterminationFlag? determinationFlag,
    @JsonKey(includeIfNull: false)
    CatalogHypocenterEvaluation? evaluation,
    @JsonKey(includeIfNull: false,name: 'auxiliary_info')
    CatalogHypocenterAuxiliaryInfo? auxiliaryInfo,
    @JsonKey(includeIfNull: false,name: 'travel_time_table')
    CatalogTravelTimeTable? travelTimeTable,
  }) = _CatalogHypocenter;

  factory CatalogHypocenter.fromJson(Map<String, Object?> json) => _$CatalogHypocenterFromJson(json);
}
