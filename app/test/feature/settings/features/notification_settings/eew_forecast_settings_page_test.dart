import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/eew_forecast_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('shows slot-specific EEW forecast thresholds and subtitles', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          eewGlobalSettingsProvider.overrideWith(
            _FakeEewGlobalSettingsNotifier.new,
          ),
          notificationSlotsProvider.overrideWith(
            () => _FakeNotificationSlotsNotifier(slots: _slots),
          ),
        ],
        child: const _TestApp(home: EewForecastSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('通知する予想震度のしきい値'), findsOneWidget);
    expect(find.text('現在地でこの震度以上が予想された場合に通知します'), findsOneWidget);
    expect(find.text('全国でこの震度以上が予想された場合に通知します'), findsOneWidget);
    expect(find.text('東京都新宿区でこの震度以上が予想された場合に通知します'), findsOneWidget);
    expect(find.text('東京都新宿区'), findsOneWidget);

    final dropdowns = tester.widgetList<DropdownMenu<JmaIntensity>>(
      find.byType(DropdownMenu<JmaIntensity>),
    );
    expect(
      dropdowns.first.dropdownMenuEntries.map((entry) => entry.label),
      const ['すべて', '震度4', '震度5弱', '震度5強', '震度6弱', '震度6強', '震度7'],
    );
    expect(
      dropdowns.elementAt(1).dropdownMenuEntries.map((entry) => entry.label),
      const [
        'すべて',
        '震度1',
        '震度2',
        '震度3',
        '震度4',
        '震度5弱',
        '震度5強',
        '震度6弱',
        '震度6強',
        '震度7',
      ],
    );
  });
}

class _FakeEewGlobalSettingsNotifier extends EewGlobalSettingsNotifier {
  @override
  Future<EewGlobalSettings> build() async => const EewGlobalSettings(
    enabled: true,
    defaultSound: 'default',
    defaultInterruptionLevel: InterruptionLevel.active,
    startLiveActivity: true,
    collapseNotification: true,
    warningEnabled: true,
  );
}

class _FakeNotificationSlotsNotifier extends NotificationSlotsNotifier {
  _FakeNotificationSlotsNotifier({required this.slots});

  final List<NotificationSlot> slots;

  @override
  Future<List<NotificationSlot>> build() async => slots;
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    ),
    home: home,
  );
}

const _slots = [
  NotificationSlot(
    id: 'current',
    slotType: NotificationSlotType.currentLocation,
    regionId: null,
    regionName: null,
    cityCode: null,
    cityName: null,
    displayOrder: 0,
    eewEnabled: true,
    eewMinIntensity: JmaIntensity.four,
    eewOverrides: null,
    earthquakeEnabled: false,
    earthquakeMinIntensity: null,
    earthquakeOverrides: null,
  ),
  NotificationSlot(
    id: 'nationwide',
    slotType: NotificationSlotType.nationwide,
    regionId: null,
    regionName: null,
    cityCode: null,
    cityName: null,
    displayOrder: 1,
    eewEnabled: true,
    eewMinIntensity: JmaIntensity.one,
    eewOverrides: null,
    earthquakeEnabled: false,
    earthquakeMinIntensity: null,
    earthquakeOverrides: null,
  ),
  NotificationSlot(
    id: 'city',
    slotType: NotificationSlotType.region,
    regionId: 130000,
    regionName: '東京都',
    cityCode: '1310400',
    cityName: '新宿区',
    displayOrder: 2,
    eewEnabled: true,
    eewMinIntensity: JmaIntensity.fiveLower,
    eewOverrides: null,
    earthquakeEnabled: false,
    earthquakeMinIntensity: null,
    earthquakeOverrides: null,
  ),
];
