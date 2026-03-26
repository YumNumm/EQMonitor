// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_password_reset_request_body.freezed.dart';
part 'request_password_reset_request_body.g.dart';

@Freezed()
abstract class RequestPasswordResetRequestBody with _$RequestPasswordResetRequestBody {
  const factory RequestPasswordResetRequestBody({
    /// The email address of the user to send a password reset email to
    required String email,

    /// The URL to redirect the user to reset their password. If the token isn't valid or expired, it'll be redirected with a query parameter `?error=INVALID_TOKEN`. If the token is valid, it'll be redirected with a query parameter `?token=VALID_TOKEN
    @JsonKey(includeIfNull: false)
    String? redirectTo,
  }) = _RequestPasswordResetRequestBody;
  
  factory RequestPasswordResetRequestBody.fromJson(Map<String, Object?> json) => _$RequestPasswordResetRequestBodyFromJson(json);
}
