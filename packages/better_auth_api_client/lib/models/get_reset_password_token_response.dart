// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_reset_password_token_response.freezed.dart';
part 'get_reset_password_token_response.g.dart';

@Freezed()
abstract class GetResetPasswordTokenResponse with _$GetResetPasswordTokenResponse {
  const factory GetResetPasswordTokenResponse({
    required String token,
  }) = _GetResetPasswordTokenResponse;
  
  factory GetResetPasswordTokenResponse.fromJson(Map<String, Object?> json) => _$GetResetPasswordTokenResponseFromJson(json);
}
