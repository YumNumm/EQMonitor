import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

final class const DeviceNotificationWebhook({
  required final String id,
  required final DateTime createdAt,
  required final DateTime? expiresAt,
  required final bool approved,
  required final String? webhookUrl,
});

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
