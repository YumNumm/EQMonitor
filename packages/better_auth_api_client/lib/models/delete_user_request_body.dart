// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_user_request_body.freezed.dart';
part 'delete_user_request_body.g.dart';

@Freezed()
abstract class DeleteUserRequestBody with _$DeleteUserRequestBody {
  const factory DeleteUserRequestBody({
    /// The callback URL to redirect to after the user is deleted
    @JsonKey(name: 'callbackURL')
    required String callbackUrl,

    /// The user's password. Required if session is not fresh
    required String password,

    /// The deletion verification token
    required String token,
  }) = _DeleteUserRequestBody;
  
  factory DeleteUserRequestBody.fromJson(Map<String, Object?> json) => _$DeleteUserRequestBodyFromJson(json);
}
