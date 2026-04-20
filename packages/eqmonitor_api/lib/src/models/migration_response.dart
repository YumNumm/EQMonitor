// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'migration_result_response.dart';

part 'migration_response.freezed.dart';
part 'migration_response.g.dart';

@Freezed()
abstract class MigrationResponse with _$MigrationResponse {
  const factory MigrationResponse({
    required MigrationResultResponse migrated,
  }) = _MigrationResponse;
  
  factory MigrationResponse.fromJson(Map<String, Object?> json) => _$MigrationResponseFromJson(json);
}
