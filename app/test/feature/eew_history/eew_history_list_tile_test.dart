import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew_history/ui/components/eew_history_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('震源地名と最大予想震度が表示される', (tester) async {
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
    final item = EewTelegramItem(
      eventId: 'e1',
      status: TelegramStatus.normal,
      infoType: TelegramInfoType.publication,
      serialNo: 3,
      isCanceled: false,
      isLastInfo: true,
      reportTime: DateTime.utc(2026, 6, 27, 12),
      originTime: DateTime.utc(2026, 6, 27, 12),
      isPlum: false,
      hypocenter: const EewHypocenterInfo(
        code: '100',
        name: '宮城県沖',
        magnitude: 6.2,
      ),
      forecastIntensity: const EewForecastIntensityInfo(
        regions: [],
        maxIntensity: JmaIntensity.fiveLower,
      ),
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: Scaffold(
            body: EewHistoryListTile(
              item: item,
            ),
          ),
        ),
      ),
    );

    expect(find.text('宮城県沖'), findsOneWidget);
  });

  testWidgets('isWarning: true のとき警報バッジが表示される', (tester) async {
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
    final item = EewTelegramItem(
      eventId: 'e2',
      status: TelegramStatus.normal,
      infoType: TelegramInfoType.publication,
      serialNo: 1,
      isCanceled: false,
      isLastInfo: false,
      reportTime: DateTime.utc(2026, 6, 27, 12),
      originTime: DateTime.utc(2026, 6, 27, 12),
      isPlum: false,
      isWarning: true,
      hypocenter: const EewHypocenterInfo(
        code: '200',
        name: '岩手県沖',
        magnitude: 7,
      ),
      forecastIntensity: const EewForecastIntensityInfo(
        regions: [],
        maxIntensity: JmaIntensity.sixLower,
      ),
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: Scaffold(
            body: EewHistoryListTile(
              item: item,
            ),
          ),
        ),
      ),
    );

    expect(find.text('警報'), findsOneWidget);
  });

  testWidgets('isWarning: false のとき警報バッジが表示されない', (tester) async {
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
    final item = EewTelegramItem(
      eventId: 'e3',
      status: TelegramStatus.normal,
      infoType: TelegramInfoType.publication,
      serialNo: 1,
      isCanceled: false,
      isLastInfo: false,
      reportTime: DateTime.utc(2026, 6, 27, 12),
      originTime: DateTime.utc(2026, 6, 27, 12),
      isPlum: false,
      isWarning: false,
      hypocenter: const EewHypocenterInfo(
        code: '300',
        name: '千葉県北西部',
        magnitude: 4.5,
      ),
      forecastIntensity: const EewForecastIntensityInfo(
        regions: [],
        maxIntensity: JmaIntensity.three,
      ),
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: Scaffold(
            body: EewHistoryListTile(
              item: item,
            ),
          ),
        ),
      ),
    );

    expect(find.text('警報'), findsNothing);
  });
}
