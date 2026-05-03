// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_create_response.freezed.dart';
part 'feed_create_response.g.dart';

@Freezed()
abstract class FeedCreateResponse with _$FeedCreateResponse {
  const factory FeedCreateResponse({
    required String id,
  }) = _FeedCreateResponse;
  
  factory FeedCreateResponse.fromJson(Map<String, Object?> json) => _$FeedCreateResponseFromJson(json);
}
