// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'default_interruption_level.dart';

part 'eew_settings_response.freezed.dart';
part 'eew_settings_response.g.dart';

@Freezed()
abstract class EewSettingsResponse with _$EewSettingsResponse {
  const factory EewSettingsResponse({
    required bool enabled,
    @JsonKey(name: 'default_sound')
    required String defaultSound,
    @JsonKey(name: 'default_interruption_level')
    required DefaultInterruptionLevel defaultInterruptionLevel,
    @JsonKey(name: 'start_live_activity')
    required bool startLiveActivity,
    @JsonKey(name: 'collapse_notification')
    required bool collapseNotification,
    @JsonKey(name: 'warning_enabled')
    required bool warningEnabled,
  }) = _EewSettingsResponse;
  
  factory EewSettingsResponse.fromJson(Map<String, Object?> json) => _$EewSettingsResponseFromJson(json);
}
