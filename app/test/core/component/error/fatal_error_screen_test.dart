import 'package:eqmonitor/core/component/error/fatal_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FatalErrorScreen はメッセージを表示する', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: FatalErrorScreen(error: 'boom')),
    );
    expect(find.textContaining('問題が発生しました'), findsOneWidget);
  });

  testWidgets('buildFatalErrorWidget は MaterialApp 祖先なしでも描画できる', (
    tester,
  ) async {
    final details = FlutterErrorDetails(exception: Exception('boom'));
    await tester.pumpWidget(buildFatalErrorWidget(details));
    expect(tester.takeException(), isNull);
  });
}
