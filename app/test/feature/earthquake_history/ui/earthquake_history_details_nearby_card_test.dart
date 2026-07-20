import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/nearby_earthquakes_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('詳細シートに近傍地震カードを表示する', (tester) async {
    const eventId = 'current';
    final earthquake = Earthquake(
      eventId: eventId,
      status: TelegramStatus.normal,
      originTime: null,
      originTimePrecision: OriginTimePrecision.second,
      arrivalTime: null,
      dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
      telegramTypes: const [],
      hypocenter: const EarthquakeHypocenter(
        code: '001',
        name: 'テスト震源',
        coordinates: Coordinate.latLng(latitude: 35, longitude: 139),
        magnitude: EarthquakeMagnitude.value(value: 4.5),
        depth: EarthquakeDepth.value(value: 40),
        detailedCode: null,
        detailedName: null,
      ),
      intensity: null,
      estimatedIntensityTileUrl: null,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          earthquakeHistoryDetailsProvider(
            eventId,
          ).overrideWith(() => _StubDetailsNotifier(earthquake)),
          nearbyEarthquakesProvider.overrideWith(
            (ref, query) async => const [],
          ),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [DesignSystemThemeExtension.light()],
          ),
          home: const EarthquakeHistoryDetailsPage(eventId: eventId),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('この震源の近傍で発生した地震'), findsOneWidget);
  });
}

final class _StubDetailsNotifier extends EarthquakeHistoryDetailsNotifier {
  _StubDetailsNotifier(this.earthquake);

  final Earthquake earthquake;

  @override
  Future<Earthquake> build(String eventId) async => earthquake;
}
