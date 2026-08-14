import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_global_settings.freezed.dart';
part 'earthquake_global_settings.g.dart';

@freezed
abstract class EarthquakeGlobalSettings with _$EarthquakeGlobalSettings {
  const factory EarthquakeGlobalSettings({
    required bool enabled,
    required String defaultSound,
    required InterruptionLevel defaultInterruptionLevel,
    required bool estimatedIntensityEnabled,
    required bool collapseNotification,
  }) = _EarthquakeGlobalSettings;

  factory EarthquakeGlobalSettings.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeGlobalSettingsFromJson(json);
}

extension EarthquakeSettingsResponseConverter
    on api.EarthquakeSettingsResponse {
  EarthquakeGlobalSettings toEarthquakeGlobalSettings() =>
      EarthquakeGlobalSettings(
        enabled: enabled,
        defaultSound: defaultSound,
        defaultInterruptionLevel:
            defaultInterruptionLevel.toAppInterruptionLevel,
        estimatedIntensityEnabled: estimatedIntensityEnabled,
        collapseNotification: collapseNotification,
      );
}
