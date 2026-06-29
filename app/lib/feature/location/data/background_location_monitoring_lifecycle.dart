import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
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
    required List<NotificationSlot> slots,
    required ShakeDetectionState? shakeDetectionState,
  }) =>
      slots.any((s) => s.slotType == NotificationSlotType.currentLocation) ||
      shakeDetectionState?.entries.any((e) => e.isCurrentLocation) == true;

  bool shouldStop({
    required List<NotificationSlot>? slots,
    required ShakeDetectionState? shakeDetectionState,
  }) {
    if (slots == null || shakeDetectionState == null) {
      return false;
    }
    return !shouldMonitor(
      slots: slots,
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
    required List<NotificationSlot>? slots,
    required ShakeDetectionState? shakeDetectionState,
  }) async {
    if (!policy.shouldStop(
      slots: slots,
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
