import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_notification_access_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_location_permission_missing_provider.g.dart';

@riverpod
bool isCurrentLocationPermissionMissing(Ref ref) {
  final permission = ref.watch(backgroundLocationPermissionProvider).value;
  if (permission == null || permission == .always) {
    return false;
  }
  final slot = ref
      .watch(notificationSlotsProvider)
      .value
      ?.where((slot) => slot.slotType == .currentLocation)
      .firstOrNull;
  if (slot != null &&
      (slot.eewEnabled ||
          slot.earthquakeEnabled ||
          (ref.watch(eewGlobalSettingsProvider).value?.warningEnabled ??
              false))) {
    return true;
  }
  if (ref.watch(shakeDetectionNotificationAccessProvider) != .editable) {
    return false;
  }
  return ref
          .watch(shakeDetectionSettingsProvider)
          .value
          ?.entries
          .any((entry) => entry.isCurrentLocation && entry.enabled) ??
      false;
}
