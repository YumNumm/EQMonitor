// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_verification_email_request_body.freezed.dart';
part 'send_verification_email_request_body.g.dart';

@Freezed()
abstract class SendVerificationEmailRequestBody with _$SendVerificationEmailRequestBody {
  const factory SendVerificationEmailRequestBody({
    /// The email to send the verification email to
    required String email,

    /// The URL to use for email verification callback
    @JsonKey(includeIfNull: false,name: 'callbackURL')
    String? callbackUrl,
  }) = _SendVerificationEmailRequestBody;
  
  factory SendVerificationEmailRequestBody.fromJson(Map<String, Object?> json) => _$SendVerificationEmailRequestBodyFromJson(json);
}
