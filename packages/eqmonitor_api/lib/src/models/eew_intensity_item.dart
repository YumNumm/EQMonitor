// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'eew_intensity_lpgm_value.dart';
import 'eew_intensity_region_arrival_time_time.dart';
import 'eew_intensity_value.dart';

part 'eew_intensity_item.freezed.dart';
part 'eew_intensity_item.g.dart';

@Freezed()
abstract class EewIntensityItem with _$EewIntensityItem {
  const factory EewIntensityItem({
    /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
    required String code,
    required String name,
    @JsonKey(name: 'is_plum') required bool isPlum,
    @JsonKey(name: 'is_warning') required bool isWarning,
    required EewIntensityValue intensity,
    @JsonKey(name: 'arrival_time')
    required EewIntensityRegionArrivalTimeTime arrivalTime,
    @JsonKey(includeIfNull: false, name: 'lpgm_intensity')
    EewIntensityLpgmValue? lpgmIntensity,
  }) = _EewIntensityItem;

  factory EewIntensityItem.fromJson(Map<String, Object?> json) =>
      _$EewIntensityItemFromJson(json);
}
