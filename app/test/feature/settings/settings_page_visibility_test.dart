import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/ads/data/notifier/ads_opt_out_notifier.dart';
import 'package:eqmonitor/feature/settings/settings_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _pumpSettings(
  WidgetTester tester, {
  required BuildConfig buildConfig,
}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        data_prefs.sharedPreferencesProvider.overrideWithValue(
          AsyncValue.data(prefs),
        ),
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
        adsOptOutProvider.overrideWithBuild((_, _) => false),
        buildConfigProvider.overrideWithValue(buildConfig),
        packageInfoProvider.overrideWithValue(_packageInfo),
      ],
      child: const _TestApp(home: SettingsPage()),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('Pro 無効時は EQMonitor Pro セクションを表示しない', (tester) async {
    await _pumpSettings(
      tester,
      buildConfig: _buildConfig(isProFeaturesEnabled: false),
    );

    expect(find.text('EQMonitor Pro'), findsNothing);
  });

  testWidgets('Pro 有効時は EQMonitor Pro セクションを表示する', (tester) async {
    await _pumpSettings(
      tester,
      buildConfig: _buildConfig(isProFeaturesEnabled: true),
    );

    expect(find.text('EQMonitor Pro'), findsWidgets);
  });

  testWidgets('developer UI 有効時は HTTP キャッシュを表示する', (tester) async {
    await _pumpSettings(
      tester,
      buildConfig: _buildConfig(flavor: Flavor.dev, isBetaTesting: true),
    );

    await tester.scrollUntilVisible(
      find.text('Powered by Flutter'),
      300,
      scrollable: find.byType(Scrollable),
    );

    expect(find.text('HTTPキャッシュ'), findsOneWidget);
  });

  testWidgets('BETA×prod では HTTP キャッシュを表示しない', (tester) async {
    await _pumpSettings(
      tester,
      buildConfig: _buildConfig(flavor: Flavor.prod, isBetaTesting: true),
    );

    await tester.scrollUntilVisible(
      find.text('Powered by Flutter'),
      300,
      scrollable: find.byType(Scrollable),
    );

    expect(find.text('HTTPキャッシュ'), findsNothing);
  });
}

BuildConfig _buildConfig({
  Flavor flavor = Flavor.dev,
  bool isBetaTesting = false,
  bool isProFeaturesEnabled = false,
}) => BuildConfig(
  restApiUrl: '',
  appIdSuffix: '',
  appName: 'EQMonitor',
  commitInformation: 'test',
  flavor: flavor,
  wsApiUrl: '',
  googleIosClientId: '',
  googleAndroidClientId: '',
  buildTimestamp: '',
  buildCommitMessage: '',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
  isBetaTesting: isBetaTesting,
  isProFeaturesEnabled: isProFeaturesEnabled,
);

final _packageInfo = PackageInfo(
  appName: 'EQMonitor',
  packageName: 'net.yumnumm.eqmonitor',
  version: '1.2.3',
  buildNumber: '456',
);

class _TestApp extends StatelessWidget {
  const new({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    );
    return MaterialApp(theme: theme, home: home);
  }
}
