// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'redirect.dart';
import 'user.dart';

part 'post_sign_in_email_response.freezed.dart';
part 'post_sign_in_email_response.g.dart';

@Freezed()
abstract class PostSignInEmailResponse with _$PostSignInEmailResponse {
  const factory PostSignInEmailResponse({
    required Redirect redirect,

    /// Session token
    required String token,
    required User user,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = _PostSignInEmailResponse;
  
  factory PostSignInEmailResponse.fromJson(Map<String, Object?> json) => _$PostSignInEmailResponseFromJson(json);
}
