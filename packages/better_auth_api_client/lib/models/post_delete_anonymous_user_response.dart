// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_delete_anonymous_user_response.freezed.dart';
part 'post_delete_anonymous_user_response.g.dart';

@Freezed()
abstract class PostDeleteAnonymousUserResponse with _$PostDeleteAnonymousUserResponse {
  const factory PostDeleteAnonymousUserResponse({
    required bool success,
  }) = _PostDeleteAnonymousUserResponse;
  
  factory PostDeleteAnonymousUserResponse.fromJson(Map<String, Object?> json) => _$PostDeleteAnonymousUserResponseFromJson(json);
}
