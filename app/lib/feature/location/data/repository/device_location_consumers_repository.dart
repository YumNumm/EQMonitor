import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/location/data/notifier/current_device_location_notifier.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_location_consumers_repository.g.dart';

@Riverpod(keepAlive: true)
DeviceLocationConsumersRepository deviceLocationConsumersRepository(Ref ref) {
  final repository = DeviceLocationConsumersRepository(
    ref.watch(deviceLocationSyncStateRepositoryProvider),
    syncLocation: () async {
      try {
        await ref.read(currentDeviceLocationProvider.future);
      } on Object {
        // A failed cached-state load must still allow a fresh location attempt.
      }
      if (!ref.mounted) return;
      await ref.read(currentDeviceLocationProvider.notifier).refresh();
    },
  );
  // Also covers granting permission in OS settings and returning to the app.
  ref.listen(backgroundLocationPermissionProvider, (previous, next) async {
    if (next.value == LocationPermission.always &&
        previous?.value != LocationPermission.always) {
      await repository.reconcile(syncLocation: true);
    }
  });
  return repository;
}

/// Combines independently loaded consumers before changing headless availability.
class DeviceLocationConsumersRepository {
  new(
    this.storage, {
    this.lifecycle = const BackgroundLocationMonitoringLifecycle(),
    this.syncLocation,
  });
  final DeviceLocationSyncStateRepository storage;
  final BackgroundLocationMonitoringLifecycle lifecycle;
  final BackgroundLocationMonitoringAction? syncLocation;
  List<NotificationSlot>? _slots;
  ShakeDetectionState? _shake;
  Future<void> _pending = Future<void>.value();
  Future<void> updateSlots(List<NotificationSlot> slots) {
    _slots = slots;
    return reconcile();
  }

  Future<void> updateShake(ShakeDetectionState shake) {
    final wasEnabled =
        _shake?.entries.any(
          (entry) => entry.isCurrentLocation && entry.enabled,
        ) ==
        true;
    _shake = shake;
    return reconcile(
      syncLocation:
          !wasEnabled &&
          shake.entries.any(
            (entry) => entry.isCurrentLocation && entry.enabled,
          ),
    );
  }

  Future<void> reset() {
    _slots = [];
    _shake = (entries: [], requiresReconfiguration: false);
    return reconcile();
  }

  Future<void> reconcile({bool syncLocation = false}) {
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
      if (enabled && syncLocation) await this.syncLocation?.call();
    });
    _pending = operation;
    return operation;
  }
}
