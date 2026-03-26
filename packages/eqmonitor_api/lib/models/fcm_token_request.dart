// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_token_request.freezed.dart';
part 'fcm_token_request.g.dart';

@Freezed()
abstract class FcmTokenRequest with _$FcmTokenRequest {
  const factory FcmTokenRequest({required String token}) = _FcmTokenRequest;

  factory FcmTokenRequest.fromJson(Map<String, Object?> json) =>
      _$FcmTokenRequestFromJson(json);
}
