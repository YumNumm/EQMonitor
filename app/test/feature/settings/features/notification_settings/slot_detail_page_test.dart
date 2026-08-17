import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_warning_config_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

const _warningDescription = '緊急地震速報（警報）は、現在地や全国を対象に重大な通知として配信されます。';

void main() {
  testWidgets('current location updates warning and selected EEW intensity', (
    tester,
  ) async {
    final slotsNotifier = _RecordingSlotsNotifier(
      _slot(type: NotificationSlotType.currentLocation),
    );
    final eewNotifier = _RecordingEewGlobalSettingsNotifier();
    final warningNotifier = _RecordingEewWarningConfigNotifier(
      initialTarget: EewWarningTarget.currentLocationAndNationwide,
    );

    await tester.pumpWidget(
      _TestApp(
        slot: slotsNotifier.slot,
        slotsNotifier: slotsNotifier,
        eewNotifier: eewNotifier,
        warningNotifier: warningNotifier,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('緊急地震速報（警報）'), findsOneWidget);
    expect(find.text(_warningDescription), findsOneWidget);
    expect(find.byType(DropdownMenu<JmaIntensity>), findsNWidgets(2));

    final warningTile = find.widgetWithText(ListTile, '有効').at(1);
    await tester.ensureVisible(warningTile);
    await tester.tap(warningTile);
    await tester.pumpAndSettle();
    expect(eewNotifier.lastWarningEnabled, isFalse);
    expect(
      warningNotifier.state.requireValue.target,
      EewWarningTarget.currentLocationOnly,
    );

    await tester.tap(find.widgetWithText(ListTile, '有効').at(1));
    await tester.pumpAndSettle();
    expect(eewNotifier.lastWarningEnabled, isTrue);
    expect(eewNotifier.state.requireValue.warningEnabled, isTrue);
    expect(
      warningNotifier.state.requireValue.target,
      EewWarningTarget.currentLocationOnly,
    );

    final eewDropdown = find.byType(DropdownMenu<JmaIntensity>).first;
    final dropdown = tester.widget<DropdownMenu<JmaIntensity>>(eewDropdown);
    dropdown.onSelected?.call(JmaIntensity.three);
    await tester.pumpAndSettle();
    expect(slotsNotifier.lastEewMinIntensity, JmaIntensity.three);
  });

  testWidgets('nationwide warning can be enabled without Pro', (tester) async {
    final slot = _slot(type: NotificationSlotType.nationwide);
    final warningNotifier = _RecordingEewWarningConfigNotifier();
    final eewNotifier = _RecordingEewGlobalSettingsNotifier(
      initialWarningEnabled: false,
    );

    await tester.pumpWidget(
      _TestApp(
        slot: slot,
        slotsNotifier: _RecordingSlotsNotifier(slot),
        eewNotifier: eewNotifier,
        warningNotifier: warningNotifier,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('緊急地震速報（警報）'), findsOneWidget);
    expect(find.text(_warningDescription), findsOneWidget);

    final warningTile = find.widgetWithText(ListTile, '有効').at(1);
    await tester.ensureVisible(warningTile);
    await tester.tap(warningTile);
    await tester.pumpAndSettle();

    expect(
      warningNotifier.lastTarget,
      EewWarningTarget.currentLocationAndNationwide,
    );
    expect(
      warningNotifier.lastNationwideInterruptionLevel,
      InterruptionLevel.active,
    );
    expect(eewNotifier.state.requireValue.warningEnabled, isTrue);

    await tester.tap(find.widgetWithText(ListTile, '有効').at(1));
    await tester.pumpAndSettle();
    expect(warningNotifier.lastTarget, EewWarningTarget.currentLocationOnly);
    expect(warningNotifier.lastNationwideInterruptionLevel, isNull);
    expect(eewNotifier.state.requireValue.warningEnabled, isTrue);
  });

  testWidgets('region does not show warning settings', (tester) async {
    final slot = _slot(type: NotificationSlotType.region);

    await tester.pumpWidget(
      _TestApp(
        slot: slot,
        slotsNotifier: _RecordingSlotsNotifier(slot),
        eewNotifier: _RecordingEewGlobalSettingsNotifier(),
        warningNotifier: _RecordingEewWarningConfigNotifier(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('緊急地震速報（警報）'), findsNothing);
    expect(find.text(_warningDescription), findsNothing);
    expect(find.byType(AppSwitch), findsNWidgets(2));
  });
}

NotificationSlot _slot({required NotificationSlotType type}) =>
    NotificationSlot(
      id: type.name,
      slotType: type,
      regionId: type == NotificationSlotType.region ? 130000 : null,
      regionName: type == NotificationSlotType.region ? '東京都' : null,
      cityCode: null,
      cityName: null,
      displayOrder: 0,
      eewEnabled: true,
      eewMinIntensity: JmaIntensity.four,
      eewOverrides: null,
      earthquakeEnabled: true,
      earthquakeMinIntensity: JmaIntensity.one,
      earthquakeOverrides: null,
    );

class _RecordingSlotsNotifier extends NotificationSlotsNotifier {
  _RecordingSlotsNotifier(this.slot);

  final NotificationSlot slot;
  JmaIntensity? lastEewMinIntensity;

  @override
  Future<List<NotificationSlot>> build() async => [slot];

  @override
  Future<void> putCurrentLocation({
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    lastEewMinIntensity = eewMinIntensity;
  }
}

class _RecordingEewGlobalSettingsNotifier extends EewGlobalSettingsNotifier {
  _RecordingEewGlobalSettingsNotifier({this.initialWarningEnabled = true});

  final bool initialWarningEnabled;
  bool? lastWarningEnabled;

  @override
  Future<EewGlobalSettings> build() async => EewGlobalSettings(
    enabled: true,
    defaultSound: 'default',
    defaultInterruptionLevel: InterruptionLevel.active,
    startLiveActivity: true,
    collapseNotification: true,
    warningEnabled: initialWarningEnabled,
  );

  @override
  Future<void> updateSettings({
    bool? enabled,
    String? defaultSound,
    InterruptionLevel? defaultInterruptionLevel,
    bool? startLiveActivity,
    bool? collapseNotification,
    bool? warningEnabled,
  }) async {
    lastWarningEnabled = warningEnabled;
    state = AsyncData(
      state.requireValue.copyWith(
        warningEnabled: warningEnabled ?? state.requireValue.warningEnabled,
      ),
    );
  }
}

class _RecordingEewWarningConfigNotifier extends EewWarningConfigNotifier {
  _RecordingEewWarningConfigNotifier({
    this.initialTarget = EewWarningTarget.currentLocationOnly,
  });

  final EewWarningTarget initialTarget;
  EewWarningTarget? lastTarget;
  InterruptionLevel? lastNationwideInterruptionLevel;

  @override
  Future<EewWarningSettings> build() async => EewWarningSettings(
    target: initialTarget,
    nationwideInterruptionLevel: null,
  );

  @override
  Future<void> updateConfig({
    EewWarningTarget? target,
    InterruptionLevel? nationwideInterruptionLevel,
  }) async {
    lastTarget = target;
    lastNationwideInterruptionLevel = nationwideInterruptionLevel;
    state = AsyncData(
      EewWarningSettings(
        target: target ?? state.requireValue.target,
        nationwideInterruptionLevel: nationwideInterruptionLevel,
      ),
    );
  }
}

class _TestApp extends StatelessWidget {
  const _TestApp({
    required this.slot,
    required this.slotsNotifier,
    required this.eewNotifier,
    required this.warningNotifier,
  });

  final NotificationSlot slot;
  final _RecordingSlotsNotifier slotsNotifier;
  final _RecordingEewGlobalSettingsNotifier eewNotifier;
  final _RecordingEewWarningConfigNotifier warningNotifier;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    );
    return ProviderScope(
      overrides: [
        notificationSlotsProvider.overrideWith(() => slotsNotifier),
        eewGlobalSettingsProvider.overrideWith(() => eewNotifier),
        eewWarningConfigProvider.overrideWith(() => warningNotifier),
      ],
      child: MaterialApp(
        theme: theme,
        home: SlotDetailPage(slotId: slot.id, isPro: false),
      ),
    );
  }
}
