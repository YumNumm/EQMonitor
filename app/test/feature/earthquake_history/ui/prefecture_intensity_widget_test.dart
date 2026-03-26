import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/prefecture_intensity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_parameter_types/earthquake_param.pb.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpWidget(
    WidgetTester tester, {
    required EarthquakePartial item,
  }) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(preferences),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: PrefectureIntensityWidget(item: item),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  EarthquakePartial itemWithIntensity(EarthquakeIntensity intensity) {
    return EarthquakePartial(
      eventId: '20260101120000',
      status: TelegramStatus.normal,
      originTime: null,
      originTimePrecision: OriginTimePrecision.second,
      arrivalTime: null,
      dataSource: EarthquakeDataSource.jmaDisasterInformationXml,
      hypocenter: null,
      intensity: intensity,
      estimatedIntensityTileUrl: null,
    );
  }

  testWidgets('各地の震度セクションに震度タイルと都道府県数が出る', (tester) async {
    final item = itemWithIntensity(
      EarthquakeIntensity(
        maxIntensity: JmaIntensity.four,
        maxLpgmIntensity: null,
        intensityTree: {
          JmaIntensity.four: [
            RegionIntensityNode(
              region: EarthquakeParameterRegionItem(
                code: '040000',
                name: '宮城県',
                cities: [],
              ),
              maxIntensity: JmaIntensity.four,
              cities: [
                CityIntensityNode(
                  city: EarthquakeParameterCityItem(
                    code: '0420100',
                    name: '宮城県北部',
                  ),
                  maxIntensity: JmaIntensity.four,
                  maxLpgmIntensity: JmaLpgmIntensity.one,
                  stations: const [],
                ),
              ],
            ),
          ],
        },
        lpgmIntensityTree: const {},
      ),
    );

    await pumpWidget(tester, item: item);

    expect(find.text('各地の震度'), findsOneWidget);
    expect(find.textContaining('震度4'), findsWidgets);
    expect(find.textContaining('都道府県 1'), findsOneWidget);
    expect(find.textContaining('宮城県'), findsOneWidget);
  });

  testWidgets('震度行タップでモーダルに都道府県名が出る', (tester) async {
    final item = itemWithIntensity(
      EarthquakeIntensity(
        maxIntensity: JmaIntensity.four,
        maxLpgmIntensity: null,
        intensityTree: {
          JmaIntensity.four: [
            RegionIntensityNode(
              region: EarthquakeParameterRegionItem(
                code: '040000',
                name: '宮城県',
                cities: [],
              ),
              maxIntensity: JmaIntensity.four,
              cities: [
                CityIntensityNode(
                  city: EarthquakeParameterCityItem(
                    code: '0420100',
                    name: '宮城県北部',
                  ),
                  maxIntensity: JmaIntensity.four,
                  stations: const [],
                ),
              ],
            ),
          ],
        },
        lpgmIntensityTree: const {},
      ),
    );

    await pumpWidget(tester, item: item);

    await tester.tap(find.textContaining('震度4').first);
    await tester.pumpAndSettle();

    expect(find.textContaining('震度4の地域'), findsOneWidget);
    expect(find.text('宮城県'), findsWidgets);
  });

  testWidgets('intensityがnullのときウィジェットは表示しない', (tester) async {
    const item = EarthquakePartial(
      eventId: '20260101120000',
      status: TelegramStatus.normal,
      originTime: null,
      originTimePrecision: OriginTimePrecision.second,
      arrivalTime: null,
      dataSource: EarthquakeDataSource.jmaDisasterInformationXml,
      hypocenter: null,
      intensity: null,
      estimatedIntensityTileUrl: null,
    );

    await pumpWidget(tester, item: item);

    expect(find.text('各地の震度'), findsNothing);
  });
}
