// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_request_body.freezed.dart';
part 'reset_password_request_body.g.dart';

@Freezed()
abstract class ResetPasswordRequestBody with _$ResetPasswordRequestBody {
  const factory ResetPasswordRequestBody({
    /// The new password to set
    required String newPassword,

    /// The token to reset the password
    @JsonKey(includeIfNull: false)
    String? token,
  }) = _ResetPasswordRequestBody;
  
  factory ResetPasswordRequestBody.fromJson(Map<String, Object?> json) => _$ResetPasswordRequestBodyFromJson(json);
}
