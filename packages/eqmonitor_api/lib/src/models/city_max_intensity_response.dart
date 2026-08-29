// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'city_max_intensity_item.dart';

part 'city_max_intensity_response.freezed.dart';
part 'city_max_intensity_response.g.dart';

@Freezed()
abstract class CityMaxIntensityResponse with _$CityMaxIntensityResponse {
  const factory CityMaxIntensityResponse({
    /// 集計を最後に更新した時刻。更新時刻を取得できなかった場合は null（items は返る）
    @JsonKey(includeIfNull: true,name: 'aggregated_at')
    required DateTime? aggregatedAt,
    required List<CityMaxIntensityItem> items,
  }) = _CityMaxIntensityResponse;
  
  factory CityMaxIntensityResponse.fromJson(Map<String, Object?> json) => _$CityMaxIntensityResponseFromJson(json);
}
