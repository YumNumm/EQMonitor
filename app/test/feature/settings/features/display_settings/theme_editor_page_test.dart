import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/theme_color_field_def.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/data/notifier/theme_editor_controller.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_editor_page.dart';
import 'package:flutter/material.dart';
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
  return ProviderContainer(
    overrides: [
      app_prefs.sharedPreferencesProvider.overrideWithValue(
        app_prefs.SharedPreferencesAsync(prefs),
      ),
    ],
  );
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
          ThemeColorFieldDefs.all.firstWhere((e) => e.label == 'Primary'),
          probe,
        );

    final colorSet = container.read(
      themeEditorControllerProvider(ThemeBrightnessMode.light),
    );
    expect(colorSet.primary, probe);

    final themes = container.read(appThemeProvider);
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

    await tester.tap(find.text('Primary'));
    await tester.pumpAndSettle();
    final primaryTile = find.byKey(const ValueKey('theme_color_field_Primary'));
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

    final themes = container.read(appThemeProvider);
    expect(themes.lightTheme.name, 'カスタム');
    expect(themes.lightTheme.light!.primary, const Color(0xFF445566));
  });
}
