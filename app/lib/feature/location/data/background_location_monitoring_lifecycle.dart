import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';

typedef BackgroundLocationMonitoringAction = Future<void> Function();

final class BackgroundLocationUpdateRetry {
  const new({
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
  const new();

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
  const new({
    this.policy = const BackgroundLocationMonitoringPolicy(),
    this.startMonitoring = BackgroundLocationTracker.startMonitoring,
    this.stopMonitoring = BackgroundLocationTracker.stopMonitoring,
  });

  final BackgroundLocationMonitoringPolicy policy;
  final BackgroundLocationMonitoringAction startMonitoring;
  final BackgroundLocationMonitoringAction stopMonitoring;

  Future<void> stop() async {
    try {
      await stopMonitoring();
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] stop monitoring', e, st);
    }
  }

  Future<void> reconcile({
    required List<NotificationSlot>? slots,
    required ShakeDetectionState? shakeDetectionState,
  }) async {
    final shouldMonitor = policy.shouldMonitor(
      slots: slots ?? const [],
      shakeDetectionState: shakeDetectionState,
    );
    final action = shouldMonitor
        ? startMonitoring
        : policy.shouldStop(
            slots: slots,
            shakeDetectionState: shakeDetectionState,
          )
        ? stopMonitoring
        : null;
    if (action == null) {
      return;
    }
    try {
      await action();
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] reconcile monitoring', e, st);
    }
  }
}
