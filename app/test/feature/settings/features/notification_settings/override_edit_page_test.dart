import 'dart:async';

import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_kind.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/override_edit_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

/// `_OverrideFormDialog`(StatefulWidget)の振る舞いを、HookWidget化前に固定するテスト。
void main() {
  testWidgets('追加ダイアログの初期値は先頭の候補震度・デフォルト音・activeになる', (tester) async {
    final container = await _pumpPage(
      tester,
      overrides: const [],
      slotId: 'region-1',
    );
    addTearDown(container.dispose);

    await tester.tap(find.byType(M3EFloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('震度別設定を追加'), findsOneWidget);
    expect(
      tester
          .widget<ControlledDropdown<JmaIntensity>>(
            find.byType(ControlledDropdown<JmaIntensity>),
          )
          .items
          .singleWhere((item) => item.selected)
          .value,
      JmaIntensity.zero,
    );
    expect(
      tester
          .widget<ControlledDropdown<NotificationSound>>(
            find.byType(ControlledDropdown<NotificationSound>),
          )
          .items
          .singleWhere((item) => item.selected)
          .value,
      NotificationSound.defaultSound,
    );
    expect(
      tester
          .widget<RadioGroup<InterruptionLevel>>(
            find.byType(RadioGroup<InterruptionLevel>),
          )
          .groupValue,
      InterruptionLevel.active,
    );
  });

  testWidgets('追加ダイアログでキャンセルすると設定は追加されない', (tester) async {
    final container = await _pumpPage(
      tester,
      overrides: const [],
      slotId: 'region-1',
    );
    addTearDown(container.dispose);

    await tester.tap(find.byType(M3EFloatingActionButton));
    await tester.pumpAndSettle();

    await tester.tap(find.text('キャンセル'));
    await tester.pumpAndSettle();

    expect(find.text('震度別設定がありません'), findsOneWidget);
  });

  testWidgets('追加ダイアログで通知音と割り込みレベルを選んで追加すると一覧に反映される', (tester) async {
    final container = await _pumpPage(
      tester,
      overrides: const [],
      slotId: 'region-1',
    );
    addTearDown(container.dispose);

    await tester.tap(find.byType(M3EFloatingActionButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ControlledDropdown<NotificationSound>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('EEW警報音').last);
    await tester.pumpAndSettle();

    final criticalOption = find.widgetWithText(
      RadioListTile<InterruptionLevel>,
      InterruptionLevel.critical.label,
    );
    await tester.ensureVisible(criticalOption);
    await tester.pumpAndSettle();
    await tester.tap(criticalOption);
    await tester.pumpAndSettle();

    await tester.tap(find.text('追加'));
    await tester.pumpAndSettle();

    final fake = container.read(
      notificationSlotsProvider.notifier,
    ) as _FakeNotificationSlotsNotifier;
    expect(fake.lastEarthquakeOverrides, hasLength(1));
    expect(fake.lastEarthquakeOverrides!.single.sound, 'eew_warning');
    expect(
      fake.lastEarthquakeOverrides!.single.interruptionLevel,
      InterruptionLevel.critical,
    );
    expect(find.text('すべて'), findsOneWidget);
  });

  testWidgets('編集ダイアログは既存設定の値で初期化され、保存すると更新される', (tester) async {
    final existing = NotificationOverride(
      minJmaIntensity: JmaIntensity.three,
      sound: 'default',
      interruptionLevel: InterruptionLevel.active,
    );
    final container = await _pumpPage(
      tester,
      overrides: [existing],
      slotId: 'region-1',
    );
    addTearDown(container.dispose);

    await tester.tap(find.text('震度3以上'));
    await tester.pumpAndSettle();

    expect(find.text('震度別設定を編集'), findsOneWidget);
    final intensityDropdown = tester.widget<ControlledDropdown<JmaIntensity>>(
      find.byType(ControlledDropdown<JmaIntensity>),
    );
    expect(intensityDropdown.enabled, isFalse);
    expect(
      intensityDropdown.items.singleWhere((item) => item.selected).value,
      JmaIntensity.three,
    );
    expect(
      tester
          .widget<RadioGroup<InterruptionLevel>>(
            find.byType(RadioGroup<InterruptionLevel>),
          )
          .groupValue,
      InterruptionLevel.active,
    );

    await tester.tap(find.text(InterruptionLevel.passive.label).last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    final fake = container.read(
      notificationSlotsProvider.notifier,
    ) as _FakeNotificationSlotsNotifier;
    expect(fake.lastEarthquakeOverrides, hasLength(1));
    expect(
      fake.lastEarthquakeOverrides!.single.interruptionLevel,
      InterruptionLevel.passive,
    );
  });
  testWidgets('保存が遅れて失敗しても削除対象と隣の条件を復元する', (tester) async {
    final overrides = [
      for (final intensity in [
        JmaIntensity.one,
        JmaIntensity.three,
        JmaIntensity.fiveUpper,
      ])
        NotificationOverride(
          minJmaIntensity: intensity,
          sound: 'default',
          interruptionLevel: .active,
        ),
    ];
    final container = await _pumpPage(
      tester,
      overrides: overrides,
      slotId: 'region-1',
    );
    addTearDown(container.dispose);
    final notifier = container.read(
      notificationSlotsProvider.notifier,
    ) as _FakeNotificationSlotsNotifier;
    final gate = Completer<void>();
    notifier.saveGate = gate;
    notifier.failSave = true;

    await tester.drag(find.text('震度3以上'), const Offset(-700, 0));
    await tester.pumpAndSettle();
    expect(find.text('震度3以上'), findsNothing);
    gate.complete();
    await tester.pumpAndSettle();

    expect(find.text('震度1以上'), findsOneWidget);
    expect(find.text('震度3以上'), findsOneWidget);
    expect(find.text('震度5+以上'), findsOneWidget);
    expect(notifier.lastEarthquakeOverrides, isNull);
    expect(find.textContaining('設定の保存に失敗しました'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('中央の条件だけを識別して削除し隣の通知条件を保持する', (tester) async {
    final overrides = [
      for (final intensity in [
        JmaIntensity.one,
        JmaIntensity.three,
        JmaIntensity.fiveUpper,
      ])
        NotificationOverride(
          minJmaIntensity: intensity,
          sound: 'default',
          interruptionLevel: .active,
        ),
    ];
    final container = await _pumpPage(
      tester,
      overrides: overrides,
      slotId: 'region-1',
    );
    addTearDown(container.dispose);
    await tester.drag(find.text('震度3以上'), const Offset(-700, 0));
    await tester.pumpAndSettle();

    final notifier = container.read(
      notificationSlotsProvider.notifier,
    ) as _FakeNotificationSlotsNotifier;
    expect(
      notifier.lastEarthquakeOverrides?.map((entry) => entry.minJmaIntensity),
      [JmaIntensity.one, JmaIntensity.fiveUpper],
    );
    expect(find.text('震度1以上'), findsOneWidget);
    expect(find.text('震度3以上'), findsNothing);
    expect(find.text('震度5+以上'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<ProviderContainer> _pumpPage(
  WidgetTester tester, {
  required List<NotificationOverride> overrides,
  required String slotId,
}) async {
  final slot = NotificationSlot(
    id: slotId,
    slotType: NotificationSlotType.region,
    regionId: 1,
    regionName: 'テスト地域',
    cityCode: null,
    cityName: null,
    displayOrder: 0,
    eewEnabled: true,
    eewMinIntensity: JmaIntensity.three,
    eewOverrides: const [],
    earthquakeEnabled: true,
    earthquakeMinIntensity: JmaIntensity.three,
    earthquakeOverrides: overrides,
  );

  final container = ProviderContainer(
    overrides: [
      notificationSlotsProvider.overrideWith(
        () => _FakeNotificationSlotsNotifier(slot),
      ),
    ],
  );

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: _TestApp(
        home: OverrideEditPage(
          slotId: slotId,
          slotType: NotificationSlotType.region,
          overrideType: NotificationKind.earthquake,
          currentOverrides: overrides,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

class _FakeNotificationSlotsNotifier extends NotificationSlotsNotifier {
  new(this._initial);

  final NotificationSlot _initial;
  List<NotificationOverride>? lastEarthquakeOverrides;
  Completer<void>? saveGate;
  bool failSave = false;

  @override
  Future<List<NotificationSlot>> build() async => [_initial];

  @override
  Future<void> updateRegion({
    required String slotId,
    String? regionName,
    String? cityCode,
    String? cityName,
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    await saveGate?.future;
    if (failSave) throw StateError('保存テストエラー');
    lastEarthquakeOverrides = earthquakeOverrides;
    final current = state.value ?? [_initial];
    state = AsyncData([
      for (final s in current)
        if (s.id == slotId)
          s.copyWith(
            earthquakeOverrides: earthquakeOverrides ?? s.earthquakeOverrides,
          )
        else
          s,
    ]);
  }
}

class _TestApp extends StatelessWidget {
  const new({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    );
    return MaterialApp(theme: theme, home: home);
  }
}
