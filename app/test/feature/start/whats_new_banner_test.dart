import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/start/ui/component/whats_new_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _packageInfo = PackageInfo(
  appName: 'EQMonitor',
  packageName: 'net.yumnumm.eqmonitor',
  version: '3.0.0',
  buildNumber: '1',
);

Widget _app(Widget child) => MaterialApp(
  theme: ThemeData.light().copyWith(
    extensions: [DesignSystemThemeExtension.light()],
  ),
  home: Scaffold(body: child),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('未読(seen != current)ならバナーを表示', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      ProviderScope(
        overrides: [packageInfoProvider.overrideWithValue(_packageInfo)],
        child: _app(const WhatsNewBanner()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('v3.0.0 へアップデートしました'), findsOneWidget);
  });

  testWidgets('既読(seen == current)ならバナー非表示', (tester) async {
    SharedPreferences.setMockInitialValues({'whats_new_seen_version': '3.0.0'});
    await tester.pumpWidget(
      ProviderScope(
        overrides: [packageInfoProvider.overrideWithValue(_packageInfo)],
        child: _app(const WhatsNewBanner()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('v3.0.0 へアップデートしました'), findsNothing);
  });

  testWidgets('閉じるボタンで既読化しバナーが消える', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      ProviderScope(
        overrides: [packageInfoProvider.overrideWithValue(_packageInfo)],
        child: _app(const WhatsNewBanner()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('閉じる'));
    await tester.pumpAndSettle();

    expect(find.text('v3.0.0 へアップデートしました'), findsNothing);
  });
}
