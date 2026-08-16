import 'package:eqmonitor/core/component/sheet/app_sheet_route.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/test_notification_sheet.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/test_notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecordingNavigatorObserver extends NavigatorObserver {
  Route<Object?>? lastRoute;

  @override
  void didPush(Route<Object?> route, Route<Object?>? previousRoute) {
    lastRoute = route;
  }
}

void main() {
  testWidgets('タップするとAppSheetRouteでテスト通知Sheetを表示する', (tester) async {
    final observer = RecordingNavigatorObserver();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          navigatorObservers: [observer],
          home: const Scaffold(body: TestNotificationTile()),
        ),
      ),
    );

    await tester.tap(find.text('テスト通知を送信'));
    await tester.pumpAndSettle();

    expect(find.byType(TestNotificationSheet), findsOneWidget);
    expect(observer.lastRoute, isA<AppSheetRoute<void>>());
  });
}
