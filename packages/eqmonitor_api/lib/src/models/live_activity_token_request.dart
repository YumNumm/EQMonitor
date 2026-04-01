// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_activity_token_request.freezed.dart';
part 'live_activity_token_request.g.dart';

@Freezed()
abstract class LiveActivityTokenRequest with _$LiveActivityTokenRequest {
  const factory LiveActivityTokenRequest({
    required String token,
  }) = _LiveActivityTokenRequest;
  
  factory LiveActivityTokenRequest.fromJson(Map<String, Object?> json) => _$LiveActivityTokenRequestFromJson(json);
}
