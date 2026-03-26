// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_email_request_body.freezed.dart';
part 'change_email_request_body.g.dart';

@Freezed()
abstract class ChangeEmailRequestBody with _$ChangeEmailRequestBody {
  const factory ChangeEmailRequestBody({
    /// The new email address to set must be a valid email address
    required String newEmail,

    /// The URL to redirect to after email verification
    @JsonKey(includeIfNull: false,name: 'callbackURL')
    String? callbackUrl,
  }) = _ChangeEmailRequestBody;
  
  factory ChangeEmailRequestBody.fromJson(Map<String, Object?> json) => _$ChangeEmailRequestBodyFromJson(json);
}
