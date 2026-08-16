import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/ui/component/test_notification_kind_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('通常と重大な通知だけを表示し重大な通知の種別を渡す', (tester) async {
    TestNotificationKind? pressedKind;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TestNotificationKindButtons(
            pendingKind: null,
            onPressed: (kind) async => pressedKind = kind,
          ),
        ),
      ),
    );

    expect(find.text('通常'), findsOneWidget);
    expect(find.text('重大な通知'), findsOneWidget);
    expect(find.text('サイレント'), findsNothing);
    expect(find.text('クリティカル'), findsNothing);

    await tester.tap(find.text('重大な通知'));

    expect(pressedKind, TestNotificationKind.critical);
  });

  testWidgets('送信中のボタンを再度タップしてもcallbackを実行しない', (tester) async {
    var pressedCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TestNotificationKindButtons(
            pendingKind: TestNotificationKind.normal,
            onPressed: (_) async => pressedCount++,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.tap(find.byType(FilledButton).first);

    expect(pressedCount, 0);
  });
}
