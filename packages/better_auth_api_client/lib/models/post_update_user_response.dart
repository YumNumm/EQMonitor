// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'post_update_user_response.freezed.dart';
part 'post_update_user_response.g.dart';

@Freezed()
abstract class PostUpdateUserResponse with _$PostUpdateUserResponse {
  const factory PostUpdateUserResponse({
    required User user,
  }) = _PostUpdateUserResponse;
  
  factory PostUpdateUserResponse.fromJson(Map<String, Object?> json) => _$PostUpdateUserResponseFromJson(json);
}
