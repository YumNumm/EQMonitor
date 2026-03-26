import 'package:eqmonitor_api/export.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_notification_settings.freezed.dart';

@freezed
abstract class GeneralNotificationSettings with _$GeneralNotificationSettings {
  const factory GeneralNotificationSettings({
    required bool tsunamiEnabled,
    required bool trainingEnabled,
  }) = _GeneralNotificationSettings;
}

extension GeneralNotificationSettingsApiExtension
    on api.NotificationSettingsResponse {
  GeneralNotificationSettings get toGeneralNotificationSettings =>
      GeneralNotificationSettings(
        tsunamiEnabled: tsunamiEnabled,
        trainingEnabled: trainingEnabled,
      );
}
