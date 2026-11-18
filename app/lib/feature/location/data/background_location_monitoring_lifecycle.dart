import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';

typedef BackgroundLocationMonitoringAction = Future<void> Function();

final class const BackgroundLocationUpdateRetry({
  final Duration baseDelay = const Duration(milliseconds: 250),
}) {
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

/// 位置情報の監視が必要かを、通知スロットと揺れ検知の「現在地」条件から決める。
///
/// どちらも未取得（null）の間は「不要」と断定せず、監視を止めない。
final class const BackgroundLocationMonitoringPolicy() {
  bool shouldMonitor({
    required List<NotificationSlot> slots,
    required bool? isShakeCurrentLocationEnabled,
  }) =>
      slots.any((s) => s.slotType == NotificationSlotType.currentLocation) ||
      isShakeCurrentLocationEnabled == true;

  bool shouldStop({
    required List<NotificationSlot>? slots,
    required bool? isShakeCurrentLocationEnabled,
  }) {
    if (slots == null || isShakeCurrentLocationEnabled == null) {
      return false;
    }
    return !shouldMonitor(
      slots: slots,
      isShakeCurrentLocationEnabled: isShakeCurrentLocationEnabled,
    );
  }
}

final class const BackgroundLocationMonitoringLifecycle({
  final BackgroundLocationMonitoringPolicy policy =
      const BackgroundLocationMonitoringPolicy(),
  final BackgroundLocationMonitoringAction startMonitoring =
      BackgroundLocationTracker.startMonitoring,
  final BackgroundLocationMonitoringAction stopMonitoring =
      BackgroundLocationTracker.stopMonitoring,
}) {
  Future<void> stop() async {
    try {
      await stopMonitoring();
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] stop monitoring', e, st);
    }
  }

  Future<void> reconcile({
    required List<NotificationSlot>? slots,
    required bool? isShakeCurrentLocationEnabled,
  }) async {
    final shouldMonitor = policy.shouldMonitor(
      slots: slots ?? const [],
      isShakeCurrentLocationEnabled: isShakeCurrentLocationEnabled,
    );
    final action = shouldMonitor
        ? startMonitoring
        : policy.shouldStop(
            slots: slots,
            isShakeCurrentLocationEnabled: isShakeCurrentLocationEnabled,
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
