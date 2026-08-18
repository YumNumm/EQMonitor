import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/notification_preset_applier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_custom_snapshot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot_draft.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_warning_config_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_custom_snapshot_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart'
    hide SharedPreferencesAsync;

const _eewGlobal = EewGlobalSettings(
  enabled: false,
  defaultSound: 'default',
  defaultInterruptionLevel: InterruptionLevel.timeSensitive,
  startLiveActivity: false,
  collapseNotification: true,
  warningEnabled: false,
);

const _earthquakeGlobal = EarthquakeGlobalSettings(
  enabled: false,
  defaultSound: 'default',
  defaultInterruptionLevel: InterruptionLevel.active,
  estimatedIntensityEnabled: false,
  collapseNotification: true,
);

const _eewWarning = EewWarningSettings(
  target: EewWarningTarget.currentLocationOnly,
  currentLocationInterruptionLevel: InterruptionLevel.critical,
  nationwideInterruptionLevel: null,
);

const _general = GeneralNotificationSettings(
  notificationEnabled: false,
  tsunamiEnabled: false,
  trainingEnabled: false,
  nankaiExtraordinaryEnabled: false,
  nankaiRegularEnabled: false,
  vyse60Enabled: false,
  earthquakeNoticeEnabled: false,
);

class _RecordingSlotsNotifier extends NotificationSlotsNotifier {
  new(this._initial);

  final List<NotificationSlot> _initial;
  final replaceCalls = <List<NotificationSlotDraft>>[];

  @override
  Future<List<NotificationSlot>> build() async => _initial;

  @override
  Future<void> replaceSlots(List<NotificationSlotDraft> slots) async {
    replaceCalls.add(slots);
  }
}

class _RecordingGeneralNotifier extends GeneralNotificationSettingsNotifier {
  final calls = <Map<String, bool?>>[];

  @override
  Future<GeneralNotificationSettings> build() async => _general;

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
    calls.add({
      'notificationEnabled': notificationEnabled,
      'nankaiExtraordinaryEnabled': nankaiExtraordinaryEnabled,
      'nankaiRegularEnabled': nankaiRegularEnabled,
      'vyse60Enabled': vyse60Enabled,
      'earthquakeNoticeEnabled': earthquakeNoticeEnabled,
    });
  }
}

class _RecordingEewGlobalNotifier extends EewGlobalSettingsNotifier {
  final calls = <Map<String, bool?>>[];

  @override
  Future<EewGlobalSettings> build() async => _eewGlobal;

  @override
  Future<void> updateSettings({
    bool? enabled,
    String? defaultSound,
    InterruptionLevel? defaultInterruptionLevel,
    bool? startLiveActivity,
    bool? collapseNotification,
    bool? warningEnabled,
  }) async {
    calls.add({
      'enabled': enabled,
      'startLiveActivity': startLiveActivity,
      'warningEnabled': warningEnabled,
    });
  }
}

class _RecordingEarthquakeGlobalNotifier
    extends EarthquakeGlobalSettingsNotifier {
  final calls = <bool?>[];

  @override
  Future<EarthquakeGlobalSettings> build() async => _earthquakeGlobal;

  @override
  Future<void> updateSettings({
    bool? enabled,
    String? defaultSound,
    InterruptionLevel? defaultInterruptionLevel,
    bool? estimatedIntensityEnabled,
    bool? collapseNotification,
  }) async {
    calls.add(enabled);
  }
}

class _RecordingEewWarningNotifier extends EewWarningConfigNotifier {
  final calls = <EewWarningTarget?>[];
  final currentLocationLevels = <InterruptionLevel?>[];
  final nationwideLevels = <InterruptionLevel?>[];

  @override
  Future<EewWarningSettings> build() async => _eewWarning;

