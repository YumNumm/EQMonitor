import 'dart:async';

import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery_result.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:eqmonitor/feature/notification/ui/page/test_notification_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/test_notification_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('タップするとテスト通知ページに6種類を表示する', (tester) async {
    final repository = _PendingPushNotificationRepository();

    await tester.pumpWidget(_TestNotificationApp(repository: repository));

    await tester.tap(find.text('テスト通知を送信'));
    await tester.pumpAndSettle();

    expect(find.byType(TestNotificationPage), findsOneWidget);
    for (final label in [
      '震度速報',
      '震度速報＋震源に関する情報',
      '震度・震源情報',
      '長周期地震動に関する観測情報',
      '緊急地震速報（予報）',
      '緊急地震速報（警報）',
    ]) {
      expect(find.text(label), findsOneWidget);
    }
  });

  testWidgets('送信完了まで各ボタンを無効化して重複送信を防ぐ', (tester) async {
    final repository = _PendingPushNotificationRepository();

    await tester.pumpWidget(_TestNotificationApp(repository: repository));

    await tester.tap(find.text('テスト通知を送信'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('震度速報'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(TestNotificationPage), findsOneWidget);
    expect(find.byType(M3ECircularProgressIndicator), findsOneWidget);
    expect(repository.sendCount, 1);

    await tester.tap(find.text('緊急地震速報（予報）'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(TestNotificationPage), findsOneWidget);
    expect(repository.sendCount, 1);

    repository.complete();
    await tester.pumpAndSettle();

    expect(find.byType(M3ECircularProgressIndicator), findsNothing);
  });

  testWidgets('震度速報を送信してもテスト画面を維持する', (tester) async {
    final repository = _SuccessPushNotificationRepository();

    await tester.pumpWidget(_TestNotificationApp(repository: repository));

    await tester.tap(find.text('テスト通知を送信'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('震度速報'));
    await tester.pumpAndSettle();

    expect(find.byType(TestNotificationPage), findsOneWidget);
    expect(repository.receivedKinds, [TestNotificationKind.shindoReport]);
  });

  testWidgets('警報をキャンセルすると送信しない', (tester) async {
    final repository = _SuccessPushNotificationRepository();

    await tester.pumpWidget(_TestNotificationApp(repository: repository));

    await tester.tap(find.text('テスト通知を送信'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('緊急地震速報（警報）'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('キャンセル'));
    await tester.pumpAndSettle();

    expect(find.byType(TestNotificationPage), findsOneWidget);
    expect(repository.receivedKinds, isEmpty);
  });

  testWidgets('警報を確認すると送信する', (tester) async {
    final repository = _SuccessPushNotificationRepository();

    await tester.pumpWidget(_TestNotificationApp(repository: repository));

    await tester.tap(find.text('テスト通知を送信'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('緊急地震速報（警報）'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('送信する'));
    await tester.pumpAndSettle();

    expect(find.byType(TestNotificationPage), findsOneWidget);
    expect(repository.receivedKinds, [TestNotificationKind.eewWarning]);
  });
}

class _TestNotificationApp extends StatelessWidget {
  const new({required this.repository});

  final PushNotificationRepository repository;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: <ThemeExtension<dynamic>>[
        DesignSystemThemeExtension.light(),
      ],
    );

    return ProviderScope(
      overrides: [
        deviceIdProvider.overrideWith((ref) async => 'test-device-id'),
        pushNotificationRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
      ],
      child: MaterialApp.router(
        theme: theme,
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (_, _) => const Scaffold(body: TestNotificationTile()),
            ),
            GoRoute(
              path: '/settings/notification/test',
              builder: (_, _) => const TestNotificationPage(),
            ),
          ],
        ),
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
    expect(kind, TestNotificationKind.shindoReport);
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
