import 'dart:async';

import 'package:eqmonitor/core/component/sheet/app_sheet_route.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery_result.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/test_notification_sheet.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/test_notification_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('タップするとAppSheetRouteでテスト通知Sheetを表示する', (tester) async {
    final repository = _PendingPushNotificationRepository();

    await tester.pumpWidget(_TestNotificationApp(repository: repository));

    await tester.tap(find.text('テスト通知を送信'));
    await tester.pumpAndSettle();

    final sheetContext = tester.element(find.byType(TestNotificationSheet));
    expect(ModalRoute.of(sheetContext), isA<AppSheetRoute<void>>());
  });

  testWidgets('Sheetを閉じた後も送信完了までタイルを無効化して重複送信を防ぐ', (tester) async {
    final repository = _PendingPushNotificationRepository();

    await tester.pumpWidget(_TestNotificationApp(repository: repository));

    await tester.tap(find.text('テスト通知を送信'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('通常'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(TestNotificationSheet), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(repository.sendCount, 1);

    await tester.tap(find.text('テスト通知を送信'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(TestNotificationSheet), findsNothing);
    expect(repository.sendCount, 1);

    repository.complete();
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('通常通知を選ぶとSheetを閉じて送信する', (tester) async {
    final repository = _SuccessPushNotificationRepository();

    await tester.pumpWidget(_TestNotificationApp(repository: repository));

    await tester.tap(find.text('テスト通知を送信'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('通常'));
    await tester.pumpAndSettle();

    expect(find.byType(TestNotificationSheet), findsNothing);
    expect(repository.receivedKinds, [TestNotificationKind.normal]);
  });

  testWidgets('重大通知をキャンセルするとSheetを閉じず送信しない', (tester) async {
    final repository = _SuccessPushNotificationRepository();

    await tester.pumpWidget(_TestNotificationApp(repository: repository));

    await tester.tap(find.text('テスト通知を送信'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('重大な通知'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('キャンセル'));
    await tester.pumpAndSettle();

    expect(find.byType(TestNotificationSheet), findsOneWidget);
    expect(repository.receivedKinds, isEmpty);
  });

  testWidgets('重大通知を確認するとSheetを閉じて送信する', (tester) async {
    final repository = _SuccessPushNotificationRepository();

    await tester.pumpWidget(_TestNotificationApp(repository: repository));

    await tester.tap(find.text('テスト通知を送信'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('重大な通知'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('送信する'));
    await tester.pumpAndSettle();

    expect(find.byType(TestNotificationSheet), findsNothing);
    expect(repository.receivedKinds, [TestNotificationKind.critical]);
  });
}

class _TestNotificationApp extends StatelessWidget {
  const new({required this.repository});

  final PushNotificationRepository repository;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    );

    return ProviderScope(
      overrides: [
        deviceIdProvider.overrideWith((ref) async => 'test-device-id'),
        pushNotificationRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
      ],
      child: MaterialApp(
        theme: theme,
        home: const Scaffold(body: TestNotificationTile()),
      ),
    );
  }
}

final class _PendingPushNotificationRepository extends Fake
    implements PushNotificationRepository {
  final completion =
      Completer<Result<TestNotificationDeliveryResult, Exception>>();
  var sendCount = 0;

  @override
  Future<Result<TestNotificationDeliveryResult, Exception>>
  sendTestNotification({
    required String deviceId,
    required TestNotificationKind kind,
  }) {
    expect(deviceId, 'test-device-id');
    expect(kind, TestNotificationKind.normal);
    sendCount++;
    return completion.future;
  }

  void complete() {
    completion.complete(
      const Success(
        TestNotificationDeliveryResult(
          message: 'テスト通知を送信しました',
          framework: TestNotificationFramework.fcm,
        ),
      ),
    );
  }
}

final class _SuccessPushNotificationRepository extends Fake
    implements PushNotificationRepository {
  final receivedKinds = <TestNotificationKind>[];

  @override
  Future<Result<TestNotificationDeliveryResult, Exception>>
  sendTestNotification({
    required String deviceId,
    required TestNotificationKind kind,
  }) async {
    expect(deviceId, 'test-device-id');
    receivedKinds.add(kind);
    return const Success(
      TestNotificationDeliveryResult(
        message: 'テスト通知を送信しました',
        framework: TestNotificationFramework.fcm,
      ),
    );
  }
}
