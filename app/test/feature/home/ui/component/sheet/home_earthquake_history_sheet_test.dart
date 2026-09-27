import 'dart:async';

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/region_name_resolver.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_not_found.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/home_earthquake_history_parameter_provider.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_earthquake_list.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/component/home_scope_unavailable_body.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/model/map_data_item.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

void main() {
  testWidgets('初回の設定・地域・履歴の読み込みを見出し右側に表示する', (tester) async {
    final fixture = _Fixture();
    fixture.cityResult = Completer<MapDataItem?>();
    fixture.historyResult = Completer<PaginatedResponse<EarthquakePartial>>();
    await tester.pumpWidget(fixture.app);

    expect(find.text('最近の地震'), findsOneWidget);
    expect(find.byType(M3ECircularProgressIndicator), findsOneWidget);
    expect(find.byType(Skeletonizer), findsNothing);
    expect(
      tester.getTopLeft(find.byType(M3ECircularProgressIndicator)).dx,
      greaterThan(tester.getTopRight(find.text('最近の地震')).dx),
    );

    fixture.updateLocation();
    await tester.pump();
    await tester.pump();
    expect(find.byType(M3ECircularProgressIndicator), findsOneWidget);
    fixture.cityResult?.complete(_Fixture.city);
    await tester.pump();
    await tester.pump();
    expect(fixture.requests, hasLength(1));
    expect(find.byType(M3ECircularProgressIndicator), findsOneWidget);

    fixture.historyResult?.complete(_Fixture.page);
    await tester.pumpAndSettle();
    expect(find.byType(HomeEarthquakeList), findsOneWidget);
    expect(find.byType(M3ECircularProgressIndicator), findsNothing);
  });

  testWidgets('位置更新による地域再判定中も一覧を保持し、同じ市区町村では再取得しない', (tester) async {
    final fixture = _Fixture();
    await fixture.showLoaded(tester);
    final listElement = tester.element(find.byType(HomeEarthquakeList));

    fixture.cityResult = Completer<MapDataItem?>();
    fixture.updateLocation(latitude: 35.682);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(M3ECircularProgressIndicator), findsOneWidget);
    expect(find.byType(Skeletonizer), findsNothing);
    expect(tester.element(find.byType(HomeEarthquakeList)), same(listElement));
    expect(fixture.requests, hasLength(1));

    fixture.cityResult?.complete(_Fixture.city);
    await tester.pumpAndSettle();
    expect(find.byType(M3ECircularProgressIndicator), findsNothing);
    expect(tester.element(find.byType(HomeEarthquakeList)), same(listElement));
    expect(fixture.requests, hasLength(1));
  });

  testWidgets('履歴の再読み込み中は既存一覧を表示し、完了後に新しい結果へ切り替える', (tester) async {
    final fixture = _Fixture();
    await fixture.showLoaded(tester);
    fixture.historyResult = Completer<PaginatedResponse<EarthquakePartial>>();
    fixture.container.invalidate(
      earthquakeHistoryProvider(fixture.requests.single),
      asReload: true,
    );
    await tester.pump();

    expect(find.byType(HomeEarthquakeList), findsOneWidget);
    expect(find.byType(M3ECircularProgressIndicator), findsOneWidget);
    expect(find.byType(Skeletonizer), findsNothing);

    fixture.historyResult?.complete(
      const PaginatedResponse(items: [], nextToken: null),
    );
    await tester.pumpAndSettle();
    expect(find.byType(HomeEarthquakeList), findsNothing);
    expect(find.byType(EarthquakeHistoryNotFound), findsOneWidget);
    expect(find.byType(M3ECircularProgressIndicator), findsNothing);
  });

  testWidgets('初回取得に失敗した場合はエラーを表示する', (tester) async {
    final fixture = _Fixture();
    fixture.historyResult = Completer<PaginatedResponse<EarthquakePartial>>();
    await tester.pumpWidget(fixture.app);
    fixture.updateLocation();
    await tester.pump();
    await tester.pump();
    fixture.historyResult?.completeError(Exception('fetch failed'));
    await tester.pumpAndSettle();

    expect(find.byType(ErrorCard), findsOneWidget);
    expect(find.byType(M3ECircularProgressIndicator), findsNothing);
  });

  testWidgets('再取得の失敗を表示し、再試行中はキャッシュと見出しの進捗を表示する', (tester) async {
    final fixture = _Fixture();
    await fixture.showLoaded(tester);
    fixture.historyResult = Completer<PaginatedResponse<EarthquakePartial>>();
    fixture.container.invalidate(
      earthquakeHistoryProvider(fixture.requests.single),
    );
    await tester.pump();
    fixture.historyResult?.completeError(Exception('refresh failed'));
    await tester.pumpAndSettle();

    expect(find.byType(ErrorCard), findsOneWidget);
    expect(find.text('再試行'), findsOneWidget);
    expect(find.byType(M3ECircularProgressIndicator), findsNothing);

    fixture.historyResult = Completer<PaginatedResponse<EarthquakePartial>>();
    await tester.tap(find.text('再試行'));
    await tester.pump();
    await tester.pump();
    expect(find.byType(ErrorCard), findsNothing);
    expect(find.byType(HomeEarthquakeList), findsOneWidget);
    expect(find.byType(M3ECircularProgressIndicator), findsOneWidget);

    fixture.historyResult?.complete(_Fixture.page);
    await tester.pumpAndSettle();
    expect(find.byType(ErrorCard), findsNothing);
    expect(find.byType(HomeEarthquakeList), findsOneWidget);
    expect(find.byType(M3ECircularProgressIndicator), findsNothing);
  });

  testWidgets('再判定で地域が取得できなくなった場合は古い一覧を消す', (tester) async {
    final fixture = _Fixture();
    await fixture.showLoaded(tester);
    fixture.cityResult = Completer<MapDataItem?>();
    fixture.updateLocation(latitude: 35.682);
    await tester.pump();
    await tester.pump();
    fixture.cityResult?.complete(null);
    await tester.pumpAndSettle();

    expect(find.byType(HomeEarthquakeList), findsNothing);
    expect(find.byType(HomeScopeUnavailableBody), findsOneWidget);
    expect(find.byType(M3ECircularProgressIndicator), findsNothing);
  });
}

