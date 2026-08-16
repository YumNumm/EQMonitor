import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_kind.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/override_edit_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// `_OverrideFormDialog`(StatefulWidget)の振る舞いを、HookWidget化前に固定するテスト。
void main() {
  testWidgets('追加ダイアログの初期値は先頭の候補震度・デフォルト音・activeになる', (tester) async {
    final container = await _pumpPage(
      tester,
      overrides: const [],
      slotId: 'region-1',
    );
    addTearDown(container.dispose);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('震度別設定を追加'), findsOneWidget);
    expect(
      tester
          .widget<DropdownButton<JmaIntensity>>(
            find.byType(DropdownButton<JmaIntensity>),
          )
          .value,
      JmaIntensity.zero,
    );
    expect(
      tester
          .widget<DropdownButton<NotificationSound>>(
            find.byType(DropdownButton<NotificationSound>),
          )
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

    await tester.tap(find.byType(FloatingActionButton));
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

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.tap(find.text('デフォルト').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('EEW警報音').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text(InterruptionLevel.critical.name).last);
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
    expect(find.text('震度0以上'), findsOneWidget);
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
    expect(
      tester
          .widget<RadioGroup<InterruptionLevel>>(
            find.byType(RadioGroup<InterruptionLevel>),
          )
          .groupValue,
      InterruptionLevel.active,
    );

    await tester.tap(find.text(InterruptionLevel.passive.name).last);
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
  _FakeNotificationSlotsNotifier(this._initial);

  final NotificationSlot _initial;
  List<NotificationOverride>? lastEarthquakeOverrides;

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
  const _TestApp({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    );
    return MaterialApp(theme: theme, home: home);
  }
}
