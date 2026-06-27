// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_developer_message_data.freezed.dart';
part 'feed_developer_message_data.g.dart';

@Freezed()
abstract class FeedDeveloperMessageData with _$FeedDeveloperMessageData {
  const factory FeedDeveloperMessageData({
    /// const: "DEVELOPER_MESSAGE"
    required String type,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = _FeedDeveloperMessageData;
  
  factory FeedDeveloperMessageData.fromJson(Map<String, Object?> json) => _$FeedDeveloperMessageDataFromJson(json);
}
