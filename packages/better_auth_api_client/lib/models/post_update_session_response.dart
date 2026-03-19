// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'session.dart';

part 'post_update_session_response.freezed.dart';
part 'post_update_session_response.g.dart';

@Freezed()
abstract class PostUpdateSessionResponse with _$PostUpdateSessionResponse {
  const factory PostUpdateSessionResponse({
    required Session session,
  }) = _PostUpdateSessionResponse;
  
  factory PostUpdateSessionResponse.fromJson(Map<String, Object?> json) => _$PostUpdateSessionResponseFromJson(json);
}
