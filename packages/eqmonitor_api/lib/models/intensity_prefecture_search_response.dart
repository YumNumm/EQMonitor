// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity_prefecture_search_item.dart';

part 'intensity_prefecture_search_response.freezed.dart';
part 'intensity_prefecture_search_response.g.dart';

@Freezed()
abstract class IntensityPrefectureSearchResponse
    with _$IntensityPrefectureSearchResponse {
  const factory IntensityPrefectureSearchResponse({
    required List<IntensityPrefectureSearchItem> items,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling,
  }) = _IntensityPrefectureSearchResponse;

  factory IntensityPrefectureSearchResponse.fromJson(
    Map<String, Object?> json,
  ) => _$IntensityPrefectureSearchResponseFromJson(json);
}
