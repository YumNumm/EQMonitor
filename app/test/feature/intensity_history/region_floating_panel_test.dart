import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/region_floating_panel.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _aggregatedAt = '2026-08-19T12:00:00Z';

class _FakeCityMaxIntensity({final DateTime? aggregatedAt})
    extends CityMaxIntensityNotifier {
  @override
  Future<CityMaxIntensity> build() async => CityMaxIntensity(
    aggregatedAt: aggregatedAt,
    items: const [
      CityMaxIntensityEntry(
        cityCode: '0410000',
        intensity: JmaIntensity.sixLower,
      ),
    ],
  );
}

Future<ProviderContainer> _container({
  DateTime? aggregatedAt,
  List<Override> overrides = const [],
}) async {
  SharedPreferences.setMockInitialValues({});
  final preferences = await SharedPreferences.getInstance();
  return ProviderContainer(
    overrides: [
      app_prefs.sharedPreferencesProvider.overrideWithValue(
        app_prefs.SharedPreferencesAsync(preferences),
      ),
      cityMaxIntensityProvider.overrideWith(
        () => _FakeCityMaxIntensity(aggregatedAt: aggregatedAt),
      ),
      ...overrides,
    ],
  );
}

Widget _panelApp(ProviderContainer container, {bool centered = false}) =>
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [DesignSystemThemeExtension.light()],
        ),
        home: Scaffold(
          body: centered
              ? const Center(child: RegionFloatingPanel())
              : const RegionFloatingPanel(),
        ),
      ),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('未選択状態で全国の集計であることを示す見出しが表示される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(_panelApp(container));
    await tester.pump();

    expect(find.textContaining('市区町村別'), findsOneWidget);
    expect(find.textContaining('最大観測震度'), findsOneWidget);
  });

  testWidgets('aggregated_at があれば最終更新時刻を表示する', (tester) async {
    final aggregatedAt = DateTime.parse(_aggregatedAt);
    final container = await _container(aggregatedAt: aggregatedAt);
    addTearDown(container.dispose);

    await tester.pumpWidget(_panelApp(container));
    await tester.pumpAndSettle();

    expect(
      find.text(
        '${aggregatedAt.formatWithTz(.monthDayHourMinute)} 更新',
      ),
      findsOneWidget,
    );
  });

  testWidgets('aggregated_at が null なら最終更新時刻を表示しない', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(_panelApp(container));
    await tester.pumpAndSettle();

    expect(find.textContaining('最終更新'), findsNothing);
  });

  testWidgets('市区町村選択状態で市区町村名と都道府県名が表示される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    container
        .read(intensityHistoryControllerProvider.notifier)
        .selectCity(code: '0410000', name: '仙台市', prefectureName: '宮城県');

    await tester.pumpWidget(_panelApp(container));
    await tester.pumpAndSettle();

    expect(find.text('宮城県'), findsOneWidget);
    expect(find.text('仙台市'), findsOneWidget);
    expect(find.textContaining('最大観測震度'), findsNothing);
  });
}
