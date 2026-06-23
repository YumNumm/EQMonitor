// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_response.freezed.dart';
part 'user_response.g.dart';

@Freezed()
abstract class UserResponse with _$UserResponse {
  const factory UserResponse({
    required String id,
    required String name,
    required String email,
    @JsonKey(includeIfNull: true) required String? image,
    @JsonKey(includeIfNull: true) required String? role,
    @JsonKey(includeIfNull: true, name: 'is_anonymous')
    required bool? isAnonymous,
    @JsonKey(includeIfNull: true) required bool? banned,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, Object?> json) =>
      _$UserResponseFromJson(json);
}
