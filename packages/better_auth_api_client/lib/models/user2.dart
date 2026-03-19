// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user2.freezed.dart';
part 'user2.g.dart';

@Freezed()
abstract class User2 with _$User2 {
  const factory User2({
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
  }) = _User2;
  
  factory User2.fromJson(Map<String, Object?> json) => _$User2FromJson(json);
}
