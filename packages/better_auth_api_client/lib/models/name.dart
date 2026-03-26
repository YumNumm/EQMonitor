// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'name.freezed.dart';
part 'name.g.dart';

@Freezed()
abstract class Name with _$Name {
  const factory Name({
    @JsonKey(includeIfNull: true)
    required String? firstName,
    @JsonKey(includeIfNull: true)
    required String? lastName,
  }) = _Name;
  
  factory Name.fromJson(Map<String, Object?> json) => _$NameFromJson(json);
}
