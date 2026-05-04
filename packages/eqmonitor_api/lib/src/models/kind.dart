// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'kind.freezed.dart';
part 'kind.g.dart';

@Freezed()
abstract class Kind with _$Kind {
  const factory Kind({
    required String code,
    required String name,
  }) = _Kind;
  
  factory Kind.fromJson(Map<String, Object?> json) => _$KindFromJson(json);
}
