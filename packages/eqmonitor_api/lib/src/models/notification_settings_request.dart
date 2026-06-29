// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_request.freezed.dart';
part 'notification_settings_request.g.dart';

@Freezed()
abstract class NotificationSettingsRequest with _$NotificationSettingsRequest {
  const factory NotificationSettingsRequest({
    @JsonKey(includeIfNull: false,name: 'tsunami_enabled')
    bool? tsunamiEnabled,
    @JsonKey(includeIfNull: false,name: 'training_enabled')
    bool? trainingEnabled,
    @JsonKey(includeIfNull: false,name: 'nankai_extraordinary_enabled')
    bool? nankaiExtraordinaryEnabled,
    @JsonKey(includeIfNull: false,name: 'nankai_regular_enabled')
    bool? nankaiRegularEnabled,
    @JsonKey(includeIfNull: false,name: 'hokkaido3ren_offshore_enabled')
    bool? hokkaido3renOffshoreEnabled,
  }) = _NotificationSettingsRequest;
  
  factory NotificationSettingsRequest.fromJson(Map<String, Object?> json) => _$NotificationSettingsRequestFromJson(json);
}
