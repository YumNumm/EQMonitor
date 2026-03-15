// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity_city_search_item.dart';

part 'intensity_city_search_response.freezed.dart';
part 'intensity_city_search_response.g.dart';

@Freezed()
abstract class IntensityCitySearchResponse with _$IntensityCitySearchResponse {
  const factory IntensityCitySearchResponse({
    required List<IntensityCitySearchItem> items,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling,
  }) = _IntensityCitySearchResponse;

  factory IntensityCitySearchResponse.fromJson(Map<String, Object?> json) =>
      _$IntensityCitySearchResponseFromJson(json);
}
