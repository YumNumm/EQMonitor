import 'package:telemetry_store/src/models/live_activity_end_reason.dart';
import 'package:telemetry_store/src/models/live_activity_type.dart';
import 'package:telemetry_store/src/models/notification_framework.dart';
import 'package:telemetry_store/src/models/telemetry_event.dart';
import 'package:telemetry_store/src/models/user_action_type.dart';
import 'package:test/test.dart';

void main() {
  group('TelemetryEvent.eventType', () {
    test('notificationReceived', () {
      const event = TelemetryEvent.notificationReceived(
        framework: NotificationFramework.fcm,
        channelId: 'eew_warning',
      );
      expect(event.eventType, 'notification_received');
    });

    test('notificationOpened', () {
      const event = TelemetryEvent.notificationOpened(coldStart: true);
      expect(event.eventType, 'notification_opened');
    });

    test('liveActivityStarted', () {
      const event = TelemetryEvent.liveActivityStarted(
        activityType: LiveActivityType.eew,
        activityId: 'la-1',
      );
      expect(event.eventType, 'live_activity_started');
    });

    test('liveActivityUpdated', () {
      const event = TelemetryEvent.liveActivityUpdated(
        activityType: LiveActivityType.eew,
        activityId: 'la-1',
      );
      expect(event.eventType, 'live_activity_updated');
    });

    test('liveActivityEnded', () {
      const event = TelemetryEvent.liveActivityEnded(
        activityType: LiveActivityType.eew,
        activityId: 'la-1',
        endReason: LiveActivityEndReason.completed,
      );
      expect(event.eventType, 'live_activity_ended');
    });

    test('error', () {
      const event = TelemetryEvent.error(
        errorType: 'token_sync_failed',
        message: 'timeout',
      );
      expect(event.eventType, 'error');
    });

    test('userAction', () {
      const event = TelemetryEvent.userAction(
        action: UserActionType.screenView,
      );
      expect(event.eventType, 'user_action');
    });
  });

  group('TelemetryEvent.eventId', () {
    test('notificationReceived with eventId', () {
      const event = TelemetryEvent.notificationReceived(
        framework: NotificationFramework.fcm,
        channelId: 'eew_warning',
        eventId: 'eq-123',
      );
      expect(event.eventId, 'eq-123');
    });

    test('notificationReceived without eventId', () {
      const event = TelemetryEvent.notificationReceived(
        framework: NotificationFramework.fcm,
        channelId: 'eew_warning',
      );
      expect(event.eventId, isNull);
    });

    test('userAction has no eventId', () {
      const event = TelemetryEvent.userAction(
        action: UserActionType.screenView,
      );
      expect(event.eventId, isNull);
    });

    test('liveActivityUpdated with eventId', () {
      const event = TelemetryEvent.liveActivityUpdated(
        activityType: LiveActivityType.eew,
        activityId: 'la-1',
        eventId: 'eew-456',
      );
      expect(event.eventId, 'eew-456');
    });
  });

  group('TelemetryEvent.toPayload', () {
    test('notificationReceived with all fields', () {
      const event = TelemetryEvent.notificationReceived(
        framework: NotificationFramework.fcm,
        channelId: 'eew_warning',
        title: 'EEW Alert',
        eventId: 'eq-123',
        priority: 'high',
      );
      expect(event.toPayload(), {
        'framework': 'fcm',
        'channel_id': 'eew_warning',
        'title': 'EEW Alert',
        'priority': 'high',
      });
    });

    test('notificationReceived omits null fields', () {
      const event = TelemetryEvent.notificationReceived(
        framework: NotificationFramework.apns,
        channelId: 'VXSE53',
      );
      expect(event.toPayload(), {
        'framework': 'apns',
        'channel_id': 'VXSE53',
      });
    });

    test('notificationOpened', () {
      const event = TelemetryEvent.notificationOpened(
        coldStart: true,
        eventId: 'eq-123',
        elapsedMs: 1200,
      );
      expect(event.toPayload(), {
        'cold_start': true,
        'elapsed_ms': 1200,
      });
    });

    test('liveActivityStarted', () {
      const event = TelemetryEvent.liveActivityStarted(
        activityType: LiveActivityType.eew,
        activityId: 'la-1',
      );
      expect(event.toPayload(), {
        'activity_type': 'eew',
        'activity_id': 'la-1',
      });
    });

    test('liveActivityEnded with duration', () {
      const event = TelemetryEvent.liveActivityEnded(
        activityType: LiveActivityType.shakeDetection,
        activityId: 'la-2',
        endReason: LiveActivityEndReason.timeout,
        durationMs: 45000,
      );
      expect(event.toPayload(), {
        'activity_type': 'shakeDetection',
        'activity_id': 'la-2',
        'end_reason': 'timeout',
        'duration_ms': 45000,
      });
    });

    test('error with stackTrace', () {
      const event = TelemetryEvent.error(
        errorType: 'token_sync_failed',
        message: 'Connection refused',
        stackTrace: '#0 main (test.dart:1)',
      );
      expect(event.toPayload(), {
        'error_type': 'token_sync_failed',
        'message': 'Connection refused',
        'stack_trace': '#0 main (test.dart:1)',
      });
    });

    test('userAction with params', () {
      const event = TelemetryEvent.userAction(
        action: UserActionType.screenView,
        params: {'screen': 'earthquake_detail', 'id': '123'},
      );
      expect(event.toPayload(), {
        'action': 'screenView',
        'params': {'screen': 'earthquake_detail', 'id': '123'},
      });
    });
  });
}
