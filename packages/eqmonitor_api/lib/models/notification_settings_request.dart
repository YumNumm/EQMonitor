// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_request.freezed.dart';
part 'notification_settings_request.g.dart';

@Freezed()
abstract class NotificationSettingsRequest with _$NotificationSettingsRequest {
  const factory NotificationSettingsRequest({
    @JsonKey(name: 'tsunami_enabled') required bool tsunamiEnabled,
    @JsonKey(name: 'training_enabled') required bool trainingEnabled,
  }) = _NotificationSettingsRequest;

  factory NotificationSettingsRequest.fromJson(Map<String, Object?> json) =>
      _$NotificationSettingsRequestFromJson(json);
}
