import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/region_floating_panel.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _responseAt = '2026-08-19T12:00:00Z';

class _FakeCityMaxIntensity extends CityMaxIntensityNotifier {
  new({this.responseAt});

  final DateTime? responseAt;

  @override
  Future<CityMaxIntensity> build() async => CityMaxIntensity(
    responseAt: responseAt,
    items: const [
      CityMaxIntensityEntry(
        cityCode: '0410000',
        intensity: JmaIntensity.sixLower,
      ),
    ],
  );
}

class _FakeEarthquakeHistoryNotifier extends EarthquakeHistoryNotifier {
  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    final earthquake = EarthquakePartialNormal(
      eventId: '20240101000000',
      status: TelegramStatus.normal,
      originTime: DateTime(2024, 1, 1, 16, 10),
      originTimePrecision: OriginTimePrecision.minute,
      arrivalTime: DateTime(2024, 1, 1, 16, 11),
      dataSources: const [EarthquakeDataSource.jmaIntensityDatabase],
      hypocenter: const EarthquakeHypocenter(
        code: '123',
        name: '能登半島沖',
        coordinates: null,
        magnitude: EarthquakeMagnitude.value(value: 7.6),
        depth: EarthquakeDepth.shallow(),
        detailedCode: null,
        detailedName: null,
      ),
      intensity: const EarthquakeIntensityPartial(
        maxIntensity: JmaIntensity.seven,
        maxLpgmIntensity: null,
      ),
      earthquakeType: EarthquakeType.normal,
      telegramTypes: const [EarthquakeTelegramType.vxse53],
      estimatedIntensityTileUrl: null,
    );

    return PaginatedResponse(
      items: [
        EarthquakePartialRegion(
          regionIntensity: JmaIntensity.sixLower,
          earthquake: earthquake,
        ),
      ],
      nextToken: null,
    );
  }
}

Future<ProviderContainer> _container({
  DateTime? responseAt,
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
        () => _FakeCityMaxIntensity(responseAt: responseAt),
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

  testWidgets('未選択状態で「全国」が表示される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(_panelApp(container));
    await tester.pump();

    expect(find.text('全国'), findsOneWidget);
  });

  testWidgets('response_at があれば最終更新時刻を表示する', (tester) async {
    final responseAt = DateTime.parse(_responseAt);
    final container = await _container(responseAt: responseAt);
    addTearDown(container.dispose);

    await tester.pumpWidget(_panelApp(container));
    await tester.pumpAndSettle();

    expect(
      find.text(
        '最終更新 ${RegionFloatingPanel.refreshedAtFormat.format(responseAt.toLocal())}',
      ),
      findsOneWidget,
    );
  });

  testWidgets('response_at が null なら最終更新時刻を表示しない', (tester) async {
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
    expect(find.text('全国'), findsNothing);
  });

  testWidgets('市区町村選択状態でタップすると市区町村詳細モーダルが開く', (tester) async {
    final container = await _container(
      overrides: [
        earthquakeHistoryProvider(
          const EarthquakeHistoryParameter.city(
            cityCode: '0410000',
            sortBy: EarthquakeSortBy.eventId,
            sortOrder: SortOrder.desc,
          ),
        ).overrideWith(_FakeEarthquakeHistoryNotifier.new),
      ],
    );
    addTearDown(container.dispose);

    container
        .read(intensityHistoryControllerProvider.notifier)
        .selectCity(code: '0410000', name: '仙台市', prefectureName: '宮城県');

    await tester.pumpWidget(_panelApp(container, centered: true));
    await tester.pumpAndSettle();

    await tester.tap(find.text('仙台市'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('観測した地震'), findsOneWidget);
    expect(find.text('能登半島沖'), findsOneWidget);
  });
}
