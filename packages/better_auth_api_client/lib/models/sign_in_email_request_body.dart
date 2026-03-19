// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_email_request_body.freezed.dart';
part 'sign_in_email_request_body.g.dart';

@Freezed()
abstract class SignInEmailRequestBody with _$SignInEmailRequestBody {
  const factory SignInEmailRequestBody({
    /// Email of the user
    required String email,

    /// Password of the user
    required String password,

    /// If this is false, the session will not be remembered. Default is `true`.
    @JsonKey(includeIfNull: true)
    @Default(true)
    bool? rememberMe,

    /// Callback URL to use as a redirect for email verification
    @JsonKey(includeIfNull: false,name: 'callbackURL')
    String? callbackUrl,
  }) = _SignInEmailRequestBody;
  
  factory SignInEmailRequestBody.fromJson(Map<String, Object?> json) => _$SignInEmailRequestBodyFromJson(json);
}
