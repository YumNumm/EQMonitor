// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'schema_version.dart';
import 'archives.dart';

part 'data2.freezed.dart';
part 'data2.g.dart';

@Freezed()
abstract class Data2 with _$Data2 {
  const factory Data2({
    @JsonKey(name: 'schema_version')
    required SchemaVersion schemaVersion,
    @JsonKey(name: 'generated_at')
    required DateTime generatedAt,
    required List<Archives> archives,
  }) = _Data2;

  factory Data2.fromJson(Map<String, Object?> json) => _$Data2FromJson(json);
}
