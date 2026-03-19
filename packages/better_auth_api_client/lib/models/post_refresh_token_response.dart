// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_refresh_token_response.freezed.dart';
part 'post_refresh_token_response.g.dart';

@Freezed()
abstract class PostRefreshTokenResponse with _$PostRefreshTokenResponse {
  const factory PostRefreshTokenResponse({
    required String tokenType,
    required String idToken,
    required String accessToken,
    required String refreshToken,
    required DateTime accessTokenExpiresAt,
    required DateTime refreshTokenExpiresAt,
  }) = _PostRefreshTokenResponse;
  
  factory PostRefreshTokenResponse.fromJson(Map<String, Object?> json) => _$PostRefreshTokenResponseFromJson(json);
}
