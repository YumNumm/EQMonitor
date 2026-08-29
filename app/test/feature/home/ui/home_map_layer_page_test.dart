import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/home/ui/page/home_map_layer_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../fixtures/build_config.dart';

class _TestApp extends StatelessWidget {
  const new({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: <ThemeExtension<dynamic>>[DesignSystemThemeExtension.light()],
    );
    return MaterialApp(theme: theme, home: home);
  }
}

Future<void> _pumpPage(
  WidgetTester tester, {
  required BuildConfig buildConfig,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [buildConfigProvider.overrideWithValue(buildConfig)],
      child: const _TestApp(home: HomeMapLayerPage()),
    ),
  );
}

void main() {
  testWidgets('セクションの装飾アイコンだけを表示しない', (tester) async {
    await _pumpPage(tester, buildConfig: const BuildConfigFixture().build());

    expect(find.byIcon(Icons.emergency_rounded), findsNothing);
    expect(find.byIcon(Icons.vibration_rounded), findsNothing);
    expect(find.byIcon(Icons.my_location_rounded), findsNothing);
    expect(find.byIcon(Icons.sensors_rounded), findsNothing);
    expect(find.byIcon(Icons.map_rounded), findsNothing);
    expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNWidgets(5));
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
  });

  testWidgets('isBetaTesting が false のときは揺れ検知セクションを表示する', (tester) async {
    await _pumpPage(
      tester,
      buildConfig: const BuildConfigFixture().build(isBetaTesting: false),
    );

    expect(find.text('揺れ検知'), findsOneWidget);
  });

  testWidgets('isBetaTesting が true のときは揺れ検知セクションを表示しない', (tester) async {
    await _pumpPage(
      tester,
      buildConfig: const BuildConfigFixture().build(isBetaTesting: true),
    );

    expect(find.text('揺れ検知'), findsNothing);
    expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNWidgets(4));
  });
}