class _Fixture {
  new() {
    addTearDown(() async {
      container.dispose();
      await positions.close();
    });
  }

  static const city = MapDataItem(
    property: MapDataProperty(
      code: '13101',
      name: '東京都千代田区',
      nameKana: 'トウキョウトチヨダク',
    ),
  );
  static const page = PaginatedResponse<EarthquakePartial>(
    items: [
      EarthquakePartial.normal(
        eventId: '20260924120000',
        status: .normal,
        originTime: null,
        originTimePrecision: .second,
        arrivalTime: null,
        dataSources: [],
        hypocenter: null,
        intensity: null,
        earthquakeType: .normal,
        telegramTypes: [],
        estimatedIntensityTileUrl: null,
      ),
    ],
    nextToken: null,
  );

  final positions = StreamController<Position>();
  final requests = <EarthquakeHistoryParameter>[];
  Completer<MapDataItem?>? cityResult;
  Completer<PaginatedResponse<EarthquakePartial>>? historyResult;
  late final container = ProviderContainer(
    overrides: [
      homeConfigurationProvider.overrideWith(_HomeConfiguration.new),
      locationStreamProvider.overrideWith((ref) => positions.stream),
      jmaMapAreaInformationCityInsideProvider.overrideWith(
        (ref, latLng) async => cityResult == null ? city : cityResult?.future,
      ),
      regionNameProvider.overrideWith((ref, args) async => '東京都千代田区'),
      earthquakeHistoryProvider.overrideWith2(
        (_) => _History(load: loadHistory),
      ),
    ],
  );

  Widget get app => UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [DesignSystemThemeExtension.light()],
      ),
      home: const Scaffold(
        body: Align(alignment: .topCenter, child: HomeEarthquakeHistorySheet()),
      ),
    ),
  );

  Future<PaginatedResponse<EarthquakePartial>> loadHistory(
    EarthquakeHistoryParameter parameter,
  ) async {
    requests.add(parameter);
    return historyResult?.future ?? page;
  }

  void updateLocation({double latitude = 35.681}) {
    positions.add(
      Position(
        latitude: latitude,
        longitude: 139.767,
        timestamp: DateTime.utc(2026),
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0,
      ),
    );
  }

  Future<void> showLoaded(WidgetTester tester) async {
    await tester.pumpWidget(app);
    updateLocation();
    await tester.pumpAndSettle();
    expect(find.byType(HomeEarthquakeList), findsOneWidget);
    expect(requests, hasLength(1));
    expect(
      container.read(homeEarthquakeHistoryParameterProvider).value,
      requests.single,
    );
  }
}

class _HomeConfiguration extends HomeConfigurationNotifier {
  @override
  Future<HomeConfigurationModel> build() async => const HomeConfigurationModel(
    common: HomeCommonSettings(earthquakeHistoryScope: .currentLocation),
  );
}

class _History extends EarthquakeHistoryNotifier {
  new({required this.load});

  final Future<PaginatedResponse<EarthquakePartial>> Function(
    EarthquakeHistoryParameter,
  )
  load;

  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) => load(parameter);
}
