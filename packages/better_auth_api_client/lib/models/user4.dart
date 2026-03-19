// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user4.freezed.dart';
part 'user4.g.dart';

@Freezed()
abstract class User4 with _$User4 {
  const factory User4({
    required String id,
    required bool emailVerified,
    @JsonKey(includeIfNull: false)
    String? name,
    @JsonKey(includeIfNull: false)
    String? email,
    @JsonKey(includeIfNull: false)
    String? image,
  }) = _User4;
  
  factory User4.fromJson(Map<String, Object?> json) => _$User4FromJson(json);
}
