import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/current_location_intensity_display.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_area_info.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/current_location_intensity_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/model/map_data_item.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';

void main() {
  const latLng = LatLng(35.681, 139.767);
  const eventId = '202606150001';
  const item = EarthquakePartial(
    eventId: eventId,
    status: TelegramStatus.normal,
    originTime: null,
    originTimePrecision: OriginTimePrecision.minute,
    arrivalTime: null,
    dataSource: EarthquakeDataSource.jmaIntensityDatabase,
    hypocenter: EarthquakeHypocenter(
      code: '100',
      name: '東京都２３区',
      coordinates: Coordinate.latLng(latitude: 35.0, longitude: 139.0),
      magnitude: EarthquakeMagnitude.value(value: 5.2),
      depth: EarthquakeDepth.value(value: 30),
      detailedCode: null,
      detailedName: null,
    ),
    intensity: EarthquakeIntensityPartial(
      maxIntensity: JmaIntensity.fiveLower,
      maxLpgmIntensity: null,
    ),
    estimatedIntensityTileUrl: null,
  );

  Position position() => Position(
    latitude: latLng.lat,
    longitude: latLng.lon,
    timestamp: DateTime.utc(2026),
    accuracy: 0,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  Future<void> pumpListTile(
    WidgetTester tester, {
    IntensityAreaInfo? areaInfo,
    String? areaName,
    bool showCurrentLocationIntensity = false,
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          home: Scaffold(
            body: EarthquakeHistoryListTile(
              item: item,
              areaInfo: areaInfo,
              areaName: areaName,
              intensityColor: IntensityColorModel.jma(),
              showCurrentLocationIntensity: showCurrentLocationIntensity,
            ),
          ),
        ),
      ),
    );
  }

  String richTextPlainText(WidgetTester tester) => tester
      .widgetList<RichText>(find.byType(RichText))
      .map((widget) => widget.text.toPlainText())
      .join('\n');

  testWidgets('地域検索の対象地域震度を表示する', (tester) async {
    const areaInfo = IntensityAreaInfo(
      code: '13101',
      name: '東京都千代田区',
      intensity: JmaIntensity.four,
      lpgmIntensity: null,
    );

    await pumpListTile(
      tester,
      areaInfo: areaInfo,
      areaName: areaInfo.name,
    );

    expect(richTextPlainText(tester), contains('東京都千代田区 震度4'));
  });

  testWidgets('現在地スコープの対象地域震度を表示する', (tester) async {
    await pumpListTile(
      tester,
      showCurrentLocationIntensity: true,
      overrides: [
        locationStreamProvider.overrideWith((ref) => Stream.value(position())),
        jmaMapAreaInformationCityInsideProvider.overrideWith(
          (ref, latLng) async => const MapDataItem(
            property: MapDataProperty(
              code: '13101',
              name: '東京都千代田区',
              nameKana: 'トウキョウトチヨダク',
            ),
          ),
        ),
        jmaMapAreaForecastLocalEInsideProvider.overrideWith(
          (ref, latLng) async => const MapDataItem(
            property: MapDataProperty(
              code: '9011',
              name: '東京都２３区',
              nameKana: 'トウキョウトニジュウサンク',
            ),
          ),
        ),
        currentLocationIntensityProvider(
          eventId: eventId,
          cityAreaCode: '13101',
          regionAreaCode: '9011',
        ).overrideWith(
          (ref) async => const CurrentLocationIntensityDisplay.result(
            intensity: JmaIntensity.three,
            lpgmIntensity: null,
          ),
        ),
      ],
    );
    await tester.pump();

    expect(richTextPlainText(tester), contains('現在地 震度3'));
  });
}
