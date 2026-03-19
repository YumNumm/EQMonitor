// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user3.dart';

part 'post_change_password_response.freezed.dart';
part 'post_change_password_response.g.dart';

@Freezed()
abstract class PostChangePasswordResponse with _$PostChangePasswordResponse {
  const factory PostChangePasswordResponse({
    required User3 user,

    /// New session token if other sessions were revoked
    @JsonKey(includeIfNull: false)
    String? token,
  }) = _PostChangePasswordResponse;
  
  factory PostChangePasswordResponse.fromJson(Map<String, Object?> json) => _$PostChangePasswordResponseFromJson(json);
}
