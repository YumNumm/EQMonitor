import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:telemetry_store/src/models/live_activity_end_reason.dart';
import 'package:telemetry_store/src/models/live_activity_type.dart';
import 'package:telemetry_store/src/models/notification_framework.dart';
import 'package:telemetry_store/src/models/user_action_type.dart';

part 'telemetry_event.freezed.dart';

@Freezed(toJson: false, fromJson: false)
sealed class TelemetryEvent with _$TelemetryEvent {
  const TelemetryEvent._();

  const factory TelemetryEvent.notificationReceived({
    required NotificationFramework framework,
    required String channelId,
    String? title,
    String? eventId,
    String? priority,
  }) = NotificationReceivedEvent;

  const factory TelemetryEvent.notificationOpened({
    required bool coldStart,
    String? eventId,
    int? elapsedMs,
  }) = NotificationOpenedEvent;

  const factory TelemetryEvent.liveActivityStarted({
    required LiveActivityType activityType,
    required String activityId,
  }) = LiveActivityStartedEvent;

  const factory TelemetryEvent.liveActivityUpdated({
    required LiveActivityType activityType,
    required String activityId,
    String? eventId,
  }) = LiveActivityUpdatedEvent;

  const factory TelemetryEvent.liveActivityEnded({
    required LiveActivityType activityType,
    required String activityId,
    required LiveActivityEndReason endReason,
    int? durationMs,
  }) = LiveActivityEndedEvent;

  const factory TelemetryEvent.error({
    required String errorType,
    required String message,
    String? stackTrace,
  }) = ErrorTelemetryEvent;

  const factory TelemetryEvent.userAction({
    required UserActionType action,
    Map<String, dynamic>? params,
  }) = UserActionEvent;

  String get eventType => switch (this) {
    NotificationReceivedEvent() => 'notification_received',
    NotificationOpenedEvent() => 'notification_opened',
    LiveActivityStartedEvent() => 'live_activity_started',
    LiveActivityUpdatedEvent() => 'live_activity_updated',
    LiveActivityEndedEvent() => 'live_activity_ended',
    ErrorTelemetryEvent() => 'error',
    UserActionEvent() => 'user_action',
  };

  String? get eventId => switch (this) {
    NotificationReceivedEvent(:final eventId) => eventId,
    NotificationOpenedEvent(:final eventId) => eventId,
    LiveActivityUpdatedEvent(:final eventId) => eventId,
    _ => null,
  };

  Map<String, dynamic> toPayload() => switch (this) {
    NotificationReceivedEvent(
      :final framework,
      :final channelId,
      :final title,
      :final priority,
    ) =>
      {
        'framework': framework.name,
        'channel_id': channelId,
        'title': ?title,
        'priority': ?priority,
      },
    NotificationOpenedEvent(:final coldStart, :final elapsedMs) => {
      'cold_start': coldStart,
      'elapsed_ms': ?elapsedMs,
    },
    LiveActivityStartedEvent(:final activityType, :final activityId) => {
      'activity_type': activityType.name,
      'activity_id': activityId,
    },
    LiveActivityUpdatedEvent(:final activityType, :final activityId) => {
      'activity_type': activityType.name,
      'activity_id': activityId,
    },
    LiveActivityEndedEvent(
      :final activityType,
      :final activityId,
      :final endReason,
      :final durationMs,
    ) =>
      {
        'activity_type': activityType.name,
        'activity_id': activityId,
        'end_reason': endReason.name,
        'duration_ms': ?durationMs,
      },
    ErrorTelemetryEvent(
      :final errorType,
      :final message,
      :final stackTrace,
    ) =>
      {
        'error_type': errorType,
        'message': message,
        'stack_trace': ?stackTrace,
      },
    UserActionEvent(:final action, :final params) => {
      'action': action.name,
      'params': ?params,
    },
  };
}
