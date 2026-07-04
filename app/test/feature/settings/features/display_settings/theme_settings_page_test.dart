import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_settings_page.dart';
import 'package:flutter/material.dart';
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

    final state = container.read(appThemeProvider);
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
}
