// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_response.freezed.dart';
part 'session_response.g.dart';

@Freezed()
abstract class SessionResponse with _$SessionResponse {
  const factory SessionResponse({
    required String id,
    required String token,
    @JsonKey(name: 'expires_at')
    required String expiresAt,
    @JsonKey(name: 'created_at')
    required String createdAt,
    @JsonKey(name: 'updated_at')
    required String updatedAt,
    @JsonKey(includeIfNull: true,name: 'ip_address')
    required String? ipAddress,
    @JsonKey(includeIfNull: true,name: 'user_agent')
    required String? userAgent,
  }) = _SessionResponse;
  
  factory SessionResponse.fromJson(Map<String, Object?> json) => _$SessionResponseFromJson(json);
}
