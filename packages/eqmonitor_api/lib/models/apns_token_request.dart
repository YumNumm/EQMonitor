// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'apns_environment.dart';

part 'apns_token_request.freezed.dart';
part 'apns_token_request.g.dart';

@Freezed()
abstract class ApnsTokenRequest with _$ApnsTokenRequest {
  const factory ApnsTokenRequest({
    required String token,
    @JsonKey(includeIfNull: false) ApnsEnvironment? environment,
  }) = _ApnsTokenRequest;

  factory ApnsTokenRequest.fromJson(Map<String, Object?> json) =>
      _$ApnsTokenRequestFromJson(json);
}
