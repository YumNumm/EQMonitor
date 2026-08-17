import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_warning_config_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_settings_action.g.dart';

@riverpod
EewWarningSettingsAction eewWarningSettingsAction(Ref ref) =>
    const EewWarningSettingsAction();

class EewWarningSettingsAction {
  const new();

  Future<void> updateCurrentLocation(
    WidgetRef ref, {
    required bool enabled,
  }) async {
    await EewGlobalSettingsNotifier.updateSettingsMutation.run(ref, (
      tsx,
    ) async {
      await tsx
          .get(eewGlobalSettingsProvider.notifier)
          .updateSettings(warningEnabled: enabled);
    });
    ref.read(eewWarningConfigProvider.notifier).synchronizeWithGlobalToggle();
  }

  Future<void> updateNationwide(
    WidgetRef ref, {
    required bool enabled,
  }) async {
    await EewWarningConfigNotifier.updateConfigMutation.run(ref, (tsx) async {
      await tsx
          .get(eewWarningConfigProvider.notifier)
          .updateConfig(
            target: enabled
                ? EewWarningTarget.currentLocationAndNationwide
                : EewWarningTarget.currentLocationOnly,
            nationwideInterruptionLevel: enabled
                ? InterruptionLevel.active
                : null,
          );
    });
    ref
        .read(eewGlobalSettingsProvider.notifier)
        .synchronizeWarningEnabled(enabled: true);
  }
}
