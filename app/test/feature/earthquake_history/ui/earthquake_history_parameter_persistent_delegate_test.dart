import 'package:eqmonitor/core/component/chip/status_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/telegram_type_filter_chip.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_parameter_persistent_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpDelegate(
    WidgetTester tester, {
    required bool isDebugEnabled,
  }) async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.debug.key: isDebugEnabled,
    });
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(AsyncData(preferences)),
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
                    parameter: const EarthquakeHistoryParameter.all(
                      sortBy: EarthquakeSortBy.eventId,
                      sortOrder: SortOrder.desc,
                    ),
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
}
