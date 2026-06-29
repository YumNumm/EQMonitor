// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_response.freezed.dart';
part 'notification_settings_response.g.dart';

@Freezed()
abstract class NotificationSettingsResponse with _$NotificationSettingsResponse {
  const factory NotificationSettingsResponse({
    @JsonKey(name: 'tsunami_enabled')
    required bool tsunamiEnabled,
    @JsonKey(name: 'training_enabled')
    required bool trainingEnabled,
    @JsonKey(name: 'nankai_extraordinary_enabled')
    required bool nankaiExtraordinaryEnabled,
    @JsonKey(name: 'nankai_regular_enabled')
    required bool nankaiRegularEnabled,
    @JsonKey(name: 'hokkaido3ren_offshore_enabled')
    required bool hokkaido3renOffshoreEnabled,
  }) = _NotificationSettingsResponse;
  
  factory NotificationSettingsResponse.fromJson(Map<String, Object?> json) => _$NotificationSettingsResponseFromJson(json);
}
