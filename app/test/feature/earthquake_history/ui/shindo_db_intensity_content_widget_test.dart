import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_content.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_station_detail_sheet.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

EarthquakeCatalogStationRecord _makeRecord(
  String code,
  ShindoDbIntensityClass cls,
) => EarthquakeCatalogStationRecord(
  stationCode: code,
  intensityClass: cls,
  instrumentalIntensity: null,
  observedAt: null,
  maxAcceleration: null,
  maxAccelTime: null,
  periods: null,
  observationCount: null,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpWidget(
    WidgetTester tester, {
    required ShindoDbIntensityTree tree,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        home: Scaffold(
          body: SingleChildScrollView(
            child: ShindoDbIntensityContent(tree: tree),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  final hokkaido = EarthquakeParameterPrefectureItem(
    code: '01',
    name: const LocalizedName(ja: '北海道'),
    regions: [],
  );

  final sapporoCity = EarthquakeParameterCityItem(
    code: '01100',
    name: const LocalizedName(ja: '札幌市'),
    kana: null,
    stations: [],
  );

  final sapporoRegion = EarthquakeParameterRegionItem(
    code: '010100',
    name: const LocalizedName(ja: '道央'),
    kana: null,
    cities: [sapporoCity],
  );

  final stationNode = ShindoDbStationNode(
    record: _makeRecord('ST001', ShindoDbIntensityClass.sixLower),
    name: '札幌観測点',
    location: const LatLng(43.06, 141.35),
  );

  final cityNode = ShindoDbCityNode(
    city: sapporoCity,
    region: sapporoRegion,
    stations: [stationNode],
  );

  final prefNode = ShindoDbPrefectureNode(
    prefecture: hokkaido,
    cities: [cityNode],
  );

  testWidgets('セクションタイトルが表示される', (tester) async {
    final tree = ShindoDbIntensityTree(
      tree: {
        ShindoDbIntensityClass.sixLower: [prefNode],
      },
      unresolvedStations: {},
      totalStationCount: 1,
    );

    await pumpWidget(tester, tree: tree);

    expect(find.text('震度6弱'), findsOneWidget);
  });

  testWidgets('歴史的階級セクションタイトルが表示される', (tester) async {
    final unresolvedStation = ShindoDbStationNode(
      record: _makeRecord('ST_L', ShindoDbIntensityClass.local),
      name: '局発観測点',
      location: null,
    );

    final tree = ShindoDbIntensityTree(
      tree: {},
      unresolvedStations: {
        ShindoDbIntensityClass.local: [unresolvedStation],
      },
      totalStationCount: 1,
    );

    await pumpWidget(tester, tree: tree);

    expect(find.text('局発地震'), findsOneWidget);
  });

  testWidgets('セクション展開で都道府県・市区町村・観測点チップが表示される', (tester) async {
    final tree = ShindoDbIntensityTree(
      tree: {
        ShindoDbIntensityClass.sixLower: [prefNode],
      },
      unresolvedStations: {},
      totalStationCount: 1,
    );

    await pumpWidget(tester, tree: tree);

    // expand section by tapping section title
    await tester.tap(find.text('震度6弱'));
    await tester.pumpAndSettle();

    // prefecture tile visible (also in subtitle, so findsWidgets)
    expect(find.text('北海道'), findsWidgets);

    // expand prefecture (last occurrence = prefecture tile, not subtitle)
    await tester.tap(find.text('北海道').last);
    await tester.pumpAndSettle();

    // city tile visible
    expect(find.text('札幌市'), findsOneWidget);

    // expand city
    await tester.tap(find.text('札幌市'));
    await tester.pumpAndSettle();

    // station chip visible
    expect(find.text('札幌観測点'), findsOneWidget);
  });

  testWidgets('チップタップで ShindoDbStationDetailSheet が開く', (tester) async {
    final tree = ShindoDbIntensityTree(
      tree: {
        ShindoDbIntensityClass.sixLower: [prefNode],
      },
      unresolvedStations: {},
      totalStationCount: 1,
    );

    await pumpWidget(tester, tree: tree);

    // expand section → prefecture → city
    await tester.tap(find.text('震度6弱'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('北海道').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('札幌市'));
    await tester.pumpAndSettle();

    // tap station chip
    await tester.tap(find.text('札幌観測点'));
    await tester.pumpAndSettle();

    expect(find.byType(ShindoDbStationDetailSheet), findsOneWidget);
  });

  testWidgets('unresolvedStations がある場合「市区町村不明」グループが表示される', (tester) async {
    final unresolvedStation = ShindoDbStationNode(
      record: _makeRecord('ST_U', ShindoDbIntensityClass.four),
      name: '不明観測点',
      location: null,
    );

    final tree = ShindoDbIntensityTree(
      tree: {},
      unresolvedStations: {
        ShindoDbIntensityClass.four: [unresolvedStation],
      },
      totalStationCount: 1,
    );

    await pumpWidget(tester, tree: tree);

    // section title visible
    expect(find.text('震度4'), findsOneWidget);

    // expand section
    await tester.tap(find.text('震度4'));
    await tester.pumpAndSettle();

    // 市区町村不明 tile visible
    expect(find.text('市区町村不明'), findsOneWidget);
  });

  testWidgets('ツリーが空のとき「震度データベースの観測点データはありません」が表示される', (tester) async {
    final tree = ShindoDbIntensityTree(
      tree: {},
      unresolvedStations: {},
      totalStationCount: 0,
    );

    await pumpWidget(tester, tree: tree);

    expect(find.text('震度データベースの観測点データはありません'), findsOneWidget);
  });
}
