import 'package:eqapi_types/src/model/v2/notification/sound_settings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings.freezed.dart';
part 'notification_settings.g.dart';

/// 全般通知設定
@freezed
abstract class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    required bool tsunamiEnabled,
    required bool trainingEnabled,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsFromJson(json);
}

/// 全般通知設定リクエスト
@freezed
abstract class NotificationSettingsRequest with _$NotificationSettingsRequest {
  const factory NotificationSettingsRequest({
    bool? tsunamiEnabled,
    bool? trainingEnabled,
  }) = _NotificationSettingsRequest;

  factory NotificationSettingsRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsRequestFromJson(json);
}

/// 地震通知設定
@freezed
abstract class EarthquakeNotificationSettings
    with _$EarthquakeNotificationSettings {
  const factory EarthquakeNotificationSettings({
    required bool enabled,
    required SoundSettings sound,
    required bool hypocenterUpdateEnabled,
    required bool estimatedIntensityEnabled,
  }) = _EarthquakeNotificationSettings;

  factory EarthquakeNotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeNotificationSettingsFromJson(json);
}

/// 地震通知設定リクエスト
@freezed
abstract class EarthquakeNotificationSettingsRequest
    with _$EarthquakeNotificationSettingsRequest {
  const factory EarthquakeNotificationSettingsRequest({
    bool? enabled,
    SoundSettings? sound,
    bool? hypocenterUpdateEnabled,
    bool? estimatedIntensityEnabled,
  }) = _EarthquakeNotificationSettingsRequest;

  factory EarthquakeNotificationSettingsRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$EarthquakeNotificationSettingsRequestFromJson(json);
}

/// EEW通知設定
@freezed
abstract class EewNotificationSettings with _$EewNotificationSettings {
  const factory EewNotificationSettings({
    required bool enabled,
    required bool overrideSilentMode,
    required SoundSettings sound,
    required bool startLiveActivity,
  }) = _EewNotificationSettings;

  factory EewNotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$EewNotificationSettingsFromJson(json);
}

/// EEW通知設定リクエスト
@freezed
abstract class EewNotificationSettingsRequest
    with _$EewNotificationSettingsRequest {
  const factory EewNotificationSettingsRequest({
    bool? enabled,
    bool? overrideSilentMode,
    SoundSettings? sound,
    bool? startLiveActivity,
  }) = _EewNotificationSettingsRequest;

  factory EewNotificationSettingsRequest.fromJson(Map<String, dynamic> json) =>
      _$EewNotificationSettingsRequestFromJson(json);
}
