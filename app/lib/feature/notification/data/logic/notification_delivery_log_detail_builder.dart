import 'package:eqmonitor/feature/notification/data/model/push_notification_log.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_delivery_log_detail_builder.g.dart';

@riverpod
NotificationDeliveryLogDetailBuilder notificationDeliveryLogDetailBuilder(
  Ref ref,
) => NotificationDeliveryLogDetailBuilder();

final class NotificationDeliveryLogDetail {
  const new({required this.rows});

  final List<NotificationDeliveryLogDetailRow> rows;

  String get copyText =>
      rows.map((row) => '${row.label}: ${row.value}').join('\n');
}

final class NotificationDeliveryLogDetailRow {
  const new({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
}

final class NotificationDeliveryLogDetailBuilder {
  NotificationDeliveryLogDetail build({
    required PushNotificationLogEntry entry,
  }) {
    final parsedCreatedAt = DateTime.tryParse(entry.createdAtIso);
    final formattedCreatedAt = parsedCreatedAt == null
        ? entry.createdAtIso
        : DateFormat('yyyy/MM/dd HH:mm:ss').format(parsedCreatedAt.toLocal());
    final title = entry.title;
    final body = entry.body;
    final errorMessage = entry.errorMessage;

    return NotificationDeliveryLogDetail(
      rows: [
        NotificationDeliveryLogDetailRow(
          label: '配信日時',
          value: formattedCreatedAt,
        ),
        NotificationDeliveryLogDetailRow(
          label: '配信結果',
          value: switch (entry.result) {
            PushNotificationDeliveryResult.ok => '成功',
            PushNotificationDeliveryResult.ng => '失敗',
          },
        ),
        if (title != null && title.trim().isNotEmpty)
          NotificationDeliveryLogDetailRow(label: 'タイトル', value: title),
        if (body != null && body.trim().isNotEmpty)
          NotificationDeliveryLogDetailRow(label: '本文', value: body),
        if (entry.result == PushNotificationDeliveryResult.ng &&
            errorMessage != null &&
            errorMessage.trim().isNotEmpty)
          NotificationDeliveryLogDetailRow(label: 'エラー内容', value: errorMessage),
      ],
    );
  }
}
