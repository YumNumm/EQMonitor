// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'feed_item.dart';

part 'feed_list_response.freezed.dart';
part 'feed_list_response.g.dart';

@Freezed()
abstract class FeedListResponse with _$FeedListResponse {
  const factory FeedListResponse({
    required List<FeedItem> feeds,
    @JsonKey(includeIfNull: true, name: 'next_cursor')
    required String? nextCursor,
  }) = _FeedListResponse;

  factory FeedListResponse.fromJson(Map<String, Object?> json) =>
      _$FeedListResponseFromJson(json);
}
