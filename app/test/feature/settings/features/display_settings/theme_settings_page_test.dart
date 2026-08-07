import 'dart:convert';

import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TestApp extends StatelessWidget {
  const _TestApp({required this.home});
  final Widget home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    );
    return MaterialApp(theme: theme, home: home);
  }
}

Future<ProviderContainer> _container() async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [
      app_prefs.sharedPreferencesProvider.overrideWithValue(
        app_prefs.SharedPreferencesAsync(prefs),
      ),
    ],
  );
  // 本番では起動時に解決済みの appThemeProvider を各 Widget が requireValue で
  // 読むため、build 前に ready にしておく。
  await container.read(appThemeProvider.future);
  return container;
}

void main() {
  testWidgets('JMA Standardプリセットをタップするとlightテーマに保存される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _TestApp(home: ThemeSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppTheme.jmaStandard().name).first);
    await tester.pumpAndSettle();

    final state = await container.read(appThemeProvider.future);
    expect(state.lightTheme.name, AppTheme.jmaStandard().name);
  });

  testWidgets('編集ボタンをタップするとThemeEditorRouteへ遷移する', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _TestApp(home: ThemeSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('編集'), findsWidgets);
  });

  testWidgets('不正なJSONをインポートするとエラーダイアログが表示される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _TestApp(home: ThemeSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('JSONをインポート'));
    await tester.tap(find.text('JSONをインポート'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'not json at all');
    await tester.tap(find.text('インポート'));
    await tester.pumpAndSettle();

    expect(find.text('インポートに失敗しました'), findsOneWidget);
  });

  testWidgets('正常なJSONをインポートして適用するとlightテーマに反映される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _TestApp(home: ThemeSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    final imported = AppTheme.eqmonitorDefault().copyWith(
      name: 'インポートテーマ',
      modes: const [ThemeBrightnessMode.light],
      dark: null,
    );
    final json = const JsonEncoder().convert(imported.toJson());

    await tester.ensureVisible(find.text('JSONをインポート'));
    await tester.tap(find.text('JSONをインポート'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), json);
    await tester.tap(find.text('インポート'));
    await tester.pumpAndSettle();

    expect(find.text('適用'), findsOneWidget);
    await tester.tap(find.text('適用'));
    await tester.pumpAndSettle();

    final state = await container.read(appThemeProvider.future);
    expect(state.lightTheme.name, 'インポートテーマ');
  });

  testWidgets('適用先のチェックを全て外すと適用ボタンが無効になる', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _TestApp(home: ThemeSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    final imported = AppTheme.eqmonitorDefault().copyWith(name: 'インポートテーマ');
    final json = const JsonEncoder().convert(imported.toJson());

    await tester.ensureVisible(find.text('JSONをインポート'));
    await tester.tap(find.text('JSONをインポート'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), json);
    await tester.tap(find.text('インポート'));
    await tester.pumpAndSettle();

    expect(find.text('適用先を選択'), findsOneWidget);

    // 全てのチェックボックスを外す
    // (タップの都度ダイアログが再構築され、既存のwidget参照は無効になるため
    //  チェック済みのものを毎回検索し直す)
    final checkedFinder = find.byWidgetPredicate(
      (widget) => widget is CheckboxListTile && widget.value == true,
    );
    while (tester.any(checkedFinder)) {
      await tester.tap(checkedFinder.first);
      await tester.pumpAndSettle();
    }

    final applyButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, '適用'),
    );
    expect(applyButton.onPressed, isNull);
  });

  testWidgets('エクスポートするとクリップボードにJSONがコピーされる', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    final copied = <String>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          final args = call.arguments as Map<dynamic, dynamic>;
          copied.add(args['text'] as String);
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _TestApp(home: ThemeSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('ライトをエクスポート'));
    await tester.tap(find.text('ライトをエクスポート'));
    await tester.pumpAndSettle();

    expect(copied, hasLength(1));
    expect(() => jsonDecode(copied.single), returnsNormally);
  });
}
