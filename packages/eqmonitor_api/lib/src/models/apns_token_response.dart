// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'apns_environment.dart';
import 'apns_token_type.dart';

part 'apns_token_response.freezed.dart';
part 'apns_token_response.g.dart';

@Freezed()
abstract class ApnsTokenResponse with _$ApnsTokenResponse {
  const factory ApnsTokenResponse({
    required ApnsTokenType type,
    required String token,
    required ApnsEnvironment environment,
  }) = _ApnsTokenResponse;
  
  factory ApnsTokenResponse.fromJson(Map<String, Object?> json) => _$ApnsTokenResponseFromJson(json);
}
