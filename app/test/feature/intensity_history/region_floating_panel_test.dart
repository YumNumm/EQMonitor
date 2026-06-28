import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/region_floating_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Lv1(全国)状態で「全国」が表示される', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(preferences),
        ),
        prefectureHighestProvider.overrideWith((_) async => []),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: RegionFloatingPanel(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('全国'), findsOneWidget);
  });

  testWidgets('Lv2(都道府県フォーカス)状態で都道府県名が表示される', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(preferences),
        ),
        prefectureHighestProvider.overrideWith((_) async => []),
      ],
    );
    addTearDown(container.dispose);

    // Lv2 状態に遷移
    container
        .read(intensityHistoryControllerProvider.notifier)
        .focusPrefecture(
          code: '0100',
          name: '北海道',
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: RegionFloatingPanel(),
          ),
        ),
      ),
    );
    // 非同期プロバイダの解決を待つ
    await tester.pumpAndSettle();

    expect(find.text('北海道'), findsOneWidget);
    expect(find.text('全国'), findsNothing);
  });
}
