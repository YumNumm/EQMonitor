// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_verify_password_response.freezed.dart';
part 'post_verify_password_response.g.dart';

@Freezed()
abstract class PostVerifyPasswordResponse with _$PostVerifyPasswordResponse {
  const factory PostVerifyPasswordResponse({
    required bool status,
  }) = _PostVerifyPasswordResponse;
  
  factory PostVerifyPasswordResponse.fromJson(Map<String, Object?> json) => _$PostVerifyPasswordResponseFromJson(json);
}
