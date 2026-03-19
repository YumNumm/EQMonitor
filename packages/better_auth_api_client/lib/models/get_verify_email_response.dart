// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'get_verify_email_response.freezed.dart';
part 'get_verify_email_response.g.dart';

@Freezed()
abstract class GetVerifyEmailResponse with _$GetVerifyEmailResponse {
  const factory GetVerifyEmailResponse({
    required User user,

    /// Indicates if the email was verified successfully
    required bool status,
  }) = _GetVerifyEmailResponse;
  
  factory GetVerifyEmailResponse.fromJson(Map<String, Object?> json) => _$GetVerifyEmailResponseFromJson(json);
}
