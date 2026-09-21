import 'package:eqmonitor/core/model/telegram/telegram_type.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_state.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_with_state.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_playback_selection_notifier.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_telegrams_provider.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_timeline_overlay.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  testWidgets(
    'timeline announces report time and adjusts one report at a time',
    (
      tester,
    ) async {
      tz.initializeTimeZones();
      final telegrams = [
        for (final minute in [0, 1, 10])
          TsunamiTelegramWithState(
            telegram: TsunamiTelegramMeta(
              telegramId: minute.toString(),
              type: TelegramType.vtse41,
              serialNo: minute,
              title: '津波警報・注意報・予報',
              headline: null,
              publishedAt: DateTime.utc(2026, 1, 1, 0, minute),
              reportedAt: DateTime.utc(2026, 1, 1, 0, minute),
              targetedAt: null,
              revokedAt: null,
              infoKind: '発表',
            ),
            state: TsunamiState(
              id: 'test',
              eventIds: const [],
              isActive: true,
              isCanceled: false,
              updatedAt: DateTime.utc(2026, 1, 1, 0, minute),
              earthquakes: const [],
              latestTelegrams: const [],
              regions: const [],
              offshoreStations: const [],
            ),
          ),
      ];
      final container = ProviderContainer.test(
        overrides: [
          tsunamiTelegramsProvider('test')
              .overrideWith((ref) async => telegrams),
        ],
      );
      final colorSet = AppTheme.eqmonitorDefault().light;
      if (colorSet == null) fail('default theme requires a light color set');
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppThemeDataBuilder.build(
              colorSet: colorSet,
              brightness: Brightness.light,
            ),
            home: const Scaffold(
              body: TsunamiTimelineOverlay(tsunamiId: 'test'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final finder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics && widget.properties.label == '表示する津波情報の発表時刻',
      );
      final latest = tester.widget<Semantics>(finder);
      expect(latest.properties.value, '09:10:00');
      expect(latest.properties.onIncrease, isNull);
      latest.properties.onDecrease?.call();
      await tester.pumpAndSettle();
      expect(container.read(tsunamiPlaybackSelectionProvider).selectedIndex, 1);
      final middle = tester.widget<Semantics>(finder);
      expect(middle.properties.value, '09:01:00');
      expect(middle.properties.increasedValue, '09:10:00');
      expect(middle.properties.decreasedValue, '09:00:00');
      middle.properties.onIncrease?.call();
      await tester.pumpAndSettle();
      expect(
        container.read(tsunamiPlaybackSelectionProvider).selectedIndex,
        isNull,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
