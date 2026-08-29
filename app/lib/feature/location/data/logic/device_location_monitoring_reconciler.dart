import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_location_monitoring_reconciler.g.dart';

typedef DeviceLocationMonitoringAction = Future<void> Function();

@Riverpod(keepAlive: true)
DeviceLocationMonitoringReconciler deviceLocationMonitoringReconciler(
  Ref ref,
) => DeviceLocationMonitoringReconciler(
  afterDeleteAction: () async {
    await ref
        .read(deviceLocationSyncStateRepositoryProvider)
        .writeAvailability(DeviceLocationSyncAvailability.disabled);
    await const BackgroundLocationMonitoringLifecycle().stop();
  },
  afterReprovisionAction: () async {
    ref
      ..invalidate(notificationSlotsProvider, asReload: true)
      ..invalidate(shakeDetectionSettingsProvider, asReload: true);
    try {
      final slots = await ref.read(notificationSlotsProvider.future);
      final shake = await ref.read(shakeDetectionSettingsProvider.future);
      await const BackgroundLocationMonitoringLifecycle().reconcile(
        slots: slots,
        shakeDetectionState: shake,
      );
    } on Object catch (error, stackTrace) {
      talker.error(
        '[BackgroundLocation] reload consumers after reprovision failed',
        error,
        stackTrace,
      );
    }
  },
);

final class DeviceLocationMonitoringReconciler {
  const new({
    required this.afterDeleteAction,
    required this.afterReprovisionAction,
  });

  final DeviceLocationMonitoringAction afterDeleteAction;
  final DeviceLocationMonitoringAction afterReprovisionAction;

  Future<void> afterDelete() => afterDeleteAction();

  Future<void> afterReprovision() => afterReprovisionAction();
}
