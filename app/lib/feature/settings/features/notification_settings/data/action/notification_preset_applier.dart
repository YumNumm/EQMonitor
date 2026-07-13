import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/notification/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_preset_applier.g.dart';

// UI から ref.read で取得後、API 呼び出しの await を跨いで Ref を使うため
// autoDispose だと途中で dispose され UnmountedRefException になる
@Riverpod(keepAlive: true)
NotificationPresetApplier notificationPresetApplier(Ref ref) =>
    NotificationPresetApplier(ref);

class NotificationPresetApplier {
  NotificationPresetApplier(this._ref);

  final Ref _ref;

  Future<void> apply(NotificationPreset preset) async {
    switch (preset) {
      case NotificationPreset.recommended:
        await NotificationSlotsNotifier.putCurrentLocationMutation.run(
          _ref,
          (tsx) async {
            await tsx
                .get(notificationSlotsProvider.notifier)
                .putCurrentLocation(
                  eewEnabled: true,
                  eewMinIntensity: JmaIntensity.four,
                  earthquakeEnabled: true,
                  earthquakeMinIntensity: JmaIntensity.one,
                );
          },
        );
        await GeneralNotificationSettingsNotifier.updateSettingsMutation.run(
          _ref,
          (tsx) async {
            await tsx
                .get(generalNotificationSettingsProvider.notifier)
                .updateSettings(notificationEnabled: true);
          },
        );
        await _ref
            .read(notificationPresetProvider.notifier)
            .select(NotificationPreset.recommended);
      case NotificationPreset.all:
        await NotificationSlotsNotifier.putCurrentLocationMutation.run(
          _ref,
          (tsx) async {
            await tsx
                .get(notificationSlotsProvider.notifier)
                .putCurrentLocation(
                  eewEnabled: true,
                  eewMinIntensity: JmaIntensity.four,
                  earthquakeEnabled: true,
                  earthquakeMinIntensity: JmaIntensity.one,
                );
          },
        );
        await NotificationSlotsNotifier.putNationwideMutation.run(
          _ref,
          (tsx) async {
            await tsx.get(notificationSlotsProvider.notifier).putNationwide(
                  eewEnabled: true,
                  eewMinIntensity: defaultNotificationSlotMinIntensity,
                  earthquakeEnabled: true,
                  earthquakeMinIntensity: defaultNotificationSlotMinIntensity,
                );
          },
        );
        await GeneralNotificationSettingsNotifier.updateSettingsMutation.run(
          _ref,
          (tsx) async {
            await tsx
                .get(generalNotificationSettingsProvider.notifier)
                .updateSettings(notificationEnabled: true);
          },
        );
        await _ref
            .read(notificationPresetProvider.notifier)
            .select(NotificationPreset.all);
      case NotificationPreset.none:
        await GeneralNotificationSettingsNotifier.updateSettingsMutation.run(
          _ref,
          (tsx) async {
            await tsx
                .get(generalNotificationSettingsProvider.notifier)
                .updateSettings(notificationEnabled: false);
          },
        );
        await _ref
            .read(notificationPresetProvider.notifier)
            .select(NotificationPreset.none);
      case NotificationPreset.custom:
        await NotificationSlotsNotifier.putCurrentLocationMutation.run(
          _ref,
          (tsx) async {
            await tsx
                .get(notificationSlotsProvider.notifier)
                .putCurrentLocation(
                  eewEnabled: true,
                  eewMinIntensity: JmaIntensity.four,
                  earthquakeEnabled: true,
                  earthquakeMinIntensity: JmaIntensity.one,
                );
          },
        );
    }
  }
}
