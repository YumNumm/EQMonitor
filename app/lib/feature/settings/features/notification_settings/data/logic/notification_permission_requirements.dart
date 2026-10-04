import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';

class const NotificationPermissionRequirements() {
  bool requiresCriticalAlert({
    required NotificationPreset preset,
    required EewGlobalSettings? eew,
    required EewWarningSettings? warning,
    required EarthquakeGlobalSettings? earthquake,
    required List<NotificationSlot>? slots,
  }) {
    if (preset == .recommended || preset == .all) {
      return true;
    }
    if (eew?.enabled == true &&
        eew?.warningEnabled == true &&
        warning?.currentLocationInterruptionLevel == .critical) {
      return true;
    }
    return slots?.any(
          (slot) =>
              (eew?.enabled == true &&
                  slot.eewEnabled &&
                  (eew?.defaultInterruptionLevel == .critical ||
                      slot.eewOverrides?.any(
                            (override) =>
                                override.interruptionLevel == .critical,
                          ) ==
                          true)) ||
              (earthquake?.enabled == true &&
                  slot.earthquakeEnabled &&
                  (earthquake?.defaultInterruptionLevel == .critical ||
                      slot.earthquakeOverrides?.any(
                            (override) =>
                                override.interruptionLevel == .critical,
                          ) ==
                          true)),
        ) ??
        false;
  }
}
