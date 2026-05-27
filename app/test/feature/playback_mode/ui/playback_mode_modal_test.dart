import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/playback_mode/ui/playback_mode_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<ProviderContainer> pumpModal(WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: const Scaffold(body: PlaybackModeModal()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  testWidgets('初期状態は通常再生で、通常/タイムシフトのチップが並ぶこと', (tester) async {
    final container = await pumpModal(tester);

    expect(container.read(appClockProvider), const TimeMode.realtime());
    expect(find.text('通常再生'), findsOneWidget);
    expect(find.text('1分前'), findsOneWidget);
  });

  testWidgets('タイムシフトのプリセットをタップすると offset が設定されること', (tester) async {
    final container = await pumpModal(tester);

    await tester.tap(find.text('1分前'));
    await tester.pumpAndSettle();

    expect(
      container.read(appClockProvider),
      const TimeMode.timeShift(offset: Duration(minutes: -1)),
    );
  });

  testWidgets('タイムシフト後に通常再生をタップすると realtime へ戻ること', (tester) async {
    final container = await pumpModal(tester);
    container
        .read(appClockProvider.notifier)
        .enterTimeShift(const Duration(minutes: -5));
    await tester.pump();

    await tester.tap(find.text('通常再生'));
    await tester.pumpAndSettle();

    expect(container.read(appClockProvider), const TimeMode.realtime());
  });
}
