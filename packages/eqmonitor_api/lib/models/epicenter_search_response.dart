// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'epicenter_search_item.dart';

part 'epicenter_search_response.freezed.dart';
part 'epicenter_search_response.g.dart';

@Freezed()
abstract class EpicenterSearchResponse with _$EpicenterSearchResponse {
  const factory EpicenterSearchResponse({
    required List<EpicenterSearchItem> items,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling,
  }) = _EpicenterSearchResponse;

  factory EpicenterSearchResponse.fromJson(Map<String, Object?> json) =>
      _$EpicenterSearchResponseFromJson(json);
}
