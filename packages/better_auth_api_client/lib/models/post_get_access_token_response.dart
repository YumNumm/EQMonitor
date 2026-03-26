// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_get_access_token_response.freezed.dart';
part 'post_get_access_token_response.g.dart';

@Freezed()
abstract class PostGetAccessTokenResponse with _$PostGetAccessTokenResponse {
  const factory PostGetAccessTokenResponse({
    required String tokenType,
    required String idToken,
    required String accessToken,
    required DateTime accessTokenExpiresAt,
  }) = _PostGetAccessTokenResponse;
  
  factory PostGetAccessTokenResponse.fromJson(Map<String, Object?> json) => _$PostGetAccessTokenResponseFromJson(json);
}
