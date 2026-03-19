// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user3.freezed.dart';
part 'user3.g.dart';

@Freezed()
abstract class User3 with _$User3 {
  const factory User3({
    /// The unique identifier of the user
    required String id,

    /// The email address of the user
    required String email,

    /// The name of the user
    required String name,

    /// Whether the email has been verified
    required bool emailVerified,

    /// When the user was created
    required DateTime createdAt,

    /// When the user was last updated
    required DateTime updatedAt,

    /// The profile image URL of the user
    @JsonKey(includeIfNull: false)
    String? image,
  }) = _User3;
  
  factory User3.fromJson(Map<String, Object?> json) => _$User3FromJson(json);
}
