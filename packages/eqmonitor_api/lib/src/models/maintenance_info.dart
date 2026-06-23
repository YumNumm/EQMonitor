// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'maintenance_info.freezed.dart';
part 'maintenance_info.g.dart';

@Freezed()
abstract class MaintenanceInfo with _$MaintenanceInfo {
  const factory MaintenanceInfo({
    required bool enabled,
    @JsonKey(includeIfNull: false) String? message,
    @JsonKey(includeIfNull: false) String? url,
  }) = _MaintenanceInfo;

  factory MaintenanceInfo.fromJson(Map<String, Object?> json) =>
      _$MaintenanceInfoFromJson(json);
}
