import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/notification/data/action/test_notification_send_action.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery_result.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('通常通知は確認なしで送信し、成功を表示する', (tester) async {
    final repository = _FakePushNotificationRepository();
    bool? handled;

    await tester.pumpWidget(
      _TestApp(
        repository: repository,
        kind: TestNotificationKind.normal,
        onHandled: (value) => handled = value,
      ),
    );

    await tester.tap(find.text('通常'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(repository.receivedKinds, [TestNotificationKind.normal]);
    expect(handled, isTrue);
    expect(find.text('送信しました（FCM）: テスト通知を送信しました'), findsOneWidget);
  });

  testWidgets('重大通知は警告を表示し、キャンセルすると送信しない', (tester) async {
    final repository = _FakePushNotificationRepository();
    bool? handled;
    var confirmedCount = 0;

    await tester.pumpWidget(
      _TestApp(
        repository: repository,
        kind: TestNotificationKind.critical,
        onHandled: (value) => handled = value,
        onConfirmed: () => confirmedCount++,
      ),
    );

    await tester.tap(find.text('重大な通知'));
    await tester.pump();

    expect(repository.receivedKinds, isEmpty);
    expect(find.text('重大な通知を送信しますか？'), findsOneWidget);
    expect(find.textContaining('マナーモードの設定に関わらず音が鳴ります'), findsOneWidget);

    await tester.tap(find.text('キャンセル'));
    await tester.pumpAndSettle();

    expect(repository.receivedKinds, isEmpty);
    expect(confirmedCount, 0);
    expect(handled, isFalse);
  });

  testWidgets('重大通知は確認後にcallbackを実行して送信する', (tester) async {
    final repository = _FakePushNotificationRepository();
    bool? handled;
    var confirmedCount = 0;

    await tester.pumpWidget(
      _TestApp(
        repository: repository,
        kind: TestNotificationKind.critical,
        onHandled: (value) => handled = value,
        onConfirmed: () {
          expect(repository.receivedKinds, isEmpty);
          confirmedCount++;
        },
      ),
    );

    await tester.tap(find.text('重大な通知'));
    await tester.pump();
    expect(repository.receivedKinds, isEmpty);

    await tester.tap(find.text('送信する'));
    await tester.pumpAndSettle();

    expect(confirmedCount, 1);
    expect(repository.receivedKinds, [TestNotificationKind.critical]);
    expect(handled, isTrue);
  });

  testWidgets('RepositoryがFailureを返すと失敗SnackBarを表示する', (tester) async {
    await tester.pumpWidget(
      _TestApp(
        repository: _FailurePushNotificationRepository(),
        kind: TestNotificationKind.normal,
        onHandled: (_) {},
      ),
    );

    await tester.tap(find.text('通常'));
    await tester.pumpAndSettle();

    expect(find.text('送信に失敗しました: Exception: result failure'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Repositoryが例外をthrowすると失敗SnackBarを表示する', (tester) async {
    await tester.pumpWidget(
      _TestApp(
        repository: _ThrowingPushNotificationRepository(),
        kind: TestNotificationKind.normal,
        onHandled: (_) {},
      ),
    );

    await tester.tap(find.text('通常'));
    await tester.pumpAndSettle();

    expect(find.text('送信に失敗しました: Exception: thrown failure'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _TestApp extends StatelessWidget {
  const new({
    required this.repository,
    required this.kind,
    required this.onHandled,
    this.onConfirmed,
  });

  final PushNotificationRepository repository;
  final TestNotificationKind kind;
  final ValueChanged<bool> onHandled;
  final VoidCallback? onConfirmed;

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
      child: MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Consumer(
            builder: (context, ref, child) => FilledButton(
              onPressed: () async {
                final handled = await ref
                    .read(testNotificationSendActionProvider)
                    .handle(
                      ref: ref,
                      context: context,
                      kind: kind,
                      onConfirmed: onConfirmed,
                    );
                onHandled(handled);
              },
              child: Text(kind.displayLabel),
            ),
          ),
        ),
      ),
    );
  }
}

final class _FailurePushNotificationRepository extends Fake
    implements PushNotificationRepository {
  @override
  Future<Result<TestNotificationDeliveryResult, Exception>>
  sendTestNotification({
    required String deviceId,
    required TestNotificationKind kind,
  }) async {
    return Failure(Exception('result failure'));
  }
}

final class _ThrowingPushNotificationRepository extends Fake
    implements PushNotificationRepository {
  @override
  Future<Result<TestNotificationDeliveryResult, Exception>>
  sendTestNotification({
    required String deviceId,
    required TestNotificationKind kind,
  }) async {
    throw Exception('thrown failure');
  }
}

final class _FakePushNotificationRepository extends Fake
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
