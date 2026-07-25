import 'dart:async';

import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
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
import 'package:eqmonitor/feature/intensity_history/ui/components/city_detail_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _FakeEarthquakeHistoryNotifier extends EarthquakeHistoryNotifier {
  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    return PaginatedResponse(
      items: [_earthquakePartialForList(parameter)],
      nextToken: null,
    );
  }
}

class _EmptyEarthquakeHistoryNotifier extends EarthquakeHistoryNotifier {
  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    return const PaginatedResponse(items: [], nextToken: null);
  }
}

class _ErrorEarthquakeHistoryNotifier extends EarthquakeHistoryNotifier {
  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    throw Exception('network failed');
  }
}

class _PagedEarthquakeHistoryNotifier extends EarthquakeHistoryNotifier {
  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    return PaginatedResponse(
      items: [_earthquakePartialForList(parameter)],
      nextToken: 'next-token',
    );
  }
}

class _PendingEarthquakeHistoryNotifier extends EarthquakeHistoryNotifier {
  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) {
    return Completer<PaginatedResponse<EarthquakePartial>>().future;
  }
}

EarthquakePartial _earthquakePartialForList(
  EarthquakeHistoryParameter parameter,
) {
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
  return switch (parameter) {
    EarthquakeHistoryParameterPrefecture() => EarthquakePartialPrefecture(
      prefectureIntensity: JmaIntensity.sixLower,
      earthquake: earthquake,
    ),
    EarthquakeHistoryParameterCity() => EarthquakePartialRegion(
      regionIntensity: JmaIntensity.fiveUpper,
      earthquake: earthquake,
    ),
    _ => earthquake,
  };
}

typedef _OpenModal = void Function(BuildContext context);

Widget _modalTestApp({required _OpenModal onPressed}) {
  return MaterialApp(
    theme: ThemeData.light().copyWith(
      extensions: [
        DesignSystemThemeExtension.light(),
      ],
    ),
    home: Scaffold(
      body: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () => onPressed(context),
          child: const Text('open'),
        ),
      ),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('市区町村モーダルで地震一覧が表示される', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          earthquakeHistoryProvider(
            const EarthquakeHistoryParameter.city(
              cityCode: '1720400',
              sortBy: EarthquakeSortBy.eventId,
              sortOrder: SortOrder.desc,
            ),
          ).overrideWith(_FakeEarthquakeHistoryNotifier.new),
        ],
        child: _modalTestApp(
          onPressed: (context) => showCityDetailModal(
            context,
            cityCode: '1720400',
            cityName: '輪島市',
            regionName: '石川県',
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('輪島市'), findsOneWidget);
    expect(find.text('石川県'), findsOneWidget);
    expect(find.text('観測した地震'), findsOneWidget);
    expect(find.text('能登半島沖'), findsOneWidget);
    expect(find.textContaining('TODO'), findsNothing);
  });

  testWidgets('都道府県モーダルで地震一覧が表示される', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          earthquakeHistoryProvider(
            const EarthquakeHistoryParameter.prefecture(
              prefectureCode: '1700',
              sortBy: EarthquakeSortBy.eventId,
              sortOrder: SortOrder.desc,
            ),
          ).overrideWith(_FakeEarthquakeHistoryNotifier.new),
        ],
        child: _modalTestApp(
          onPressed: (context) => showPrefectureDetailModal(
            context,
            prefectureCode: '1700',
            prefectureName: '石川県',
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('石川県'), findsOneWidget);
    expect(find.text('観測した地震'), findsOneWidget);
    expect(find.text('能登半島沖'), findsOneWidget);
  });

  testWidgets('地震一覧が空の場合は空表示になる', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          earthquakeHistoryProvider(
            const EarthquakeHistoryParameter.city(
              cityCode: '1720400',
              sortBy: EarthquakeSortBy.eventId,
              sortOrder: SortOrder.desc,
            ),
          ).overrideWith(_EmptyEarthquakeHistoryNotifier.new),
        ],
        child: _modalTestApp(
          onPressed: (context) => showCityDetailModal(
            context,
            cityCode: '1720400',
            cityName: '輪島市',
            regionName: '石川県',
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('この地域で観測された地震はありません'), findsOneWidget);
  });

  testWidgets('地震一覧の取得に失敗した場合は再読み込み導線を表示する', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          earthquakeHistoryProvider(
            const EarthquakeHistoryParameter.city(
              cityCode: '1720400',
              sortBy: EarthquakeSortBy.eventId,
              sortOrder: SortOrder.desc,
            ),
          ).overrideWith(_ErrorEarthquakeHistoryNotifier.new),
        ],
        child: _modalTestApp(
          onPressed: (context) => showCityDetailModal(
            context,
            cityCode: '1720400',
            cityName: '輪島市',
            regionName: '石川県',
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(ErrorCard), findsOneWidget);
  });

  testWidgets('地震一覧の初回読み込み中はローディング表示になる', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          earthquakeHistoryProvider(
            const EarthquakeHistoryParameter.city(
              cityCode: '1720400',
              sortBy: EarthquakeSortBy.eventId,
              sortOrder: SortOrder.desc,
            ),
          ).overrideWith(_PendingEarthquakeHistoryNotifier.new),
        ],
        child: _modalTestApp(
          onPressed: (context) => showCityDetailModal(
            context,
            cityCode: '1720400',
            cityName: '輪島市',
            regionName: '石川県',
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('続きがある場合はさらに読み込むボタンを表示する', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          earthquakeHistoryProvider(
            const EarthquakeHistoryParameter.city(
              cityCode: '1720400',
              sortBy: EarthquakeSortBy.eventId,
              sortOrder: SortOrder.desc,
            ),
          ).overrideWith(_PagedEarthquakeHistoryNotifier.new),
        ],
        child: _modalTestApp(
          onPressed: (context) => showCityDetailModal(
            context,
            cityCode: '1720400',
            cityName: '輪島市',
            regionName: '石川県',
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('さらに読み込む'), findsOneWidget);
  });
}
