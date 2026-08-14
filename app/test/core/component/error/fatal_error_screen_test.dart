import 'package:eqmonitor/core/component/error/fatal_error_screen.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FatalErrorScreen はメッセージを表示する', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        home: const FatalErrorScreen(error: 'boom'),
      ),
    );
    expect(find.textContaining('問題が発生しました'), findsOneWidget);
  });

  testWidgets('buildFatalErrorWidget は MaterialApp 祖先なしでも描画できる', (
    tester,
  ) async {
    final details = FlutterErrorDetails(exception: Exception('boom'));
    await tester.pumpWidget(FatalErrorWidgetBuilder.build(details));
    expect(tester.takeException(), isNull);
  });
}
