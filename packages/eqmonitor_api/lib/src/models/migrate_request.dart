// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'migrate_request.freezed.dart';
part 'migrate_request.g.dart';

@Freezed()
abstract class MigrateRequest with _$MigrateRequest {
  const factory MigrateRequest({
    @JsonKey(name: 'old_device_id')
    required String oldDeviceId,
  }) = _MigrateRequest;
  
  factory MigrateRequest.fromJson(Map<String, Object?> json) => _$MigrateRequestFromJson(json);
}
