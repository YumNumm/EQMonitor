import 'package:eqmonitor/feature/notification/data/logic/notification_delivery_log_detail_builder.dart';
import 'package:eqmonitor/feature/notification/data/model/push_notification_log.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationDeliveryLogDetailBuilder', () {
    test('成功ログは一般ユーザー向け項目だけを生成する', () {
      final detail = NotificationDeliveryLogDetailBuilder().build(
        entry: createLogEntry(),
      );

      expect(
        detail.rows.map((row) => (label: row.label, value: row.value)).toList(),
        [
          (label: '配信日時', value: '2026/08/16 12:34:56'),
          (label: '配信結果', value: '成功'),
          (label: 'タイトル', value: '地震情報'),
          (label: '本文', value: '最大震度3を観測しました'),
        ],
      );
      expect(detail.copyText, contains('配信結果: 成功'));
      expect(detail.copyText, isNot(contains('internal-device-id')));
      expect(detail.copyText, isNot(contains('internal-stream-id')));
      expect(detail.copyText, isNot(contains('internal-event-id')));
      expect(detail.copyText, isNot(contains('FCM')));
    });

    test('失敗ログは空でないエラー内容を追加する', () {
      final detail = NotificationDeliveryLogDetailBuilder().build(
        entry: createLogEntry(
          result: PushNotificationDeliveryResult.ng,
          errorMessage: '通知を配信できませんでした',
        ),
      );

      expect(detail.rows[1].value, '失敗');
      expect(
        detail.rows.last,
        isA<NotificationDeliveryLogDetailRow>()
            .having((row) => row.label, 'label', 'エラー内容')
            .having((row) => row.value, 'value', '通知を配信できませんでした'),
      );
    });

    test('成功ログではエラー内容を表示せず空白だけの通知内容を除外する', () {
      final detail = NotificationDeliveryLogDetailBuilder().build(
        entry: createLogEntry(title: ' ', body: '\n', errorMessage: '内部エラー'),
      );

      expect(detail.rows.map((row) => row.label), ['配信日時', '配信結果']);
      expect(detail.copyText, isNot(contains('内部エラー')));
    });

    test('失敗ログでは空白だけのエラー内容を除外する', () {
      final detail = NotificationDeliveryLogDetailBuilder().build(
        entry: createLogEntry(
          result: PushNotificationDeliveryResult.ng,
          title: null,
          body: null,
          errorMessage: '  ',
        ),
      );

      expect(detail.rows.map((row) => row.label), ['配信日時', '配信結果']);
    });

    test('解釈できない配信日時は元の文字列を保持する', () {
      final detail = NotificationDeliveryLogDetailBuilder().build(
        entry: createLogEntry(createdAtIso: 'unknown-time'),
      );

      expect(detail.rows.first.value, 'unknown-time');
    });
  });
}

PushNotificationLogEntry createLogEntry({
  PushNotificationDeliveryResult result = PushNotificationDeliveryResult.ok,
  String createdAtIso = '2026-08-16T12:34:56',
  String? title = '地震情報',
  String? body = '最大震度3を観測しました',
  String? errorMessage,
}) => PushNotificationLogEntry(
  streamId: 'internal-stream-id',
  deviceId: 'internal-device-id',
  framework: PushNotificationDeliveryFramework.fcm,
  result: result,
  createdAtIso: createdAtIso,
  errorCode: 'internal-error-code',
  errorMessage: errorMessage,
  eventId: 'internal-event-id',
  title: title,
  body: body,
  androidPriority: 'internal-android-priority',
  androidNotificationPriority: 'internal-notification-priority',
  channelId: 'internal-channel-id',
  apnsPriority: 'internal-apns-priority',
  interruptionLevel: 'internal-interruption-level',
);
