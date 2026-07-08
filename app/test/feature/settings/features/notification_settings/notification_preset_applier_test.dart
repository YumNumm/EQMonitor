import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/notification_preset_applier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class _PutCurrentLocationCall {
  const _PutCurrentLocationCall({
    required this.eewEnabled,
    required this.eewMinIntensity,
    required this.earthquakeEnabled,
    required this.earthquakeMinIntensity,
  });

  final bool? eewEnabled;
  final JmaIntensity? eewMinIntensity;
  final bool? earthquakeEnabled;
  final JmaIntensity? earthquakeMinIntensity;
}

final class _PutNationwideCall {
  const _PutNationwideCall({
    required this.eewEnabled,
    required this.eewMinIntensity,
    required this.earthquakeEnabled,
    required this.earthquakeMinIntensity,
  });

  final bool? eewEnabled;
  final JmaIntensity? eewMinIntensity;
  final bool? earthquakeEnabled;
  final JmaIntensity? earthquakeMinIntensity;
}

class _RecordingNotificationSlotsNotifier extends NotificationSlotsNotifier {
  final putCurrentLocationCalls = <_PutCurrentLocationCall>[];
  final putNationwideCalls = <_PutNationwideCall>[];

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
    putCurrentLocationCalls.add(
      _PutCurrentLocationCall(
        eewEnabled: eewEnabled,
        eewMinIntensity: eewMinIntensity,
        earthquakeEnabled: earthquakeEnabled,
        earthquakeMinIntensity: earthquakeMinIntensity,
      ),
    );
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
    putNationwideCalls.add(
      _PutNationwideCall(
        eewEnabled: eewEnabled,
        eewMinIntensity: eewMinIntensity,
        earthquakeEnabled: earthquakeEnabled,
        earthquakeMinIntensity: earthquakeMinIntensity,
      ),
    );
  }
}

class _RecordingGeneralNotificationSettingsNotifier
    extends GeneralNotificationSettingsNotifier {
  final updateSettingsCalls = <bool?>[];

  @override
  Future<GeneralNotificationSettings> build() async =>
      const GeneralNotificationSettings(
        notificationEnabled: false,
        tsunamiEnabled: false,
        trainingEnabled: false,
        nankaiExtraordinaryEnabled: false,
        nankaiRegularEnabled: false,
        hokkaido3renOffshoreEnabled: false,
      );

  @override
  Future<void> updateSettings({
    bool? notificationEnabled,
    bool? tsunamiEnabled,
    bool? trainingEnabled,
    bool? nankaiExtraordinaryEnabled,
    bool? nankaiRegularEnabled,
    bool? hokkaido3renOffshoreEnabled,
  }) async {
    updateSettingsCalls.add(notificationEnabled);
  }
}