  @override
  Future<void> updateConfig({
    EewWarningTarget? target,
    InterruptionLevel? currentLocationInterruptionLevel,
    InterruptionLevel? nationwideInterruptionLevel,
  }) async {
    calls.add(target);
    currentLocationLevels.add(currentLocationInterruptionLevel);
    nationwideLevels.add(nationwideInterruptionLevel);
  }
}

class _RecordingPresetNotifier extends NotificationPresetNotifier {
  new(this._initial);

  final NotificationPreset _initial;
  final selected = <NotificationPreset>[];

  @override
  Future<NotificationPreset> build() async => _initial;

  @override
  Future<void> select(NotificationPreset preset) async {
    selected.add(preset);
    state = AsyncData(preset);
  }
}

Future<ProviderContainer> _container({
  required _RecordingSlotsNotifier slots,
  required _RecordingGeneralNotifier general,
  required _RecordingEewGlobalNotifier eewGlobal,
  required _RecordingEarthquakeGlobalNotifier earthquakeGlobal,
  required _RecordingEewWarningNotifier eewWarning,
  required _RecordingPresetNotifier preset,
}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  return ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(
        SharedPreferencesAsync(prefs),
      ),
      notificationSlotsProvider.overrideWith(() => slots),
      generalNotificationSettingsProvider.overrideWith(() => general),
      eewGlobalSettingsProvider.overrideWith(() => eewGlobal),
      earthquakeGlobalSettingsProvider.overrideWith(() => earthquakeGlobal),
      eewWarningConfigProvider.overrideWith(() => eewWarning),
      notificationPresetProvider.overrideWith(() => preset),
    ],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NotificationPresetApplier', () {
    test('recommended: 現在地のみ・グローバル有効化・プリセット選択', () async {
      final slots = _RecordingSlotsNotifier(const []);
      final general = _RecordingGeneralNotifier();
      final eewGlobal = _RecordingEewGlobalNotifier();
      final earthquakeGlobal = _RecordingEarthquakeGlobalNotifier();
      final eewWarning = _RecordingEewWarningNotifier();
      final preset = _RecordingPresetNotifier(NotificationPreset.recommended);
      final container = await _container(
        slots: slots,
        general: general,
        eewGlobal: eewGlobal,
        earthquakeGlobal: earthquakeGlobal,
        eewWarning: eewWarning,
        preset: preset,
      );
      addTearDown(container.dispose);

      await container
          .read(notificationPresetApplierProvider)
          .apply(NotificationPreset.recommended);

      expect(slots.replaceCalls, hasLength(1));
      final applied = slots.replaceCalls.single;
      expect(applied, hasLength(1));
      expect(applied.single.slotType, NotificationSlotType.currentLocation);
      expect(applied.single.eewMinIntensity, JmaIntensity.four);
      expect(applied.single.earthquakeMinIntensity, JmaIntensity.one);
      expect(general.calls.single['notificationEnabled'], isTrue);
      expect(eewGlobal.calls.single['enabled'], isTrue);
      expect(eewGlobal.calls.single['startLiveActivity'], isTrue);
      expect(eewGlobal.calls.single['warningEnabled'], isTrue);
      expect(earthquakeGlobal.calls.single, isTrue);
      expect(preset.selected, [NotificationPreset.recommended]);
    });

    test('all: 全国すべて・南海トラフ有効化', () async {
      final slots = _RecordingSlotsNotifier(const []);
      final general = _RecordingGeneralNotifier();
      final eewGlobal = _RecordingEewGlobalNotifier();
      final earthquakeGlobal = _RecordingEarthquakeGlobalNotifier();
      final eewWarning = _RecordingEewWarningNotifier();
      final preset = _RecordingPresetNotifier(NotificationPreset.recommended);
      final container = await _container(
        slots: slots,
        general: general,
        eewGlobal: eewGlobal,
        earthquakeGlobal: earthquakeGlobal,
        eewWarning: eewWarning,
        preset: preset,
      );
      addTearDown(container.dispose);

      await container
          .read(notificationPresetApplierProvider)
          .apply(NotificationPreset.all);

      final applied = slots.replaceCalls.single;
      expect(applied, hasLength(2));
      final nationwide = applied.firstWhere(
        (s) => s.slotType == NotificationSlotType.nationwide,
      );
      expect(nationwide.eewMinIntensity, JmaIntensity.zero);
      expect(nationwide.earthquakeMinIntensity, JmaIntensity.zero);
      expect(general.calls.single['notificationEnabled'], isTrue);
      expect(general.calls.single['nankaiExtraordinaryEnabled'], isTrue);
      expect(general.calls.single['nankaiRegularEnabled'], isTrue);
      expect(general.calls.single['vyse60Enabled'], isTrue);
      expect(general.calls.single['earthquakeNoticeEnabled'], isTrue);
      expect(eewGlobal.calls.single['startLiveActivity'], isTrue);
      // EEW 警報は現在地 + 全国対象にする（warningEnabled: true の後に上書き）
      expect(
        eewWarning.calls.single,
        EewWarningTarget.currentLocationAndNationwide,
      );
      expect(
        eewWarning.nationwideLevels.single,
        InterruptionLevel.timeSensitive,
      );
      expect(
        eewWarning.currentLocationLevels.single,
        InterruptionLevel.critical,
      );
      expect(preset.selected, [NotificationPreset.all]);
    });

    test('none: 全スロット削除・通知無効・Live Activity無効', () async {
      final slots = _RecordingSlotsNotifier(const []);
      final general = _RecordingGeneralNotifier();
      final eewGlobal = _RecordingEewGlobalNotifier();
      final earthquakeGlobal = _RecordingEarthquakeGlobalNotifier();
      final eewWarning = _RecordingEewWarningNotifier();
      final preset = _RecordingPresetNotifier(NotificationPreset.recommended);
      final container = await _container(
        slots: slots,
        general: general,
        eewGlobal: eewGlobal,
        earthquakeGlobal: earthquakeGlobal,
        eewWarning: eewWarning,
        preset: preset,
      );
      addTearDown(container.dispose);

      await container
          .read(notificationPresetApplierProvider)
          .apply(NotificationPreset.none);

      expect(slots.replaceCalls.single, isEmpty);
      expect(general.calls.single['notificationEnabled'], isFalse);
      expect(eewGlobal.calls.single['enabled'], isTrue);
      expect(eewGlobal.calls.single['startLiveActivity'], isFalse);
      expect(earthquakeGlobal.calls.single, isTrue);
      expect(preset.selected, [NotificationPreset.none]);
    });

    test('custom: スナップショットが無ければ現在地のみ', () async {
      final slots = _RecordingSlotsNotifier(const []);
      final general = _RecordingGeneralNotifier();
      final eewGlobal = _RecordingEewGlobalNotifier();
      final earthquakeGlobal = _RecordingEarthquakeGlobalNotifier();
      final eewWarning = _RecordingEewWarningNotifier();
      final preset = _RecordingPresetNotifier(NotificationPreset.recommended);
      final container = await _container(
        slots: slots,
        general: general,
        eewGlobal: eewGlobal,
        earthquakeGlobal: earthquakeGlobal,
        eewWarning: eewWarning,
        preset: preset,
      );
      addTearDown(container.dispose);

      await container
          .read(notificationPresetApplierProvider)
          .apply(NotificationPreset.custom);

      final applied = slots.replaceCalls.single;
      expect(applied, hasLength(1));
      expect(applied.single.slotType, NotificationSlotType.currentLocation);
      expect(eewGlobal.calls.single['enabled'], isTrue);
      expect(eewGlobal.calls.single['startLiveActivity'], isTrue);
      expect(earthquakeGlobal.calls.single, isTrue);
      expect(eewWarning.calls, isEmpty);
      expect(preset.selected, [NotificationPreset.custom]);
    });

    test('custom: スナップショットがあればスロットと警報設定を復元', () async {
      final slots = _RecordingSlotsNotifier(const []);
      final general = _RecordingGeneralNotifier();
      final eewGlobal = _RecordingEewGlobalNotifier();
      final earthquakeGlobal = _RecordingEarthquakeGlobalNotifier();
      final eewWarning = _RecordingEewWarningNotifier();
      final preset = _RecordingPresetNotifier(NotificationPreset.all);
      final container = await _container(
        slots: slots,
        general: general,
        eewGlobal: eewGlobal,
        earthquakeGlobal: earthquakeGlobal,
        eewWarning: eewWarning,
        preset: preset,
      );
      addTearDown(container.dispose);

      final snapshotRepo = await container.read(
        notificationCustomSnapshotRepositoryProvider.future,
      );
      await snapshotRepo.save(
        const NotificationCustomSnapshot(
          schemaVersion: notificationCustomSnapshotSchemaVersion,
          slots: [
            NotificationSlotDraft(
              slotType: NotificationSlotType.region,
              regionId: 10,
              regionName: '東京都',
              eewEnabled: true,
              eewMinIntensity: JmaIntensity.three,
              earthquakeEnabled: true,
              earthquakeMinIntensity: JmaIntensity.two,
            ),
          ],
          eewWarning: EewWarningSettings(
            target: EewWarningTarget.currentLocationAndNationwide,
            currentLocationInterruptionLevel: InterruptionLevel.critical,
            nationwideInterruptionLevel: InterruptionLevel.active,
          ),
          eewGlobal: _eewGlobal,
          earthquakeGlobal: _earthquakeGlobal,
          general: _general,
        ),
      );

      await container
          .read(notificationPresetApplierProvider)
          .apply(NotificationPreset.custom);

      final applied = slots.replaceCalls.single;
      expect(applied, hasLength(1));
      expect(applied.single.slotType, NotificationSlotType.region);
      expect(applied.single.regionId, 10);
      expect(eewGlobal.calls.single['enabled'], isTrue);
      expect(eewGlobal.calls.single['startLiveActivity'], isTrue);
      expect(earthquakeGlobal.calls.single, isTrue);
      expect(eewWarning.calls, [EewWarningTarget.currentLocationAndNationwide]);
      expect(preset.selected, [NotificationPreset.custom]);
    });

    test('カスタムから離脱するとスナップショットを保存する', () async {
      final slots = _RecordingSlotsNotifier(const [
        NotificationSlot(
          id: 'slot-1',
          slotType: NotificationSlotType.region,
          regionId: 20,
          regionName: '大阪府',
          cityCode: null,
          cityName: null,
          displayOrder: 0,
          eewEnabled: true,
          eewMinIntensity: JmaIntensity.four,
          eewOverrides: null,
          earthquakeEnabled: true,
          earthquakeMinIntensity: JmaIntensity.one,
          earthquakeOverrides: null,
        ),
      ]);
      final general = _RecordingGeneralNotifier();
      final eewGlobal = _RecordingEewGlobalNotifier();
      final earthquakeGlobal = _RecordingEarthquakeGlobalNotifier();
      final eewWarning = _RecordingEewWarningNotifier();
      final preset = _RecordingPresetNotifier(NotificationPreset.custom);
      final container = await _container(
        slots: slots,
        general: general,
        eewGlobal: eewGlobal,
        earthquakeGlobal: earthquakeGlobal,
        eewWarning: eewWarning,
        preset: preset,
      );
      addTearDown(container.dispose);

      await container
          .read(notificationPresetApplierProvider)
          .apply(NotificationPreset.recommended);

      final snapshotRepo = await container.read(
        notificationCustomSnapshotRepositoryProvider.future,
      );
      final saved = await snapshotRepo.load();
      expect(saved, isNotNull);
      expect(saved!.slots.single.regionId, 20);
      expect(preset.selected, [NotificationPreset.recommended]);
    });
  });
}
