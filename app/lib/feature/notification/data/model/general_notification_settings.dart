import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_notification_settings.freezed.dart';
part 'general_notification_settings.g.dart';

@freezed
abstract class GeneralNotificationSettings with _$GeneralNotificationSettings {
  const factory GeneralNotificationSettings({
    required bool notificationEnabled,
    required bool tsunamiEnabled,
    required bool trainingEnabled,
    required bool nankaiExtraordinaryEnabled,
    required bool nankaiRegularEnabled,
    required bool vyse60Enabled,
    required bool earthquakeNoticeEnabled,
  }) = _GeneralNotificationSettings;

  factory GeneralNotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$GeneralNotificationSettingsFromJson(json);
}

extension GeneralNotificationSettingsApiExtension
    on api.NotificationSettingsResponse {
  GeneralNotificationSettings get toGeneralNotificationSettings =>
      GeneralNotificationSettings(
        notificationEnabled: notificationEnabled,
        tsunamiEnabled: tsunamiEnabled,
        trainingEnabled: trainingEnabled,
        nankaiExtraordinaryEnabled: nankaiExtraordinaryEnabled,
        nankaiRegularEnabled: nankaiRegularEnabled,
        vyse60Enabled: vyse60Enabled,
        earthquakeNoticeEnabled: earthquakeNoticeEnabled,
      );
}
