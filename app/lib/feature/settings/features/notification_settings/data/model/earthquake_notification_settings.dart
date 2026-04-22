import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_notification_settings.freezed.dart';

@freezed
abstract class EarthquakeNotificationSettings
    with _$EarthquakeNotificationSettings {
  const factory EarthquakeNotificationSettings({
    required bool enabled,
    required JmaIntensity? criticalThreshold,
    required bool estimatedIntensityEnabled,
    required List<NotificationRegion> regions,
  }) = _EarthquakeNotificationSettings;
}
