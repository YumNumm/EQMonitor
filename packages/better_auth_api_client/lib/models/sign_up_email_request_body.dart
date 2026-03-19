// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_email_request_body.freezed.dart';
part 'sign_up_email_request_body.g.dart';

@Freezed()
abstract class SignUpEmailRequestBody with _$SignUpEmailRequestBody {
  const factory SignUpEmailRequestBody({
    /// The name of the user
    required String name,

    /// The email of the user
    required String email,

    /// The password of the user
    required String password,

    /// The profile image URL of the user
    @JsonKey(includeIfNull: false)
    String? image,

    /// The URL to use for email verification callback
    @JsonKey(includeIfNull: false,name: 'callbackURL')
    String? callbackUrl,

    /// If this is false, the session will not be remembered. Default is `true`.
    @JsonKey(includeIfNull: false)
    bool? rememberMe,
  }) = _SignUpEmailRequestBody;
  
  factory SignUpEmailRequestBody.fromJson(Map<String, Object?> json) => _$SignUpEmailRequestBodyFromJson(json);
}
