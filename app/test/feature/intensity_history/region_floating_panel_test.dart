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
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/region_floating_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakePrefectureHighest extends PrefectureHighest {
  @override
  Future<List<HighestIntensityEntry>> build() async => [];
}

class _FakeCityHighest extends CityHighest {
  @override
  Future<List<HighestIntensityEntry>> build(String prefectureCode) async => [];
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
        EarthquakePartialPrefecture(
          prefectureIntensity: JmaIntensity.sixLower,
          earthquake: earthquake,
        ),
      ],
      nextToken: null,
    );
  }
}

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
        prefectureHighestProvider.overrideWith(_FakePrefectureHighest.new),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [DesignSystemThemeExtension.light()],
          ),
          home: const Scaffold(body: RegionFloatingPanel()),
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
        prefectureHighestProvider.overrideWith(_FakePrefectureHighest.new),
      ],
    );
    addTearDown(container.dispose);

    // Lv2 状態に遷移
    container
        .read(intensityHistoryControllerProvider.notifier)
        .focusPrefecture(code: '0100', name: '北海道');

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [DesignSystemThemeExtension.light()],
          ),
          home: const Scaffold(body: RegionFloatingPanel()),
        ),
      ),
    );
    // 非同期プロバイダの解決を待つ
    await tester.pumpAndSettle();

    expect(find.text('北海道'), findsOneWidget);
    expect(find.text('全国'), findsNothing);
  });

  testWidgets('市区町村選択状態で市区町村名と都道府県名が表示される', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(preferences),
        ),
        prefectureHighestProvider.overrideWith(_FakePrefectureHighest.new),
        cityHighestProvider('0400').overrideWith(_FakeCityHighest.new),
      ],
    );
    addTearDown(container.dispose);

    container
        .read(intensityHistoryControllerProvider.notifier)
        .focusPrefecture(code: '0400', name: '宮城県');
    container
        .read(intensityHistoryControllerProvider.notifier)
        .selectCity(code: '0410000', name: '仙台市');

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [DesignSystemThemeExtension.light()],
          ),
          home: const Scaffold(body: RegionFloatingPanel()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('宮城県'), findsOneWidget);
    expect(find.text('仙台市'), findsOneWidget);
  });

  testWidgets('都道府県フォーカス状態でタップすると都道府県詳細モーダルが開く', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(preferences),
        ),
        prefectureHighestProvider.overrideWith(_FakePrefectureHighest.new),
        earthquakeHistoryProvider(
          const EarthquakeHistoryParameter.prefecture(
            prefectureCode: '0400',
            sortBy: EarthquakeSortBy.eventId,
            sortOrder: SortOrder.desc,
          ),
        ).overrideWith(_FakeEarthquakeHistoryNotifier.new),
      ],
    );
    addTearDown(container.dispose);

    container
        .read(intensityHistoryControllerProvider.notifier)
        .focusPrefecture(code: '0400', name: '宮城県');

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [DesignSystemThemeExtension.light()],
          ),
          home: const Scaffold(body: Center(child: RegionFloatingPanel())),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('宮城県'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('観測した地震'), findsOneWidget);
    expect(find.text('能登半島沖'), findsOneWidget);
  });
}
