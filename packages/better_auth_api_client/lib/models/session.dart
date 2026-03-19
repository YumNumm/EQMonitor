// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@Freezed()
abstract class Session with _$Session {
  const factory Session({
    required DateTime expiresAt,
    required String token,
    required DateTime updatedAt,
    required String userId,
    DateTime? createdAt,
    @JsonKey(includeIfNull: false)
    String? id,
    @JsonKey(includeIfNull: false)
    String? ipAddress,
    @JsonKey(includeIfNull: false)
    String? userAgent,
    @JsonKey(includeIfNull: false)
    String? impersonatedBy,
  }) = _Session;
  
  factory Session.fromJson(Map<String, Object?> json) => _$SessionFromJson(json);
}
