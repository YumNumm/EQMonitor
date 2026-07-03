import 'package:drift/native.dart';
import 'package:telemetry_store/src/database/telemetry_database.dart';
import 'package:telemetry_store/src/models/live_activity_type.dart';
import 'package:telemetry_store/src/models/notification_framework.dart';
import 'package:telemetry_store/src/models/telemetry_event.dart';
import 'package:telemetry_store/src/recorder/telemetry_recorder.dart';
import 'package:test/test.dart';

void main() {
  late TelemetryDatabase db;
  late TelemetryRecorder recorder;

  setUp(() {
    db = TelemetryDatabase(NativeDatabase.memory());
    recorder = TelemetryRecorder(db: db);
  });

  tearDown(() async {
    await db.close();
  });

  group('record', () {
    test('inserts notificationReceived event', () async {
      await recorder.record(
        const TelemetryEvent.notificationReceived(
          framework: NotificationFramework.fcm,
          channelId: 'eew_warning',
          eventId: 'eq-123',
          title: 'Alert',
          priority: 'high',
        ),
      );

      final rows = await db.getUnsyncedEvents();
      expect(rows, hasLength(1));

      final row = rows.first;
      expect(row.eventType, 'notification_received');
      expect(row.eventId, 'eq-123');
      expect(row.synced, false);
      expect(row.payload, contains('"framework":"fcm"'));
      expect(row.payload, contains('"channel_id":"eew_warning"'));
    });

    test('inserts liveActivityStarted event with null eventId', () async {
      await recorder.record(
        const TelemetryEvent.liveActivityStarted(
          activityType: LiveActivityType.eew,
          activityId: 'la-1',
        ),
      );

      final rows = await db.getUnsyncedEvents();
      expect(rows, hasLength(1));
      expect(rows.first.eventId, isNull);
      expect(rows.first.eventType, 'live_activity_started');
    });
  });

  group('recordAll', () {
    test('inserts multiple events', () async {
      await recorder.recordAll([
        const TelemetryEvent.notificationReceived(
          framework: NotificationFramework.fcm,
          channelId: 'ch1',
        ),
        const TelemetryEvent.notificationOpened(coldStart: false),
      ]);

      final rows = await db.getUnsyncedEvents();
      expect(rows, hasLength(2));
    });
  });
}
