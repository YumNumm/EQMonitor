// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_partial.dart';

part 'earthquake_list_response.freezed.dart';
part 'earthquake_list_response.g.dart';

@Freezed()
abstract class EarthquakeListResponse with _$EarthquakeListResponse {
  const factory EarthquakeListResponse({
    required List<EarthquakePartial> items,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false,name: 'next_token')
    String? nextToken,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false,name: 'next_pooling')
    String? nextPooling,
  }) = _EarthquakeListResponse;
  
  factory EarthquakeListResponse.fromJson(Map<String, Object?> json) => _$EarthquakeListResponseFromJson(json);
}
