// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';
import 'message.dart';

part 'post_change_email_response.freezed.dart';
part 'post_change_email_response.g.dart';

@Freezed()
abstract class PostChangeEmailResponse with _$PostChangeEmailResponse {
  const factory PostChangeEmailResponse({
    /// Indicates if the request was successful
    required bool status,
    @JsonKey(includeIfNull: false)
    User? user,

    /// Status message of the email change process
    @JsonKey(includeIfNull: false)
    Message? message,
  }) = _PostChangeEmailResponse;
  
  factory PostChangeEmailResponse.fromJson(Map<String, Object?> json) => _$PostChangeEmailResponseFromJson(json);
}
