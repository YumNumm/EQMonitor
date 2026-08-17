import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/depth_text.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_summary_header.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_type_icon.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/magnitude_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Earthquake buildEarthquake({
    required EarthquakeType? earthquakeType,
    required EarthquakeMagnitude magnitude,
    required EarthquakeDepth depth,
    JmaIntensity? maxIntensity,
  }) => Earthquake(
    eventId: 'test-event',
    status: TelegramStatus.normal,
    originTime: DateTime.utc(2026, 8, 15, 6, 58),
    originTimePrecision: OriginTimePrecision.second,
    arrivalTime: null,
    dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
    telegramTypes: const [],
    hypocenter: EarthquakeHypocenter(
      code: '955',
      name: 'インドネシア付近',
      coordinates: const Coordinate.latLng(latitude: -8.5, longitude: 122.5),
      magnitude: magnitude,
      depth: depth,
      detailedCode: null,
      detailedName: 'インドネシア フローレス',
    ),
    intensity: maxIntensity == null
        ? null
        : EarthquakeIntensity(
            maxIntensity: maxIntensity,
            maxLpgmIntensity: null,
            regions: const {},
            intensityTree: const {},
            lpgmIntensityTree: const {},
          ),
    earthquakeType: earthquakeType,
    estimatedIntensityTileUrl: null,
  );

  Future<void> pumpHeader(WidgetTester tester, Earthquake item) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [DesignSystemThemeExtension.light()],
        ),
        home: Scaffold(body: EarthquakeSummaryHeader(item: item)),
      ),
    );
  }

  EarthquakeTypeIcon typeIcon(WidgetTester tester) =>
      tester.widget<EarthquakeTypeIcon>(find.byType(EarthquakeTypeIcon));

  group('火山噴火', () {
    testWidgets('最大震度の位置に火山アイコンを表示する', (tester) async {
      await pumpHeader(
        tester,
        buildEarthquake(
          earthquakeType: EarthquakeType.volcano,
          magnitude: const EarthquakeMagnitude.unknown(),
          depth: const EarthquakeDepth.unknown(),
        ),
      );

      expect(typeIcon(tester).type, EarthquakeType.volcano);
      expect(find.byType(JmaIntensityIcon), findsNothing);
      expect(find.text('最大震度'), findsNothing);
    });

    testWidgets('マグニチュード不明時は"火山の噴火"を表示する', (tester) async {
      await pumpHeader(
        tester,
        buildEarthquake(
          earthquakeType: EarthquakeType.volcano,
          magnitude: const EarthquakeMagnitude.unknown(),
          depth: const EarthquakeDepth.unknown(),
        ),
      );

      expect(find.text('火山の噴火'), findsOneWidget);
      expect(find.text('不明'), findsNothing);
      expect(find.text('調査中'), findsNothing);
    });

    testWidgets('震源地ではなく発生場所として震源要素名を表示する', (tester) async {
      await pumpHeader(
        tester,
        buildEarthquake(
          earthquakeType: EarthquakeType.volcano,
          magnitude: const EarthquakeMagnitude.unknown(),
          depth: const EarthquakeDepth.unknown(),
        ),
      );

      expect(find.text('発生場所'), findsOneWidget);
      expect(find.text('震源地'), findsNothing);
    });

    testWidgets('深さが判明している場合は深さのみ表示する', (tester) async {
      await pumpHeader(
        tester,
        buildEarthquake(
          earthquakeType: EarthquakeType.volcano,
          magnitude: const EarthquakeMagnitude.unknown(),
          depth: const EarthquakeDepth.shallow(),
        ),
      );

      expect(find.text('火山の噴火'), findsOneWidget);
      expect(find.byType(DepthText), findsOneWidget);
      expect(find.text('深さごく浅い', findRichText: true), findsOneWidget);
    });
  });

  group('遠地地震', () {
    testWidgets('震度がない場合は最大震度の位置に種別アイコンを表示する', (tester) async {
      await pumpHeader(
        tester,
        buildEarthquake(
          earthquakeType: EarthquakeType.distant,
          magnitude: const EarthquakeMagnitude.value(value: 7.7),
          depth: const EarthquakeDepth.unknown(),
        ),
      );

      expect(typeIcon(tester).type, EarthquakeType.distant);
      expect(find.byType(JmaIntensityIcon), findsNothing);
    });

    testWidgets('震度がある場合は最大震度を表示する', (tester) async {
      await pumpHeader(
        tester,
        buildEarthquake(
          earthquakeType: EarthquakeType.distant,
          magnitude: const EarthquakeMagnitude.value(value: 7.7),
          depth: const EarthquakeDepth.value(value: 30),
          maxIntensity: JmaIntensity.one,
        ),
      );

      expect(find.byType(EarthquakeTypeIcon), findsNothing);
      expect(find.text('最大震度'), findsOneWidget);
      expect(find.byType(JmaIntensityIcon), findsOneWidget);
    });

    testWidgets('深さが不明ならマグニチュードのみ表示する', (tester) async {
      await pumpHeader(
        tester,
        buildEarthquake(
          earthquakeType: EarthquakeType.distant,
          magnitude: const EarthquakeMagnitude.value(value: 7.7),
          depth: const EarthquakeDepth.unknown(),
        ),
      );

      expect(find.text('7.7'), findsOneWidget);
      expect(find.byType(DepthText), findsNothing);
      expect(find.text('調査中'), findsNothing);
      expect(find.text('火山の噴火'), findsNothing);
    });

    testWidgets('マグニチュードが不明なら深さのみ表示する', (tester) async {
      await pumpHeader(
        tester,
        buildEarthquake(
          earthquakeType: EarthquakeType.distant,
          magnitude: const EarthquakeMagnitude.unknown(),
          depth: const EarthquakeDepth.value(value: 30),
        ),
      );

      expect(find.text('深さ30km', findRichText: true), findsOneWidget);
      expect(find.byType(MagnitudeText), findsNothing);
      expect(find.text('不明'), findsNothing);
      expect(find.text('火山の噴火'), findsNothing);
    });

    testWidgets('震源地の接頭辞は震源地のままとする', (tester) async {
      await pumpHeader(
        tester,
        buildEarthquake(
          earthquakeType: EarthquakeType.distant,
          magnitude: const EarthquakeMagnitude.value(value: 7.7),
          depth: const EarthquakeDepth.unknown(),
        ),
      );

      expect(find.text('震源地'), findsOneWidget);
      expect(find.text('発生場所'), findsNothing);
    });
  });

  group('通常の地震', () {
    testWidgets('M・深さが不明なら従来通り調査中を表示する', (tester) async {
      await pumpHeader(
        tester,
        buildEarthquake(
          earthquakeType: EarthquakeType.normal,
          magnitude: const EarthquakeMagnitude.unknown(),
          depth: const EarthquakeDepth.unknown(),
        ),
      );

      expect(find.text('M・深さ'), findsOneWidget);
      expect(find.text('調査中'), findsOneWidget);
      expect(find.text('震源地'), findsOneWidget);
      expect(find.byType(EarthquakeTypeIcon), findsNothing);
    });

    testWidgets('種別がnullでも通常の地震として扱う', (tester) async {
      await pumpHeader(
        tester,
        buildEarthquake(
          earthquakeType: null,
          magnitude: const EarthquakeMagnitude.value(value: 5.5),
          depth: const EarthquakeDepth.value(value: 10),
          maxIntensity: JmaIntensity.four,
        ),
      );

      expect(find.byType(EarthquakeTypeIcon), findsNothing);
      expect(find.text('最大震度'), findsOneWidget);
      expect(find.text('5.5'), findsOneWidget);
      expect(find.text('震源地'), findsOneWidget);
    });
  });
}
