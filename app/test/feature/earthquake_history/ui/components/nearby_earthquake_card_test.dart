import 'dart:async';

import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/nearby_earthquakes_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/nearby_earthquake_card.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';

void main() {
  testWidgets('震源座標が不明ならカードを表示しない', (tester) async {
    await _pumpCard(
      tester,
      earthquake: _earthquake(coordinates: const Coordinate.unknown()),
      override: nearbyEarthquakesProvider.overrideWith(
        (ref, query) async => const [],
      ),
    );

    expect(find.text('この震源の近傍で発生した地震'), findsNothing);
  });

  testWidgets('取得中はカード内にインジケーターを表示する', (tester) async {
    final completer = Completer<List<EarthquakePartial>>();
    addTearDown(() => completer.complete(const []));

    await _pumpCard(
      tester,
      earthquake: _earthquake(),
      override: nearbyEarthquakesProvider.overrideWith(
        (ref, query) => completer.future,
      ),
    );

    expect(find.text('この震源の近傍で発生した地震'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('取得失敗時は固定文言を表示し、再試行できる', (tester) async {
    var callCount = 0;

    await _pumpCard(
      tester,
      earthquake: _earthquake(),
      override: nearbyEarthquakesProvider.overrideWith((ref, query) async {
        callCount += 1;
        throw Exception('raw api error');
      }),
    );
    await tester.pump();

    expect(find.text('近傍の地震の取得に失敗しました'), findsOneWidget);
    expect(find.textContaining('raw api error'), findsNothing);

    await tester.tap(find.text('再試行'));
    await tester.pump();

    expect(callCount, 2);
  });

  testWidgets('初期条件で最大5件を表示する', (tester) async {
    NearbyEarthquakeQuery? capturedQuery;

    await _pumpCard(
      tester,
      earthquake: _earthquake(),
      override: nearbyEarthquakesProvider.overrideWith((ref, query) async {
        capturedQuery = query;
        return List.generate(6, (index) => _partial('event-$index'));
      }),
    );
    await tester.pump();

    expect(find.byType(EarthquakeHistoryListTile), findsNWidgets(5));
    expect(find.text('すべて表示'), findsOneWidget);
    expect(
      capturedQuery,
      isA<NearbyEarthquakeQuery>()
          .having((query) => query.latitude, 'latitude', 35)
          .having((query) => query.longitude, 'longitude', 139)
          .having((query) => query.depth, 'depth', 40)
          .having(
            (query) => query.sortBy,
            'sortBy',
            EarthquakeSortBy.maxIntensity,
          )
          .having((query) => query.sortOrder, 'sortOrder', SortOrder.desc),
    );
  });
}

Future<void> _pumpCard(
  WidgetTester tester, {
  required Earthquake earthquake,
  required Override override,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [override],
      retry: (_, _) => null,
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [DesignSystemThemeExtension.light()],
        ),
        home: Scaffold(
          body: SingleChildScrollView(
            child: NearbyEarthquakeCard(earthquake: earthquake),
          ),
        ),
      ),
    ),
  );
}

Earthquake _earthquake({
  Coordinate coordinates = const Coordinate.latLng(
    latitude: 35,
    longitude: 139,
  ),
}) => Earthquake(
  eventId: 'current',
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  telegramTypes: const [],
  hypocenter: EarthquakeHypocenter(
    code: '001',
    name: 'テスト震源',
    coordinates: coordinates,
    magnitude: const EarthquakeMagnitude.value(value: 4.5),
    depth: const EarthquakeDepth.value(value: 40),
    detailedCode: null,
    detailedName: null,
  ),
  intensity: null,
  estimatedIntensityTileUrl: null,
);

EarthquakePartialNormal _partial(String eventId) => EarthquakePartialNormal(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2025),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  hypocenter: null,
  intensity: null,
  earthquakeType: EarthquakeType.normal,
  telegramTypes: const [],
  estimatedIntensityTileUrl: null,
);
