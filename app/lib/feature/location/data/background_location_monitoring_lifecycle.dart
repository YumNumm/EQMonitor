import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';

final class BackgroundLocationUpdateRetry {
  const BackgroundLocationUpdateRetry({
    this.baseDelay = const Duration(milliseconds: 250),
  });

  final Duration baseDelay;

  Future<T> run<T>({required Future<T> Function() action}) async {
    for (var attempt = 1; attempt <= 3; attempt++) {
      try {
        return await action();
      } on Object {
        if (attempt == 3) {
          rethrow;
        }
        await Future<void>.delayed(baseDelay * attempt);
      }
    }
    throw StateError('retry failed');
  }
}

final class BackgroundLocationMonitoringPolicy {
  const BackgroundLocationMonitoringPolicy();

  bool shouldMonitor({
    required EewNotificationSettings? eewSettings,
    required EarthquakeNotificationSettings? earthquakeSettings,
    required ShakeDetectionState? shakeDetectionState,
  }) =>
      eewSettings?.regions.any((r) => r.isCurrentLocation) == true ||
      earthquakeSettings?.regions.any((r) => r.isCurrentLocation) == true ||
      shakeDetectionState?.entries.any((e) => e.isCurrentLocation) == true;

  bool shouldStop({
    required EewNotificationSettings? eewSettings,
    required EarthquakeNotificationSettings? earthquakeSettings,
    required ShakeDetectionState? shakeDetectionState,
  }) {
    if (eewSettings == null ||
        earthquakeSettings == null ||
        shakeDetectionState == null) {
      return false;
    }
    return !shouldMonitor(
      eewSettings: eewSettings,
      earthquakeSettings: earthquakeSettings,
      shakeDetectionState: shakeDetectionState,
    );
  }
}

final class BackgroundLocationMonitoringLifecycle {
  const BackgroundLocationMonitoringLifecycle({
    this.policy = const BackgroundLocationMonitoringPolicy(),
  });

  final BackgroundLocationMonitoringPolicy policy;

  Future<void> stopIfUnused({
    required EewNotificationSettings? eewSettings,
    required EarthquakeNotificationSettings? earthquakeSettings,
    required ShakeDetectionState? shakeDetectionState,
  }) async {
    if (!policy.shouldStop(
      eewSettings: eewSettings,
      earthquakeSettings: earthquakeSettings,
      shakeDetectionState: shakeDetectionState,
    )) {
      return;
    }
    try {
      await BackgroundLocationTracker.stopMonitoring();
    } on Object catch (e, st) {
      talker.error(
        '[BackgroundLocation] BackgroundLocationTracker.stopMonitoring',
        e,
        st,
      );
    }
  }
}
