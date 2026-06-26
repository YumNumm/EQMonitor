// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_naming.freezed.dart';
part 'feed_naming.g.dart';

@Freezed()
abstract class FeedNaming with _$FeedNaming {
  const factory FeedNaming({
    required String text,
    @JsonKey(includeIfNull: false)
    String? en,
  }) = _FeedNaming;
  
  factory FeedNaming.fromJson(Map<String, Object?> json) => _$FeedNamingFromJson(json);
}
