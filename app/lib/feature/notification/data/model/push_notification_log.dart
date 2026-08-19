import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_notification_log.freezed.dart';
part 'push_notification_log.g.dart';

@freezed
abstract class PushNotificationHistory with _$PushNotificationHistory {
  const factory({
    required List<PushNotificationLogEntry> items,
    String? nextCursor,
  }) = _PushNotificationHistory;

  factory fromJson(Map<String, dynamic> json) =>
      _$PushNotificationHistoryFromJson(json);
}

@freezed
abstract class PushNotificationLogEntry with _$PushNotificationLogEntry {
  const factory({
    required String streamId,
    required String deviceId,
    required PushNotificationDeliveryFramework framework,
    required PushNotificationDeliveryResult result,
    required String createdAtIso,
    String? errorCode,
    String? errorMessage,
    String? eventId,
    String? title,
    String? body,
    String? androidPriority,
    String? androidNotificationPriority,
    String? channelId,
    String? apnsPriority,
    String? interruptionLevel,
  }) = _PushNotificationLogEntry;

  factory fromJson(Map<String, dynamic> json) =>
      _$PushNotificationLogEntryFromJson(json);
}

enum PushNotificationDeliveryFramework { fcm, apns }

enum PushNotificationDeliveryResult { ok, ng }

extension PushNotificationDeliveryFrameworkDisplay
    on PushNotificationDeliveryFramework {
  String get displayLabel => switch (this) {
    .fcm => 'FCM',
    .apns => 'APNs',
  };
}

extension PushNotificationDeliveryResultDisplay
    on PushNotificationDeliveryResult {
  String get displayLabel => switch (this) {
    .ok => 'OK',
    .ng => 'NG',
  };
}

extension NotificationHistoryResponseApiExtension
    on api.NotificationHistoryResponse {
  PushNotificationHistory get toPushNotificationHistory =>
      PushNotificationHistory(
        items: items.map((e) => e.toPushNotificationLogEntry).toList(),
        nextCursor: nextCursor,
      );
}

extension NotificationLogItemApiExtension on api.NotificationLogItem {
  PushNotificationLogEntry get toPushNotificationLogEntry =>
      PushNotificationLogEntry(
        streamId: streamId,
        deviceId: deviceId,
        framework: switch (framework) {
          .fcm => .fcm,
          .apns => .apns,
        },
        result: switch (result) {
          .ok => .ok,
          .ng => .ng,
        },
        createdAtIso: createdAt,
        errorCode: errorCode,
        errorMessage: errorMessage,
        eventId: eventId,
        title: title,
        body: body,
        androidPriority: androidPriority,
        androidNotificationPriority: androidNotificationPriority,
        channelId: channelId,
        apnsPriority: apnsPriority,
        interruptionLevel: interruptionLevel,
      );
}
