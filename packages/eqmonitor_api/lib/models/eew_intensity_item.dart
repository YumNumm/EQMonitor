// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'code_name.dart';
import 'eew_intensity_lpgm_value.dart';
import 'eew_intensity_value.dart';

part 'eew_intensity_item.freezed.dart';
part 'eew_intensity_item.g.dart';

@Freezed()
abstract class EewIntensityItem with _$EewIntensityItem {
  const factory EewIntensityItem({
    required CodeName value,
    @JsonKey(name: 'is_plum') required bool isPlum,
    @JsonKey(name: 'is_warning') required bool isWarning,
    required EewIntensityValue intensity,
    @JsonKey(includeIfNull: false, name: 'lpgm_intensity')
    EewIntensityLpgmValue? lpgmIntensity,

    /// 到達予想時刻。undefinedの場合は、すでに到達済みと推定されます。
    @JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,
  }) = _EewIntensityItem;

  factory EewIntensityItem.fromJson(Map<String, Object?> json) =>
      _$EewIntensityItemFromJson(json);
}
