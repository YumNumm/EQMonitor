import 'package:eqmonitor/core/component/chip/sort_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/status_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/telegram_type_filter_chip.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/region_name_resolver.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_parameter_persistent_delegate.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpDelegate(
    WidgetTester tester, {
    required bool isDebugEnabled,
    EarthquakeHistoryParameter parameter = const EarthquakeHistoryParameter.all(
      sortBy: EarthquakeSortBy.eventId,
      sortOrder: SortOrder.desc,
    ),
  }) async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.debug.key: isDebugEnabled,
    });
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(AsyncData(preferences)),
          regionNameProvider(
            RegionSearchType.region,
            '010100',
          ).overrideWith((ref) async => '道央'),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: EarthquakeHistoryParameterPersistentDelegate(
                    parameter: parameter,
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('デバッグモードが無効な場合はデバッグ用フィルターを表示しない', (tester) async {
    await pumpDelegate(tester, isDebugEnabled: false);

    expect(find.byType(StatusFilterChip), findsNothing);
    expect(find.byType(TelegramTypeFilterChip), findsNothing);
  });

  testWidgets('デバッグモードが有効な場合はデバッグ用フィルターを表示する', (tester) async {
    await pumpDelegate(tester, isDebugEnabled: true);

    expect(find.byType(StatusFilterChip), findsOneWidget);
    expect(find.byType(TelegramTypeFilterChip), findsOneWidget);
  });

  testWidgets('全国一覧の震度フィルターは最大観測震度と表示する', (tester) async {
    await pumpDelegate(tester, isDebugEnabled: false);

    expect(find.text('最大観測震度'), findsOneWidget);
    expect(find.text('選択地域の観測震度'), findsNothing);
  });

  testWidgets('地域一覧の震度フィルターは選択地域の観測震度と表示する', (tester) async {
    await pumpDelegate(
      tester,
      isDebugEnabled: false,
      parameter: const EarthquakeHistoryParameter.region(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        regionCode: '010100',
      ),
    );

    expect(find.text('選択地域の観測震度'), findsOneWidget);
    expect(find.text('最大観測震度'), findsNothing);
  });

  testWidgets('全国一覧の並び替えは地域観測震度を表示しない', (tester) async {
    await pumpDelegate(tester, isDebugEnabled: false);

    await tester.tap(find.byType(SortFilterChip));
    await tester.pumpAndSettle();

    expect(find.text('地震の最大震度'), findsOneWidget);
    expect(find.text('選択地域の観測震度'), findsNothing);
  });

  testWidgets('地域一覧の並び替えは地震の最大震度と地域観測震度を分ける', (tester) async {
    await pumpDelegate(
      tester,
      isDebugEnabled: false,
      parameter: const EarthquakeHistoryParameter.region(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        regionCode: '010100',
      ),
    );

    await tester.tap(find.byType(SortFilterChip));
    await tester.pumpAndSettle();

    expect(find.text('地震の最大震度'), findsOneWidget);
    expect(
      find.widgetWithText(
        RadioListTile<EarthquakeSortBy>,
        '選択地域の観測震度',
      ),
      findsOneWidget,
    );
  });
}
