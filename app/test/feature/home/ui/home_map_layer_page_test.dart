import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_menu_availability_provider.dart';
import 'package:eqmonitor/feature/home/ui/page/home_map_layer_page.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_tuning_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../fixtures/build_config.dart';

class const _TestApp({required final Widget home}) extends StatelessWidget {
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
  required bool isShakeDetectionEnabled,
  bool isDebugMenuAvailable = false,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        buildConfigProvider.overrideWithValue(
          const BuildConfigFixture().build(),
        ),
        isDeviceShakeDetectionEnabledProvider.overrideWithValue(
          isShakeDetectionEnabled,
        ),
        isDebugMenuAvailableProvider.overrideWithValue(isDebugMenuAvailable),
      ],
      child: const _TestApp(home: HomeMapLayerPage()),
    ),
  );
}

void main() {
  testWidgets('セクションの装飾アイコンだけを表示しない', (tester) async {
    await _pumpPage(tester, isShakeDetectionEnabled: true);

    expect(find.byIcon(Icons.emergency_rounded), findsNothing);
    expect(find.byIcon(Icons.vibration_rounded), findsNothing);
    expect(find.byIcon(Icons.my_location_rounded), findsNothing);
    expect(find.byIcon(Icons.sensors_rounded), findsNothing);
    expect(find.byIcon(Icons.map_rounded), findsNothing);
    expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNWidgets(5));
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
  });

  testWidgets('端末内の揺れ検知が有効なときは揺れ検知セクションを表示する', (tester) async {
    await _pumpPage(tester, isShakeDetectionEnabled: true);

    expect(find.text('揺れ検知'), findsOneWidget);
  });

  testWidgets('端末内の揺れ検知が無効なときは揺れ検知セクションを表示しない', (tester) async {
    await _pumpPage(tester, isShakeDetectionEnabled: false);

    expect(find.text('揺れ検知'), findsNothing);
    expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNWidgets(4));
  });

  testWidgets('デバッグメニューを利用できるときはデバッグセクションを表示する', (tester) async {
    await _pumpPage(
      tester,
      isShakeDetectionEnabled: false,
      isDebugMenuAvailable: true,
    );

    expect(find.text('デバッグ'), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNWidgets(5));
  });

  testWidgets('デバッグメニューを利用できないときはデバッグセクションを表示しない', (tester) async {
    await _pumpPage(tester, isShakeDetectionEnabled: false);

    expect(find.text('デバッグ'), findsNothing);
  });
}
