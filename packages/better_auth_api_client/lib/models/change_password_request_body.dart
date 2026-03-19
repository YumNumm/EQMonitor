// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_request_body.freezed.dart';
part 'change_password_request_body.g.dart';

@Freezed()
abstract class ChangePasswordRequestBody with _$ChangePasswordRequestBody {
  const factory ChangePasswordRequestBody({
    /// The new password to set
    required String newPassword,

    /// The current password is required
    required String currentPassword,

    /// Must be a boolean value
    @JsonKey(includeIfNull: false)
    bool? revokeOtherSessions,
  }) = _ChangePasswordRequestBody;
  
  factory ChangePasswordRequestBody.fromJson(Map<String, Object?> json) => _$ChangePasswordRequestBodyFromJson(json);
}
