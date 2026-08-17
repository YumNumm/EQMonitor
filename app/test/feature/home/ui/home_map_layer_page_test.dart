import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/home/ui/page/home_map_layer_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class _TestApp extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: <ThemeExtension<dynamic>>[DesignSystemThemeExtension.light()],
    );
    return MaterialApp(theme: theme, home: const HomeMapLayerPage());
  }
}

void main() {
  testWidgets('セクションの装飾アイコンだけを表示しない', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: _TestApp()));

    expect(find.byIcon(Icons.emergency_rounded), findsNothing);
    expect(find.byIcon(Icons.vibration_rounded), findsNothing);
    expect(find.byIcon(Icons.my_location_rounded), findsNothing);
    expect(find.byIcon(Icons.sensors_rounded), findsNothing);
    expect(find.byIcon(Icons.map_rounded), findsNothing);
    expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNWidgets(5));
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
  });
}
