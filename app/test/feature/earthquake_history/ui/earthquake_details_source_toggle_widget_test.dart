import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/shindo_db_intensity_tree_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/collapsible_segmented_control.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_hypocenter_information_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_intensity_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_hypocenter_information_card.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ページ全体（MapLibre含む）を pump せずに、
/// _LoadedContent のソース切り替えロジックを直接検証するハーネス。
class _SourceToggleHarness extends HookConsumerWidget {
  const new({required this.earthquake});

  final Earthquake earthquake;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = earthquake.catalog;
    final hasCatalog = catalog != null;
    final hasXml = earthquake.dataSources.contains(
      EarthquakeDataSource.jmaDisasterInformationXml,
    );
    final isDbOnly = hasCatalog && !hasXml;
    final showSourceToggle = hasCatalog && hasXml;

    final source = useState(
      isDbOnly
          ? EarthquakeDataSource.jmaIntensityDatabase
          : EarthquakeDataSource.jmaDisasterInformationXml,
    );
    final effectiveSource =
        source.value == EarthquakeDataSource.jmaIntensityDatabase && hasCatalog
        ? EarthquakeDataSource.jmaIntensityDatabase
        : EarthquakeDataSource.jmaDisasterInformationXml;
    final showingDb =
        effectiveSource == EarthquakeDataSource.jmaIntensityDatabase;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showSourceToggle)
          CollapsibleSegmentedControl<EarthquakeDataSource>(
            segments: const [
              SegmentItem(
                value: EarthquakeDataSource.jmaDisasterInformationXml,
                label: '防災情報XML',
              ),
              SegmentItem(
                value: EarthquakeDataSource.jmaIntensityDatabase,
                label: '震度データベース',
              ),
            ],
            selected: effectiveSource,
            onSelected: (v) => source.value = v,
          ),
        if (showingDb && catalog != null)
          ShindoDbHypocenterInformationCard(
            catalog: catalog,
            originTime: earthquake.originTime,
          )
        else
          EarthquakeHypocenterInformationCard(item: earthquake),
        EarthquakeIntensityCard(
          item: earthquake,
          displayMode: IntensityDisplayMode.jma,
          onDisplayModeChanged: (_) {},
          availableModes: const [IntensityDisplayMode.jma],
          source: effectiveSource,
          showDatabaseBadge: isDbOnly,
        ),
      ],
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const eventId = 'test-event-001';

  final testCatalog = EarthquakeCatalog(
    hypocenters: [
      EarthquakeCatalogHypocenter(
        seq: 0,
        epicenterName: '北海道',
        stationCount: 5,
        recordTypeLabel: 'F',
        originTime: null,
        originTimeStderrSeconds: null,
        latitude: 43.0,
        longitude: 141.0,
        depthKm: 10.0,
        depthIsFree: false,
        depthStderrKm: null,
        maxIntensity: null,
        determinationFlagLabel: null,
        evaluationLabel: null,
        magnitudes: [EarthquakeCatalogMagnitude(typeLabel: 'Mj', value: 4.5)],
      ),
    ],
    stationRecords: [],
    damageScaleLabel: null,
    tsunamiScaleLabel: null,
    linkMatchConfidence: null,
  );

  final bothSourcesEarthquake = Earthquake(
    eventId: eventId,
    status: TelegramStatus.normal,
    originTime: null,
    originTimePrecision: OriginTimePrecision.second,
    arrivalTime: null,
    dataSources: const [
      EarthquakeDataSource.jmaDisasterInformationXml,
      EarthquakeDataSource.jmaIntensityDatabase,
    ],
    telegramTypes: const [],
    hypocenter: null,
    intensity: null,
    estimatedIntensityTileUrl: null,
    catalog: testCatalog,
  );

  const xmlOnlyEarthquake = Earthquake(
    eventId: eventId,
    status: TelegramStatus.normal,
    originTime: null,
    originTimePrecision: OriginTimePrecision.second,
    arrivalTime: null,
    dataSources: [EarthquakeDataSource.jmaDisasterInformationXml],
    telegramTypes: [],
    hypocenter: null,
    intensity: null,
    estimatedIntensityTileUrl: null,
  );

  Future<void> pumpHarness(
    WidgetTester tester, {
    required Earthquake earthquake,
    bool withDbOverride = false,
  }) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    final overrides = [
      app_prefs.sharedPreferencesProvider.overrideWithValue(
        app_prefs.SharedPreferencesAsync(prefs),
      ),
      if (withDbOverride)
        shindoDbIntensityTreeProvider.overrideWith((ref, _) async => null),
    ];

    final container = ProviderContainer(overrides: overrides);
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
          home: Scaffold(
            body: SingleChildScrollView(
              child: _SourceToggleHarness(earthquake: earthquake),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('(a) XML+DB 両ソース → トグル表示、DB選択でカード切り替え', (tester) async {
    await pumpHarness(
      tester,
      earthquake: bothSourcesEarthquake,
      withDbOverride: true,
    );

    // 初期状態: XML モード。トグルに現在選択中の '防災情報XML' が表示される
    expect(find.text('防災情報XML'), findsOneWidget);
    expect(find.byType(EarthquakeHypocenterInformationCard), findsOneWidget);
    expect(find.byType(ShindoDbHypocenterInformationCard), findsNothing);

    // トグルを展開する
    await tester.tap(find.text('防災情報XML'));
    await tester.pumpAndSettle();

    // '震度データベース' セグメントが表示されていることを確認
    expect(find.text('震度データベース'), findsOneWidget);

    // '震度データベース' を選択する
    await tester.tap(find.text('震度データベース'));
    await tester.pumpAndSettle();

    // DB モードに切り替わる: ShindoDbHypocenterInformationCard が表示される
    expect(find.byType(ShindoDbHypocenterInformationCard), findsOneWidget);
    expect(find.byType(EarthquakeHypocenterInformationCard), findsNothing);

    // 震度カードのタイトルが表示される
    expect(find.text('各地の震度'), findsOneWidget);
  });

  testWidgets('DB選択後にcatalogなしへ更新されてもXML表示へ戻る', (tester) async {
    await pumpHarness(
      tester,
      earthquake: bothSourcesEarthquake,
      withDbOverride: true,
    );

    await tester.tap(find.text('防災情報XML'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('震度データベース'));
    await tester.pumpAndSettle();

    expect(find.byType(ShindoDbHypocenterInformationCard), findsOneWidget);

    await pumpHarness(tester, earthquake: xmlOnlyEarthquake);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(EarthquakeHypocenterInformationCard), findsOneWidget);
    expect(find.byType(ShindoDbHypocenterInformationCard), findsNothing);
  });

  testWidgets('(b) XML のみ → トグル非表示・XML カード表示', (tester) async {
    await pumpHarness(tester, earthquake: xmlOnlyEarthquake);

    // トグルは表示されない
    expect(find.text('防災情報XML'), findsNothing);
    expect(find.text('震度データベース'), findsNothing);

    // XML 震源カードが表示される
    expect(find.byType(EarthquakeHypocenterInformationCard), findsOneWidget);
    expect(find.byType(ShindoDbHypocenterInformationCard), findsNothing);
  });

  testWidgets('(c) DB のみ → トグル非表示・DB 表示固定・データベースバッジ', (tester) async {
    final dbOnlyEarthquake = Earthquake(
      eventId: eventId,
      status: TelegramStatus.normal,
      originTime: null,
      originTimePrecision: OriginTimePrecision.second,
      arrivalTime: null,
      dataSources: const [EarthquakeDataSource.jmaIntensityDatabase],
      telegramTypes: const [],
      hypocenter: null,
      intensity: null,
      estimatedIntensityTileUrl: null,
      catalog: testCatalog,
    );

    await pumpHarness(
      tester,
      earthquake: dbOnlyEarthquake,
      withDbOverride: true,
    );
    await tester.pumpAndSettle();

    // トグルは表示されない
    expect(find.text('防災情報XML'), findsNothing);

    // DB 震源カードが表示される
    expect(find.byType(ShindoDbHypocenterInformationCard), findsOneWidget);
    expect(find.byType(EarthquakeHypocenterInformationCard), findsNothing);

    // 震度カードに 'データベース' バッジが表示される
    expect(find.text('データベース'), findsOneWidget);
  });
}
