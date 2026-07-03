// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'feed_item_data_union.dart';
import 'feed_priority.dart';
import 'feed_type.dart';

part 'feed_detail_response.freezed.dart';
part 'feed_detail_response.g.dart';

@Freezed()
abstract class FeedDetailResponse with _$FeedDetailResponse {
  const factory FeedDetailResponse({
    required String id,
    @JsonKey(name: 'feed_type')
    required FeedType feedType,
    required FeedPriority priority,
    @JsonKey(name: 'is_important')
    required bool isImportant,
    @JsonKey(name: 'published_at')
    required String publishedAt,
    @JsonKey(includeIfNull: true,name: 'expires_at')
    required String? expiresAt,
    @JsonKey(includeIfNull: true)
    required String? title,
    @JsonKey(includeIfNull: true)
    required String? summary,
    @JsonKey(includeIfNull: true)
    required String? body,
    required FeedItemDataUnion data,
  }) = _FeedDetailResponse;
  
  factory FeedDetailResponse.fromJson(Map<String, Object?> json) => _$FeedDetailResponseFromJson(json);
}