class _RecordingNotificationPresetNotifier extends NotificationPresetNotifier {
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

ProviderContainer _container({
  required _RecordingNotificationSlotsNotifier slotsNotifier,
  required _RecordingGeneralNotificationSettingsNotifier settingsNotifier,
  required _RecordingNotificationPresetNotifier presetNotifier,
}) {
  return ProviderContainer(
    overrides: [
      deviceProvisioningProvider.overrideWith(
        _FakeDeviceProvisioningNotifier.new,
      ),
      notificationSlotsProvider.overrideWith(() => slotsNotifier),
      generalNotificationSettingsProvider.overrideWith(
        () => settingsNotifier,
      ),
      notificationPresetProvider.overrideWith(() => presetNotifier),
    ],
  );
}

void main() {
  group('NotificationPresetApplier', () {
    test('recommended applies current location, enables notifications, selects preset',
        () async {
      final slotsNotifier = _RecordingNotificationSlotsNotifier();
      final settingsNotifier = _RecordingGeneralNotificationSettingsNotifier();
      final presetNotifier = _RecordingNotificationPresetNotifier();
      final container = _container(
        slotsNotifier: slotsNotifier,
        settingsNotifier: settingsNotifier,
        presetNotifier: presetNotifier,
      );
      addTearDown(container.dispose);

      await container
          .read(notificationPresetApplierProvider)
          .apply(NotificationPreset.recommended);

      expect(slotsNotifier.putCurrentLocationCalls, hasLength(1));
      final recommendedCall = slotsNotifier.putCurrentLocationCalls.first;
      expect(recommendedCall.eewEnabled, isTrue);
      expect(recommendedCall.eewMinIntensity, JmaIntensity.four);
      expect(recommendedCall.earthquakeEnabled, isTrue);
      expect(recommendedCall.earthquakeMinIntensity, JmaIntensity.one);
      expect(slotsNotifier.putNationwideCalls, isEmpty);
      expect(settingsNotifier.updateSettingsCalls, [true]);
      expect(presetNotifier.selectedPresets, [NotificationPreset.recommended]);
    });

    test('all applies recommended settings plus nationwide', () async {
      final slotsNotifier = _RecordingNotificationSlotsNotifier();
      final settingsNotifier = _RecordingGeneralNotificationSettingsNotifier();
      final presetNotifier = _RecordingNotificationPresetNotifier();
      final container = _container(
        slotsNotifier: slotsNotifier,
        settingsNotifier: settingsNotifier,
        presetNotifier: presetNotifier,
      );
      addTearDown(container.dispose);

      await container
          .read(notificationPresetApplierProvider)
          .apply(NotificationPreset.all);

      expect(slotsNotifier.putCurrentLocationCalls, hasLength(1));
      final allCurrentLocationCall = slotsNotifier.putCurrentLocationCalls.first;
      expect(allCurrentLocationCall.eewEnabled, isTrue);
      expect(allCurrentLocationCall.eewMinIntensity, JmaIntensity.four);
      expect(allCurrentLocationCall.earthquakeEnabled, isTrue);
      expect(allCurrentLocationCall.earthquakeMinIntensity, JmaIntensity.one);
      expect(slotsNotifier.putNationwideCalls, hasLength(1));
      final nationwideCall = slotsNotifier.putNationwideCalls.first;
      expect(nationwideCall.eewEnabled, isTrue);
      expect(nationwideCall.eewMinIntensity, defaultNotificationSlotMinIntensity);
      expect(nationwideCall.earthquakeEnabled, isTrue);
      expect(
        nationwideCall.earthquakeMinIntensity,
        defaultNotificationSlotMinIntensity,
      );
      expect(settingsNotifier.updateSettingsCalls, [true]);
      expect(presetNotifier.selectedPresets, [NotificationPreset.all]);
    });

    test('none disables notifications without creating slots', () async {
      final slotsNotifier = _RecordingNotificationSlotsNotifier();
      final settingsNotifier = _RecordingGeneralNotificationSettingsNotifier();
      final presetNotifier = _RecordingNotificationPresetNotifier();
      final container = _container(
        slotsNotifier: slotsNotifier,
        settingsNotifier: settingsNotifier,
        presetNotifier: presetNotifier,
      );
      addTearDown(container.dispose);

      await container
          .read(notificationPresetApplierProvider)
          .apply(NotificationPreset.none);

      expect(slotsNotifier.putCurrentLocationCalls, isEmpty);
      expect(slotsNotifier.putNationwideCalls, isEmpty);
      expect(settingsNotifier.updateSettingsCalls, [false]);
      expect(presetNotifier.selectedPresets, [NotificationPreset.none]);
    });

    test('custom applies current location only without selecting preset',
        () async {
      final slotsNotifier = _RecordingNotificationSlotsNotifier();
      final settingsNotifier = _RecordingGeneralNotificationSettingsNotifier();
      final presetNotifier = _RecordingNotificationPresetNotifier();
      final container = _container(
        slotsNotifier: slotsNotifier,
        settingsNotifier: settingsNotifier,
        presetNotifier: presetNotifier,
      );
      addTearDown(container.dispose);

      await container
          .read(notificationPresetApplierProvider)
          .apply(NotificationPreset.custom);

      expect(slotsNotifier.putCurrentLocationCalls, hasLength(1));
      final customCall = slotsNotifier.putCurrentLocationCalls.first;
      expect(customCall.eewEnabled, isTrue);
      expect(customCall.eewMinIntensity, JmaIntensity.four);
      expect(customCall.earthquakeEnabled, isTrue);
      expect(customCall.earthquakeMinIntensity, JmaIntensity.one);
      expect(slotsNotifier.putNationwideCalls, isEmpty);
      expect(settingsNotifier.updateSettingsCalls, isEmpty);
      expect(presetNotifier.selectedPresets, isEmpty);
    });
  });
}
