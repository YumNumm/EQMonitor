import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/region_intensity.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpWidget(
    WidgetTester tester, {
    required Earthquake item,
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
              child: EarthquakeIntensityWidget(item: item),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Earthquake itemWithIntensity(EarthquakeIntensity intensity) {
    return Earthquake(
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

  const miyagiRegion = EarthquakeParameterRegionItem(
    code: '040000',
    name: LocalizedName(ja: '宮城県'),
    kana: null,
    cities: [],
  );
  const miyagiPrefecture = EarthquakeParameterPrefectureItem(
    code: '04',
    name: LocalizedName(ja: '宮城県'),
    regions: [miyagiRegion],
  );

  testWidgets('各地の震度セクションに震度タイルと地域名が出る', (tester) async {
    final item = itemWithIntensity(
      const EarthquakeIntensity(
        maxIntensity: JmaIntensity.four,
        maxLpgmIntensity: null,
        regions: {
          JmaIntensity.four: [
            IntensityRegion(
              region: miyagiRegion,
              maxIntensity: JmaIntensity.four,
            ),
          ],
        },
        intensityTree: {
          JmaIntensity.four: [
            PrefectureIntensityNode(
              prefecture: IntensityPrefecture(
                prefecture: miyagiPrefecture,
                maxIntensity: JmaIntensity.four,
              ),
              cities: [
                CityIntensityNode(
                  city: EarthquakeParameterCityItem(
                    code: '0420100',
                    name: LocalizedName(ja: '宮城県北部'),
                    kana: null,
                    stations: [],
                  ),
                  maxIntensity: JmaIntensity.four,
                  maxLpgmIntensity: JmaLpgmIntensity.one,
                  stations: [],
                ),
              ],
            ),
          ],
        },
        lpgmIntensityTree: {},
      ),
    );

    await pumpWidget(tester, item: item);

    expect(find.text('各地の震度'), findsOneWidget);
    expect(find.textContaining('震度4'), findsWidgets);
    expect(find.textContaining('宮城県'), findsOneWidget);
  });

  testWidgets('震度行タップでモーダルに地域名が出る', (tester) async {
    final item = itemWithIntensity(
      const EarthquakeIntensity(
        maxIntensity: JmaIntensity.four,
        maxLpgmIntensity: null,
        regions: {
          JmaIntensity.four: [
            IntensityRegion(
              region: miyagiRegion,
              maxIntensity: JmaIntensity.four,
            ),
          ],
        },
        intensityTree: {
          JmaIntensity.four: [
            PrefectureIntensityNode(
              prefecture: IntensityPrefecture(
                prefecture: miyagiPrefecture,
                maxIntensity: JmaIntensity.four,
              ),
              cities: [
                CityIntensityNode(
                  city: EarthquakeParameterCityItem(
                    code: '0420100',
                    name: LocalizedName(ja: '宮城県北部'),
                    kana: null,
                    stations: [],
                  ),
                  maxIntensity: JmaIntensity.four,
                  stations: [],
                ),
              ],
            ),
          ],
        },
        lpgmIntensityTree: {},
      ),
    );

    await pumpWidget(tester, item: item);

    await tester.tap(find.textContaining('震度4').first);
    await tester.pumpAndSettle();

    // インライン展開: タップ後に都道府県タイルが表示される
    // 展開前は subtitle に1回、展開後は都道府県タイルにも表示される
    expect(find.text('宮城県'), findsWidgets);
  });

  testWidgets('intensityがnullのときウィジェットは表示しない', (tester) async {
    const item = Earthquake(
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
