// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_send_verification_email_response.freezed.dart';
part 'post_send_verification_email_response.g.dart';

@Freezed()
abstract class PostSendVerificationEmailResponse with _$PostSendVerificationEmailResponse {
  const factory PostSendVerificationEmailResponse({
    /// Indicates if the email was sent successfully
    required bool status,
  }) = _PostSendVerificationEmailResponse;
  
  factory PostSendVerificationEmailResponse.fromJson(Map<String, Object?> json) => _$PostSendVerificationEmailResponseFromJson(json);
}
