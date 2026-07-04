import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/provider/theme_presets_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('themePresetsProvider は EQMonitor Default と JMA Standard を含む', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
      ],
    );
    addTearDown(container.dispose);

    final presets = container.read(themePresetsProvider);
    expect(presets.length, 2);
    expect(presets.map((e) => e.name), [
      AppTheme.eqmonitorDefault().name,
      AppTheme.jmaStandard().name,
    ]);
  });
}
