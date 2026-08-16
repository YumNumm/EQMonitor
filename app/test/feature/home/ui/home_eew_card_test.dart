import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_estimated_region.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_estimated_region_intensity_provider.dart';
import 'package:eqmonitor/feature/home/data/provider/home_eew_estimation_debug_provider.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/home_eew_card.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/model/map_data_item.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final _now = DateTime.utc(2026, 8, 14, 12);

/// 現在地の予報区がJMAの予想震度に含まれないEEW。
final _eew = EewTelegramItem(
  eventId: 'test-1',
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: _now,
  isPlum: false,
  isWarning: false,
  originTime: _now.subtract(const Duration(seconds: 10)),
  hypocenter: const EewHypocenterInfo(
    code: 'h1',
    name: '東京湾',
    magnitude: 5.4,
    depth: 30,
  ),
  forecastIntensity: const EewForecastIntensityInfo(
    regions: [],
    maxIntensity: JmaIntensity.four,
  ),
);

final _estimatedRegions = [
  EewEstimatedRegion(
    regionCode: '130010',
    regionName: '東京都23区',
    intensity: 3.6,
    jmaIntensity: JmaIntensity.four,
    sWaveArrivalTime: _now.add(const Duration(seconds: 30)),
  ),
];

Position _position() => Position(
  latitude: 35.681,
  longitude: 139.767,
  timestamp: _now,
  accuracy: 0,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

Future<void> _pump(WidgetTester tester, {required bool isVisible}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        isHomeEewEstimationVisibleProvider.overrideWith(
          (ref) async => isVisible,
        ),
        eewEstimatedRegionIntensityProvider.overrideWith(
          (ref, eew) async => _estimatedRegions,
        ),
        locationStreamProvider.overrideWith((ref) => Stream.value(_position())),
        jmaMapAreaForecastLocalEInsideProvider.overrideWith(
          (ref, latLng) async => const MapDataItem(
            property: MapDataProperty(
              code: '130010',
              name: '東京都23区',
              nameKana: 'トウキョウトニジュウサンク',
            ),
          ),
        ),
        timeTickerProvider().overrideWith((ref) => Stream.value(_now)),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        home: Scaffold(body: HomeEewCard(eew: _eew, index: null)),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
  await tester.pump();
}

void main() {
  testWidgets('設定が有効なら推計震度と到達予想時刻を表示する', (tester) async {
    await _pump(tester, isVisible: true);

    expect(find.text('東京都23区'), findsOneWidget);
    expect(find.text('主要動到達まで'), findsOneWidget);
  });

  testWidgets('設定が無効なら推計震度と到達予想時刻を表示しない', (tester) async {
    await _pump(tester, isVisible: false);

    expect(find.text('主要動到達まで'), findsNothing);
  });
}
