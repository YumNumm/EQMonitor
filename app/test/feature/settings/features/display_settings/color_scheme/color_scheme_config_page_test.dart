import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/color_scheme/color_scheme_config_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<ProviderContainer> pumpPage(WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: ColorSchemeConfigPage()),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  testWidgets('プリセット適用ボタンで配色が更新される', (tester) async {
    final container = await pumpPage(tester);

    await tester.tap(find.text('気象庁配色を適用'));
    await tester.pumpAndSettle();

    expect(container.read(intensityColorProvider), IntensityColorModel.jma());
  });

  testWidgets('Provider更新時にカスタム配色プレビューへ反映される', (tester) async {
    final container = await pumpPage(tester);
    const color = Color(0xFF123456);
    final next = container
        .read(intensityColorProvider)
        .copyWithTargetBackground(IntensityColorTarget.seven, color);
    await container.read(intensityColorProvider.notifier).update(next);
    await tester.pumpAndSettle();

    final widget = tester.widget<Container>(
      find.byKey(const ValueKey('intensity-bg-seven')),
    );
    final decoration = widget.decoration! as BoxDecoration;
    expect(decoration.color, color);
  });

  testWidgets('クリップボードへエクスポートで完了メッセージを表示', (tester) async {
    await pumpPage(tester);

    final exportButton = find.text('クリップボードへエクスポート');
    await tester.ensureVisible(exportButton);
    await tester.tap(exportButton);
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('JSONをクリップボードにコピーしました'), findsOneWidget);
  });
}
