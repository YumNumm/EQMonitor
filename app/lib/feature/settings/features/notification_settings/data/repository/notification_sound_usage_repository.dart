import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_custom_snapshot_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_sound_usage_repository.g.dart';

@Riverpod(keepAlive: true)
Future<NotificationSoundUsageRepository> notificationSoundUsageRepository(
  Ref ref,
) async => NotificationSoundUsageRepository(
  slots: await ref.watch(notificationSlotRepositoryProvider.future),
  snapshots: await ref.watch(
    notificationCustomSnapshotRepositoryProvider.future,
  ),
);

class const NotificationSoundUsageRepository({
  required final NotificationSlotRepository slots,
  required final NotificationCustomSnapshotRepository snapshots,
}) {
  Future<bool> isInUse({required String fileName}) async {
    final eew = await slots.getEewGlobalSettings();
    final earthquake = await slots.getEarthquakeGlobalSettings();
    if (eew.defaultSound == fileName || earthquake.defaultSound == fileName)
      return true;
    final settings = await slots.getSlots();
    for (final slot in settings) {
      if ([
        ...?slot.eewOverrides,
        ...?slot.earthquakeOverrides,
      ].any((entry) => entry.sound == fileName)) {
        return true;
      }
    }
    final snapshot = await snapshots.load(requireValid: true);
    if (snapshot == null) return false;
    if (snapshot.eewGlobal.defaultSound == fileName ||
        snapshot.earthquakeGlobal.defaultSound == fileName) {
      return true;
    }
    return snapshot.slots.any(
      (slot) => [
        ...?slot.eewOverrides,
        ...?slot.earthquakeOverrides,
      ].any((entry) => entry.sound == fileName),
    );
  }
}
