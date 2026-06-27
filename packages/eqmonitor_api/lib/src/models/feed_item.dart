// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'feed_item_data_union.dart';
import 'feed_type.dart';
import 'priority.dart';

part 'feed_item.freezed.dart';
part 'feed_item.g.dart';

@Freezed()
abstract class FeedItem with _$FeedItem {
  const factory FeedItem({
    required String id,

    /// const: "EARTHQUAKE_NOTICE" | const: "EARTHQUAKE_EXPLANATION" | const: "EARTHQUAKE_COUNTS" | const: "EARTHQUAKE_NANKAI" | const: "APP_UPDATE" | const: "INCIDENT" | const: "DEVELOPER_MESSAGE"
    @JsonKey(name: 'feed_type')
    required FeedType feedType,

    /// const: "CRITICAL" | const: "HIGH" | const: "NORMAL" | const: "LOW"
    required Priority priority,
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
    required FeedItemDataUnion data,
  }) = _FeedItem;
  
  factory FeedItem.fromJson(Map<String, Object?> json) => _$FeedItemFromJson(json);
}
