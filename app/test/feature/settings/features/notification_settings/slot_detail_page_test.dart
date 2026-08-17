import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('uses the EEW threshold policy without changing earthquake UI', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notificationSlotsProvider.overrideWith(
            () => _FakeNotificationSlotsNotifier(slot: _slot),
          ),
        ],
        child: const _TestApp(
          home: SlotDetailPage(slotId: 'current', isPro: false),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('通知する予想震度のしきい値'), findsOneWidget);
    expect(find.text('現在地でこの震度以上が予想された場合に通知します'), findsOneWidget);
    expect(find.text('最小震度'), findsOneWidget);

    final dropdowns = tester.widgetList<DropdownMenu<JmaIntensity>>(
      find.byType(DropdownMenu<JmaIntensity>),
    );
    expect(
      dropdowns.first.dropdownMenuEntries.map((entry) => entry.label),
      const ['すべて', '震度4', '震度5弱', '震度5強', '震度6弱', '震度6強', '震度7'],
    );
  });
}

class _FakeNotificationSlotsNotifier extends NotificationSlotsNotifier {
  _FakeNotificationSlotsNotifier({required this.slot});

  final NotificationSlot slot;

  @override
  Future<List<NotificationSlot>> build() async => [slot];
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

const _slot = NotificationSlot(
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
  earthquakeEnabled: true,
  earthquakeMinIntensity: JmaIntensity.three,
  earthquakeOverrides: null,
);
