import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_global_settings.freezed.dart';
part 'eew_global_settings.g.dart';

@freezed
abstract class EewGlobalSettings with _$EewGlobalSettings {
  const factory EewGlobalSettings({
    required bool enabled,
    required String defaultSound,
    required InterruptionLevel defaultInterruptionLevel,
    required bool startLiveActivity,
    required bool collapseNotification,
    required bool warningEnabled,
  }) = _EewGlobalSettings;

  factory EewGlobalSettings.fromJson(Map<String, dynamic> json) =>
      _$EewGlobalSettingsFromJson(json);
}

extension EewSettingsResponseConverter on api.EewSettingsResponse {
  EewGlobalSettings toEewGlobalSettings() => EewGlobalSettings(
    enabled: enabled,
    defaultSound: defaultSound,
    defaultInterruptionLevel: defaultInterruptionLevel.toAppInterruptionLevel,
    startLiveActivity: startLiveActivity,
    collapseNotification: collapseNotification,
    warningEnabled: warningEnabled,
  );
}
