// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'migration_result_response.freezed.dart';
part 'migration_result_response.g.dart';

@Freezed()
abstract class MigrationResultResponse with _$MigrationResultResponse {
  const factory MigrationResultResponse({
    @JsonKey(name: 'earthquake_regions')
    required num earthquakeRegions,
    @JsonKey(name: 'eew_regions')
    required num eewRegions,
    @JsonKey(name: 'notification_settings')
    required bool notificationSettings,
  }) = _MigrationResultResponse;
  
  factory MigrationResultResponse.fromJson(Map<String, Object?> json) => _$MigrationResultResponseFromJson(json);
}
