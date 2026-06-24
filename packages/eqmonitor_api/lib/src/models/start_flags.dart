// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'maintenance_info.dart';

part 'start_flags.freezed.dart';
part 'start_flags.g.dart';

@Freezed()
abstract class StartFlags with _$StartFlags {
  const factory StartFlags({
    @JsonKey(name: 'ads_enabled')
    required bool adsEnabled,
    required MaintenanceInfo maintenance,
  }) = _StartFlags;
  
  factory StartFlags.fromJson(Map<String, Object?> json) => _$StartFlagsFromJson(json);
}
