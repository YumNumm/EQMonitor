// 回帰テスト: applier が autoDispose だと、API 呼び出し(イベントループを跨ぐ
// await)の間に provider が dispose され UnmountedRefException になっていた
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/notification_preset_applier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _SlowNotificationSlotsNotifier extends NotificationSlotsNotifier {
  @override
  Future<List<NotificationSlot>> build() async => const [];

  @override
  Future<void> putCurrentLocation({
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    // 実際の API 呼び出しのようにイベントループを跨ぐ
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<void> putNationwide({
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
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

class _FakeDeviceProvisioningNotifier extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.notRequired;
}

void main() {
  test(
    'apply(recommended) survives autoDispose of the applier provider',
    () async {
      final presetNotifier = _FakeNotificationPresetNotifier();
      final container = ProviderContainer(
        overrides: [
          deviceProvisioningProvider.overrideWith(
            _FakeDeviceProvisioningNotifier.new,
          ),
          notificationSlotsProvider.overrideWith(
            _SlowNotificationSlotsNotifier.new,
          ),
          generalNotificationSettingsProvider.overrideWith(
            _FakeGeneralNotificationSettingsNotifier.new,
          ),
          notificationPresetProvider.overrideWith(() => presetNotifier),
        ],
      );
      addTearDown(container.dispose);

      // 実アプリと同じく ref.read で applier を取得して即 apply する
      final applier = container.read(notificationPresetApplierProvider);
      await applier.apply(NotificationPreset.recommended);

      expect(presetNotifier.selectedPresets, [NotificationPreset.recommended]);
    },
  );
}
