import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/notification/data/model/push_notification_log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_delivery_log_detail_builder.g.dart';

@riverpod
NotificationDeliveryLogDetailBuilder notificationDeliveryLogDetailBuilder(
  Ref ref,
) => NotificationDeliveryLogDetailBuilder();

final class const NotificationDeliveryLogDetail({
  required final List<NotificationDeliveryLogDetailRow> rows,
}) {
  String get copyText =>
      rows.map((row) => '${row.label}: ${row.value}').join('\n');
}

final class const NotificationDeliveryLogDetailRow({
  required final String label,
  required final String value,
});

final class NotificationDeliveryLogDetailBuilder {
  NotificationDeliveryLogDetail build({
    required PushNotificationLogEntry entry,
  }) {
    final parsedCreatedAt = DateTime.tryParse(entry.createdAtIso);
    final formattedCreatedAt = parsedCreatedAt == null
        ? entry.createdAtIso
        : parsedCreatedAt.formatWithTz(
            .yearMonthDayHourMinuteSecondMillisecond,
          );
    final title = entry.title;
    final body = entry.body;

    return NotificationDeliveryLogDetail(
      rows: [
        NotificationDeliveryLogDetailRow(
          label: '配信日時',
          value: formattedCreatedAt,
        ),
        if (entry.result == .ng)
          NotificationDeliveryLogDetailRow(label: '配信結果', value: "配信失敗"),

        if (title != null && title.trim().isNotEmpty)
          NotificationDeliveryLogDetailRow(label: 'タイトル', value: title),
        if (body != null && body.trim().isNotEmpty)
          NotificationDeliveryLogDetailRow(label: '本文', value: body),
      ],
    );
  }
}
