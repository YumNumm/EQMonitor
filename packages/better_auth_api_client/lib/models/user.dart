// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'name.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed()
abstract class User with _$User {
  const factory User({
    @JsonKey(includeIfNull: true)
    required Name? name,
    @JsonKey(includeIfNull: true)
    required String? email,
  }) = _User;
  
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
