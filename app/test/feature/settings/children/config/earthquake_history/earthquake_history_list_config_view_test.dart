import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/settings/children/config/earthquake_history/earthquake_history_list_config_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpView(
    WidgetTester tester, {
    required EarthquakeHistoryListConfig config,
    required Future<void> Function(EarthquakeHistoryListConfig) onChanged,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [DesignSystemThemeExtension.light()],
        ),
        home: Scaffold(
          body: SingleChildScrollView(
            child: EarthquakeHistoryListConfigView(
              config: config,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('日付見出しの3つの表示方法を提示する', (tester) async {
    await pumpView(
      tester,
      config: const EarthquakeHistoryListConfig(),
      onChanged: (_) async {},
    );

    expect(find.text('日付見出し'), findsOneWidget);
    expect(find.text('常に表示'), findsOneWidget);
    expect(find.text('発生時刻順のときのみ'), findsOneWidget);
    expect(find.text('表示しない'), findsOneWidget);
  });

  testWidgets('表示しないを選ぶと背景設定を保ったまま変更を通知する', (tester) async {
    const initial = EarthquakeHistoryListConfig(isFillBackground: false);
    EarthquakeHistoryListConfig? changed;
    await pumpView(
      tester,
      config: initial,
      onChanged: (value) async => changed = value,
    );

    await tester.tap(find.text('表示しない'));
    await tester.pump();

    expect(
      changed,
      initial.copyWith(dateHeaderDisplayMode: DateHeaderDisplayMode.never),
    );
  });
}
