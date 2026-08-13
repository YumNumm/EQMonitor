import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_navigation_back_button.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('戻れる画面では戻るボタンを表示して pop する', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        initialRoute: '/detail',
        routes: {
          '/': (_) => const Scaffold(body: Text('home')),
          '/detail': (_) => const Scaffold(
            body: Stack(
              children: [
                Text('detail'),
                IntensityHistoryNavigationBackButton(),
              ],
            ),
          ),
        },
      ),
    );

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('戻れない画面では戻るボタンを表示しない', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              Text('home'),
              IntensityHistoryNavigationBackButton(),
            ],
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.arrow_back), findsNothing);
  });
}
