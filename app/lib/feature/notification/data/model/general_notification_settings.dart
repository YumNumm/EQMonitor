import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_notification_settings.freezed.dart';

@freezed
abstract class GeneralNotificationSettings with _$GeneralNotificationSettings {
  const factory GeneralNotificationSettings({
    required bool notificationEnabled,
    required bool tsunamiEnabled,
    required bool trainingEnabled,
    required bool nankaiExtraordinaryEnabled,
    required bool nankaiRegularEnabled,
    required bool hokkaido3renOffshoreEnabled,
  }) = _GeneralNotificationSettings;
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
        hokkaido3renOffshoreEnabled: hokkaido3renOffshoreEnabled,
      );
}
