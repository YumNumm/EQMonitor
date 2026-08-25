import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

final class DeviceNotificationWebhook {
  const new({
    required this.id,
    required this.createdAt,
    required this.expiresAt,
    required this.approved,
    required this.webhookUrl,
  });

  final String id;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final bool approved;
  final String? webhookUrl;
}

extension DeviceNotificationWebhookConverter
    on api.DeviceNotificationWebhookResponse {
  DeviceNotificationWebhook toModel() => DeviceNotificationWebhook(
    id: id,
    createdAt: createdAt,
    expiresAt: expiresAt,
    approved: approved,
    webhookUrl: webhookUrl,
  );
}
