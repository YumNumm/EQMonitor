import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/ads/data/notifier/ads_opt_out_notifier.dart';
import 'package:eqmonitor/feature/settings/data/contact/contact_action.dart';
import 'package:eqmonitor/feature/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows contact tile in app information section', (tester) async {
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
          adsOptOutProvider.overrideWithValue(false),
          buildConfigProvider.overrideWithValue(_buildConfig),
          packageInfoProvider.overrideWithValue(_packageInfo),
        ],
        child: const _TestApp(home: SettingsPage()),
      ),
    );
    await tester.pump();

    await tester.scrollUntilVisible(
      find.text('問い合わせ'),
      300,
      scrollable: find.byType(Scrollable),
    );

    expect(find.text('問い合わせ'), findsOneWidget);
  });

  testWidgets('contact tile delegates opening to ContactAction', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final action = _RecordingContactAction();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          data_prefs.sharedPreferencesProvider.overrideWithValue(
            AsyncValue.data(prefs),
          ),
          app_prefs.sharedPreferencesProvider.overrideWithValue(
            app_prefs.SharedPreferencesAsync(prefs),
          ),
          adsOptOutProvider.overrideWithValue(false),
          buildConfigProvider.overrideWithValue(_buildConfig),
          contactActionProvider.overrideWithValue(action),
          packageInfoProvider.overrideWithValue(_packageInfo),
        ],
        child: const _TestApp(home: SettingsPage()),
      ),
    );
    await tester.pump();

    await tester.scrollUntilVisible(
      find.text('問い合わせ'),
      300,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.text('問い合わせ'));

    expect(action._opened, true);
  });
}

const _buildConfig = BuildConfig(
  restApiUrl: '',
  appIdSuffix: '',
  appName: 'EQMonitor',
  commitInformation: 'test',
  flavor: Flavor.dev,
  wsApiUrl: '',
  googleIosClientId: '',
  googleAndroidClientId: '',
  buildTimestamp: '',
  buildCommitMessage: '',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
);

final _packageInfo = PackageInfo(
  appName: 'EQMonitor',
  packageName: 'net.yumnumm.eqmonitor',
  version: '1.2.3',
  buildNumber: '456',
);

class _RecordingContactAction extends ContactAction {
  var _opened = false;

  @override
  Future<void> open(WidgetRef ref, BuildContext context) async {
    _opened = true;
  }
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: [
        DesignSystemThemeExtension.light(),
      ],
    );
    return MaterialApp(
      theme: theme,
      home: home,
    );
  }
}
