// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'highest_intensity_item.dart';

part 'highest_intensity_response.freezed.dart';
part 'highest_intensity_response.g.dart';

@Freezed()
abstract class HighestIntensityResponse with _$HighestIntensityResponse {
  const factory HighestIntensityResponse({
    /// このレスポンスで最高震度集計を生成した時刻
    @JsonKey(name: 'aggregated_at')
    required DateTime aggregatedAt,
    required List<HighestIntensityItem> items,
  }) = _HighestIntensityResponse;
  
  factory HighestIntensityResponse.fromJson(Map<String, Object?> json) => _$HighestIntensityResponseFromJson(json);
}
