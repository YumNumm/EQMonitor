// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'session.dart';
import 'user.dart';

part 'post_get_session_response.freezed.dart';
part 'post_get_session_response.g.dart';

@Freezed()
abstract class PostGetSessionResponse with _$PostGetSessionResponse {
  const factory PostGetSessionResponse({
    required Session session,
    required User user,
  }) = _PostGetSessionResponse;
  
  factory PostGetSessionResponse.fromJson(Map<String, Object?> json) => _$PostGetSessionResponseFromJson(json);
}
