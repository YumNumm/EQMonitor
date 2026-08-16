import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:eqmonitor/core/theme/model/theme_color_field_def.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/data/notifier/theme_editor_controller.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_editor_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  TestWidgetsFlutterBinding.ensureInitialized();

  test('updateField は現在の色を反映しカスタムテーマとして保存する', () async {
    final container = await _container();
    addTearDown(container.dispose);

    const probe = Color(0xFF112233);
    await container
        .read(themeEditorControllerProvider(ThemeBrightnessMode.light).notifier)
        .updateField(
          ThemeColorFieldDefs.all.firstWhere((e) => e.label == 'プライマリ'),
          probe,
        );

    final colorSet = container.read(
      themeEditorControllerProvider(ThemeBrightnessMode.light),
    );
    expect(colorSet.primary, probe);

    final themes = await container.read(appThemeProvider.future);
    expect(themes.lightTheme.name, 'カスタム');
    expect(themes.lightTheme.light!.primary, probe);
  });

  testWidgets('Primaryスウォッチをタップして色を変更するとカスタム化される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _TestApp(
          home: const ThemeEditorPage(mode: ThemeBrightnessMode.light),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('プライマリ'));
    await tester.pumpAndSettle();
    final primaryTile = find.byKey(const ValueKey('theme_color_field_プライマリ'));
    await tester.tap(
      find
          .descendant(of: primaryTile, matching: find.byType(GestureDetector))
          .last,
    );
    await tester.pumpAndSettle();

    final picker = tester.widget<ColorPicker>(find.byType(ColorPicker));
    picker.onColorChanged(const Color(0xFF445566));
    await tester.pumpAndSettle();
    await tester.tap(find.text('適用'));
    await tester.pumpAndSettle();

    final themes = await container.read(appThemeProvider.future);
    expect(themes.lightTheme.name, 'カスタム');
    expect(themes.lightTheme.light!.primary, const Color(0xFF445566));
  });

  testWidgets('震度7の背景色を変更するとカスタム化される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _TestApp(
          home: const ThemeEditorPage(mode: ThemeBrightnessMode.light),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('震度配色'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('intensity-bg-震度7')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('intensity-bg-震度7')));
    await tester.pumpAndSettle();

    final picker = tester.widget<ColorPicker>(find.byType(ColorPicker));
    picker.onColorChanged(const Color(0xFF998877));
    await tester.pumpAndSettle();
    await tester.tap(find.text('適用'));
    await tester.pumpAndSettle();

    final themes = await container.read(appThemeProvider.future);
    expect(
      themes.lightTheme.light!.intensity.seven.background,
      const Color(0xFF998877),
    );
  });

  testWidgets('震度7の文字色を手動に切り替えて色を選ぶとmanualになる', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _TestApp(
          home: const ThemeEditorPage(mode: ThemeBrightnessMode.light),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('震度配色'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const ValueKey('intensity-fg-mode-震度7')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('intensity-fg-mode-震度7')));
    await tester.pumpAndSettle();
    // ToggleButtons/SegmentedButton等で「手動」を選択
    await tester.tap(find.text('手動').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const ValueKey('intensity-fg-manual-震度7')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('intensity-fg-manual-震度7')));
    await tester.pumpAndSettle();

    final picker = tester.widget<ColorPicker>(find.byType(ColorPicker));
    picker.onColorChanged(const Color(0xFF001122));
    await tester.pumpAndSettle();
    await tester.tap(find.text('適用'));
    await tester.pumpAndSettle();

    final themes = await container.read(appThemeProvider.future);
    final foreground = themes.lightTheme.light!.intensity.seven.foreground;
    expect(foreground, isA<IntensityTextColorManual>());
    expect(
      (foreground as IntensityTextColorManual).color,
      const Color(0xFF001122),
    );
  });
}
