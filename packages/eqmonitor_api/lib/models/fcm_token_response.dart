// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_token_response.freezed.dart';
part 'fcm_token_response.g.dart';

@Freezed()
abstract class FcmTokenResponse with _$FcmTokenResponse {
  const factory FcmTokenResponse({required String token}) = _FcmTokenResponse;

  factory FcmTokenResponse.fromJson(Map<String, Object?> json) =>
      _$FcmTokenResponseFromJson(json);
}
