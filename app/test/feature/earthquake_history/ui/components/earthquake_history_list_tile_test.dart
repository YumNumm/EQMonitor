import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  const parameter = EarthquakeHistoryParameter.all(
    sortBy: EarthquakeSortBy.eventId,
    sortOrder: SortOrder.desc,
  );

  Future<void> pumpTile(
    WidgetTester tester, {
    required ShindoDbIntensityClass? maxIntensityClass,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        home: Scaffold(
          body: EarthquakeHistoryListTile(
            item: EarthquakePartial.normal(
              eventId: '193006010258',
              status: TelegramStatus.normal,
              originTime: DateTime.utc(1930, 6, 1, 2, 58),
              originTimePrecision: OriginTimePrecision.second,
              arrivalTime: null,
              dataSources: const [EarthquakeDataSource.jmaIntensityDatabase],
              hypocenter: null,
              intensity: EarthquakeIntensityPartial(
                maxIntensity: JmaIntensity.fiveLower,
                maxLpgmIntensity: null,
                maxIntensityClass: maxIntensityClass,
              ),
              earthquakeType: EarthquakeType.normal,
              telegramTypes: const [],
              estimatedIntensityTileUrl: null,
            ),
            searchParameter: parameter,
          ),
        ),
      ),
    );
  }

  testWidgets('旧震度5は細分化されていない5として表示すること', (tester) async {
    await pumpTile(tester, maxIntensityClass: ShindoDbIntensityClass.five);

    final icon = tester.widget<ShindoDbIntensityClassIcon>(
      find.byType(ShindoDbIntensityClassIcon),
    );
    expect(icon.intensityClass, ShindoDbIntensityClass.five);
    expect(find.text('最大震度5を観測'), findsOneWidget);
  });

  testWidgets('旧震度階級がない5弱は従来の表示を維持すること', (tester) async {
    await pumpTile(tester, maxIntensityClass: null);

    expect(find.byType(ShindoDbIntensityClassIcon), findsNothing);
    expect(find.byType(JmaIntensityIcon), findsOneWidget);
    expect(find.text('最大震度5-を観測'), findsOneWidget);
  });
}
