// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'eew_intensity_region_arrival_time_type.dart';

part 'eew_intensity_region_arrival_time_time.freezed.dart';
part 'eew_intensity_region_arrival_time_time.g.dart';

@Freezed()
abstract class EewIntensityRegionArrivalTimeTime
    with _$EewIntensityRegionArrivalTimeTime {
  const factory EewIntensityRegionArrivalTimeTime({
    required EewIntensityRegionArrivalTimeType type,
    @JsonKey(includeIfNull: false) DateTime? value,
  }) = _EewIntensityRegionArrivalTimeTime;

  factory EewIntensityRegionArrivalTimeTime.fromJson(
    Map<String, Object?> json,
  ) => _$EewIntensityRegionArrivalTimeTimeFromJson(json);
}
