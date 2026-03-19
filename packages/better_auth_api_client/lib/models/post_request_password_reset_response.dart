// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_request_password_reset_response.freezed.dart';
part 'post_request_password_reset_response.g.dart';

@Freezed()
abstract class PostRequestPasswordResetResponse with _$PostRequestPasswordResetResponse {
  const factory PostRequestPasswordResetResponse({
    required bool status,
    required String message,
  }) = _PostRequestPasswordResetResponse;
  
  factory PostRequestPasswordResetResponse.fromJson(Map<String, Object?> json) => _$PostRequestPasswordResetResponseFromJson(json);
}
