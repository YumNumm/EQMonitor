// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_reset_password_response.freezed.dart';
part 'post_reset_password_response.g.dart';

@Freezed()
abstract class PostResetPasswordResponse with _$PostResetPasswordResponse {
  const factory PostResetPasswordResponse({
    required bool status,
  }) = _PostResetPasswordResponse;
  
  factory PostResetPasswordResponse.fromJson(Map<String, Object?> json) => _$PostResetPasswordResponseFromJson(json);
}
