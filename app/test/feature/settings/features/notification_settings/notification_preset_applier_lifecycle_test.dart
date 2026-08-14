// 回帰テスト: applier が autoDispose だと、API 呼び出し(イベントループを跨ぐ
// await)の間に provider が dispose され UnmountedRefException になっていた
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/notification_preset_applier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot_draft.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart'
    hide SharedPreferencesAsync;

class _SlowNotificationSlotsNotifier extends NotificationSlotsNotifier {
  @override
  Future<List<NotificationSlot>> build() async => const [];

  @override
  Future<void> replaceSlots(List<NotificationSlotDraft> slots) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }
}

class _FakeGeneralNotificationSettingsNotifier
    extends GeneralNotificationSettingsNotifier {
  @override
  Future<GeneralNotificationSettings> build() async =>
      const GeneralNotificationSettings(
        notificationEnabled: false,
        tsunamiEnabled: false,
        trainingEnabled: false,
        nankaiExtraordinaryEnabled: false,
        nankaiRegularEnabled: false,
        vyse60Enabled: false,
        earthquakeNoticeEnabled: false,
      );

  @override
  Future<void> updateSettings({
    bool? notificationEnabled,
    bool? tsunamiEnabled,
    bool? trainingEnabled,
    bool? nankaiExtraordinaryEnabled,
    bool? nankaiRegularEnabled,
    bool? vyse60Enabled,
    bool? earthquakeNoticeEnabled,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }
}

class _FakeEewGlobalSettingsNotifier extends EewGlobalSettingsNotifier {
  @override
  Future<EewGlobalSettings> build() async => const EewGlobalSettings(
    enabled: false,
    defaultSound: 'default',
    defaultInterruptionLevel: InterruptionLevel.timeSensitive,
    startLiveActivity: false,
    collapseNotification: true,
    warningEnabled: false,
  );

  @override
  Future<void> updateSettings({
    bool? enabled,
    String? defaultSound,
    InterruptionLevel? defaultInterruptionLevel,
    bool? startLiveActivity,
    bool? collapseNotification,
    bool? warningEnabled,
  }) async {}
}

class _FakeEarthquakeGlobalSettingsNotifier
    extends EarthquakeGlobalSettingsNotifier {
  @override
  Future<EarthquakeGlobalSettings> build() async =>
      const EarthquakeGlobalSettings(
        enabled: false,
        defaultSound: 'default',
        defaultInterruptionLevel: InterruptionLevel.active,
        estimatedIntensityEnabled: false,
        collapseNotification: true,
      );

  @override
  Future<void> updateSettings({
    bool? enabled,
    String? defaultSound,
    InterruptionLevel? defaultInterruptionLevel,
    bool? estimatedIntensityEnabled,
    bool? collapseNotification,
  }) async {}
}

class _FakeNotificationPresetNotifier extends NotificationPresetNotifier {
  final selectedPresets = <NotificationPreset>[];

  @override
  Future<NotificationPreset> build() async => NotificationPreset.recommended;

  @override
  Future<void> select(NotificationPreset preset) async {
    selectedPresets.add(preset);
    state = AsyncData(preset);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'apply(recommended) survives autoDispose of the applier provider',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final presetNotifier = _FakeNotificationPresetNotifier();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(
            SharedPreferencesAsync(prefs),
          ),
          notificationSlotsProvider.overrideWith(
            _SlowNotificationSlotsNotifier.new,
          ),
          generalNotificationSettingsProvider.overrideWith(
            _FakeGeneralNotificationSettingsNotifier.new,
          ),
          eewGlobalSettingsProvider.overrideWith(
            _FakeEewGlobalSettingsNotifier.new,
          ),
          earthquakeGlobalSettingsProvider.overrideWith(
            _FakeEarthquakeGlobalSettingsNotifier.new,
          ),
          notificationPresetProvider.overrideWith(() => presetNotifier),
        ],
      );
      addTearDown(container.dispose);

      final applier = container.read(notificationPresetApplierProvider);
      await applier.apply(NotificationPreset.recommended);

      expect(presetNotifier.selectedPresets, [NotificationPreset.recommended]);
    },
  );
}
