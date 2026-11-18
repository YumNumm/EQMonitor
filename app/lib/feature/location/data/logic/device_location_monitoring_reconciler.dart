import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_consumers_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
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
    await ref.read(deviceLocationConsumersRepositoryProvider).reset();
  },
  afterReprovisionAction: () async {
    ref
      ..invalidate(notificationSlotsProvider, asReload: true)
      ..invalidate(shakeDetectionSettingsProvider, asReload: true);
    try {
      final (slots, shake) = await (
        ref.read(notificationSlotsProvider.future),
        ref.read(shakeDetectionSettingsProvider.future),
      ).wait;
      await const BackgroundLocationMonitoringLifecycle().reconcile(
        slots: slots,
        isShakeCurrentLocationEnabled: shake.entries.any(
          (entry) => entry.isCurrentLocation && entry.enabled,
        ),
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

final class const DeviceLocationMonitoringReconciler({
  required final DeviceLocationMonitoringAction afterDeleteAction,
  required final DeviceLocationMonitoringAction afterReprovisionAction,
}) {
  Future<void> afterDelete() => afterDeleteAction();

  Future<void> afterReprovision() => afterReprovisionAction();
}
