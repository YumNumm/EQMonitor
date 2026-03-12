// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_response.freezed.dart';
part 'user_response.g.dart';

@Freezed()
abstract class UserResponse with _$UserResponse {
  const factory UserResponse({
    required String id,
  }) = _UserResponse;
  
  factory UserResponse.fromJson(Map<String, Object?> json) => _$UserResponseFromJson(json);
}
