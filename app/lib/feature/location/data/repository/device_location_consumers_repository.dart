import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'device_location_consumers_repository.g.dart';

@Riverpod(keepAlive: true)
DeviceLocationConsumersRepository deviceLocationConsumersRepository(Ref ref) =>
    DeviceLocationConsumersRepository(
      ref.watch(deviceLocationSyncStateRepositoryProvider),
    );

/// Combines independently loaded consumers before changing headless availability.
class DeviceLocationConsumersRepository {
  new(
    this.storage, {
    this.lifecycle = const BackgroundLocationMonitoringLifecycle(),
  });
  final DeviceLocationSyncStateRepository storage;
  final BackgroundLocationMonitoringLifecycle lifecycle;
  List<NotificationSlot>? _slots;
  ShakeDetectionState? _shake;
  Future<void> _pending = Future<void>.value();
  Future<void> updateSlots(List<NotificationSlot> slots) {
    _slots = slots;
    return reconcile();
  }

  Future<void> updateShake(ShakeDetectionState shake) {
    _shake = shake;
    return reconcile();
  }

  Future<void> reset() {
    _slots = [];
    _shake = (entries: [], requiresReconfiguration: false);
    return reconcile();
  }

  Future<void> reconcile() {
    final operation = _pending.onError((error, stackTrace) {}).then((_) async {
      final slots = _slots;
      final shake = _shake;
      const policy = BackgroundLocationMonitoringPolicy();
      final enabled = policy.shouldMonitor(
        slots: slots ?? [],
        shakeDetectionState: shake,
      );
      final disabled = policy.shouldStop(
        slots: slots,
        shakeDetectionState: shake,
      );
      if (!enabled && !disabled) return;
      await storage.writeAvailability(
        enabled
            ? DeviceLocationSyncAvailability.enabled
            : DeviceLocationSyncAvailability.disabled,
      );
      await lifecycle.reconcile(slots: slots, shakeDetectionState: shake);
    });
    _pending = operation;
    return operation;
  }
}
