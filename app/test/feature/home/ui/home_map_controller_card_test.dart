import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_controller_card.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('無効なホームボタンはタップを受け付けない', (tester) async {
    var tapCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [DesignSystemThemeExtension.light()],
        ),
        home: Scaffold(
          body: HomeMapControllerCard(
            isLocationButtonEnabled: false,
            onLocationButtonTap: () => tapCount += 1,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.home_rounded));
    await tester.pump();

    expect(tapCount, 0);
  });
}
