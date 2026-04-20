// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'code_name.freezed.dart';
part 'code_name.g.dart';

/// コードと名前のペア
@Freezed()
abstract class CodeName with _$CodeName {
  const factory CodeName({
    required String code,
    required String name,
  }) = _CodeName;

  factory CodeName.fromJson(Map<String, Object?> json) =>
      _$CodeNameFromJson(json);
}
