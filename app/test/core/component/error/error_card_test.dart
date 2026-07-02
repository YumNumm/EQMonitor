import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrap(Widget child) => ProviderScope(
    child: MaterialApp(home: Scaffold(body: child)),
  );

  testWidgets('onReload 指定時に再試行ボタンを表示する', (tester) async {
    var reloaded = false;
    await tester.pumpWidget(
      wrap(
        ErrorCard(
          error: Exception('boom'),
          onReload: () async => reloaded = true,
        ),
      ),
    );
    await tester.pump();
    expect(find.text('再試行'), findsOneWidget);
    await tester.tap(find.text('再試行'));
    // FullScreenCircularProgressIndicator.showUntil uses a 250ms delay before
    // calling reload; advance past it. pumpAndSettle is not usable here because
    // the CircularProgressIndicator animation never settles in unit tests.
    await tester.pump(const Duration(milliseconds: 300));
    expect(reloaded, isTrue);
  });

  testWidgets('showDetails=true で詳細ボタンを表示する', (tester) async {
    await tester.pumpWidget(wrap(ErrorCard(error: Exception('boom'))));
    await tester.pump();
    expect(find.text('詳細'), findsOneWidget);
  });

  testWidgets('showContact=false で問い合わせボタンを表示しない', (tester) async {
    await tester.pumpWidget(
      wrap(ErrorCard(error: Exception('boom'), showContact: false)),
    );
    await tester.pump();
    expect(find.text('問い合わせ'), findsNothing);
  });
}
