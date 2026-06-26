// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_comments.freezed.dart';
part 'feed_comments.g.dart';

@Freezed()
abstract class FeedComments with _$FeedComments {
  const factory FeedComments({
    required String free,
  }) = _FeedComments;
  
  factory FeedComments.fromJson(Map<String, Object?> json) => _$FeedCommentsFromJson(json);
}
