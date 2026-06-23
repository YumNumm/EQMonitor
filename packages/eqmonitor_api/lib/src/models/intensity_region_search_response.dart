// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity_region_search_item.dart';

part 'intensity_region_search_response.freezed.dart';
part 'intensity_region_search_response.g.dart';

@Freezed()
abstract class IntensityRegionSearchResponse
    with _$IntensityRegionSearchResponse {
  const factory IntensityRegionSearchResponse({
    required List<IntensityRegionSearchItem> items,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling,
  }) = _IntensityRegionSearchResponse;

  factory IntensityRegionSearchResponse.fromJson(Map<String, Object?> json) =>
      _$IntensityRegionSearchResponseFromJson(json);
}
