// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'migration_service_unavailable_response.freezed.dart';
part 'migration_service_unavailable_response.g.dart';

@Freezed()
abstract class MigrationServiceUnavailableResponse with _$MigrationServiceUnavailableResponse {
  const factory MigrationServiceUnavailableResponse({
    /// const: "SERVICE_UNAVAILABLE"
    required String code,
    required String message,
  }) = _MigrationServiceUnavailableResponse;

  factory MigrationServiceUnavailableResponse.fromJson(Map<String, Object?> json) => _$MigrationServiceUnavailableResponseFromJson(json);
}
