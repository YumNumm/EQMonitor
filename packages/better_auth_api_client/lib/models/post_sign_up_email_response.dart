// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user2.dart';

part 'post_sign_up_email_response.freezed.dart';
part 'post_sign_up_email_response.g.dart';

@Freezed()
abstract class PostSignUpEmailResponse with _$PostSignUpEmailResponse {
  const factory PostSignUpEmailResponse({
    required User2 user,

    /// Authentication token for the session
    @JsonKey(includeIfNull: false)
    String? token,
  }) = _PostSignUpEmailResponse;
  
  factory PostSignUpEmailResponse.fromJson(Map<String, Object?> json) => _$PostSignUpEmailResponseFromJson(json);
}
