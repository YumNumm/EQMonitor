// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';
import 'redirect.dart';

part 'post_sign_in_social_response.freezed.dart';
part 'post_sign_in_social_response.g.dart';

@Freezed()
abstract class PostSignInSocialResponse with _$PostSignInSocialResponse {
  const factory PostSignInSocialResponse({
    required String token,
    required User user,
    required Redirect redirect,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = _PostSignInSocialResponse;
  
  factory PostSignInSocialResponse.fromJson(Map<String, Object?> json) => _$PostSignInSocialResponseFromJson(json);
}
