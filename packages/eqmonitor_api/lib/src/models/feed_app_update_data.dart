// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_app_update_data.freezed.dart';
part 'feed_app_update_data.g.dart';

@Freezed()
abstract class FeedAppUpdateData with _$FeedAppUpdateData {
  const factory FeedAppUpdateData({
    /// const: "APP_UPDATE"
    required String type,
    @JsonKey(includeIfNull: false)
    String? version,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = _FeedAppUpdateData;
  
  factory FeedAppUpdateData.fromJson(Map<String, Object?> json) => _$FeedAppUpdateDataFromJson(json);
}
