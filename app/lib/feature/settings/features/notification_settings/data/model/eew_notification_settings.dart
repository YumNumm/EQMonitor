import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_notification_settings.freezed.dart';

@freezed
abstract class EewNotificationSettings with _$EewNotificationSettings {
  const factory EewNotificationSettings({
    required bool enabled,
    required JmaIntensity? criticalThreshold,
    required bool startLiveActivity,
    required bool onePointEnabled,
    required List<NotificationRegion> regions,
  }) = _EewNotificationSettings;
}
