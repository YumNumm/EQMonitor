import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:telemetry_store/src/database/telemetry_database.dart';
import 'package:test/test.dart';

void main() {
  late TelemetryDatabase db;

  setUp(() {
    db = TelemetryDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  TelemetryEventsCompanion makeEvent({
    String eventType = 'notification_received',
    int timestampMs = 1000,
    String? eventId,
    String payload = '{}',
    bool synced = false,
    int createdAtMs = 1000,
  }) =>
      TelemetryEventsCompanion.insert(
        eventType: eventType,
        timestampMs: timestampMs,
        eventId: Value(eventId),
        payload: payload,
        createdAtMs: createdAtMs,
      );

  group('insertEvent', () {
    test('inserts and returns generated id', () async {
      final id = await db.insertEvent(makeEvent());
      expect(id, greaterThan(0));
    });

    test('inserts multiple events with unique ids', () async {
      final id1 = await db.insertEvent(makeEvent());
      final id2 = await db.insertEvent(makeEvent());
      expect(id1, isNot(id2));
    });
  });

  group('insertEvents', () {
    test('inserts batch of events', () async {
      await db.insertEvents([
        makeEvent(eventType: 'a'),
        makeEvent(eventType: 'b'),
        makeEvent(eventType: 'c'),
      ]);
      final all = await db.getUnsyncedEvents();
      expect(all, hasLength(3));
    });
  });

  group('getUnsyncedEvents', () {
    test('returns only unsynced events ordered by createdAtMs', () async {
      await db.insertEvent(
        makeEvent(createdAtMs: 3000, eventType: 'third'),
      );
      await db.insertEvent(
        makeEvent(eventType: 'first'),
      );
      await db.insertEvent(
        makeEvent(createdAtMs: 2000, eventType: 'second'),
      );

      final result = await db.getUnsyncedEvents();
      expect(result.map((r) => r.eventType), ['first', 'second', 'third']);
    });

    test('respects limit', () async {
      await db.insertEvents([
        makeEvent(),
        makeEvent(),
        makeEvent(),
      ]);
      final result = await db.getUnsyncedEvents(limit: 2);
      expect(result, hasLength(2));
    });

    test('excludes synced events', () async {
      final id = await db.insertEvent(makeEvent());
      await db.markAsSynced([id]);
      final result = await db.getUnsyncedEvents();
      expect(result, isEmpty);
    });
  });

  group('markAsSynced', () {
    test('marks specified events as synced', () async {
      final id1 = await db.insertEvent(makeEvent());
      final id2 = await db.insertEvent(makeEvent());
      await db.markAsSynced([id1]);

      final unsynced = await db.getUnsyncedEvents();
      expect(unsynced, hasLength(1));
      expect(unsynced.first.id, id2);
    });
  });

  group('queryByType', () {
    test('filters by event type and time range', () async {
      await db.insertEvent(
        makeEvent(timestampMs: 500),
      );
      await db.insertEvent(
        makeEvent(timestampMs: 1500),
      );
      await db.insertEvent(
        makeEvent(eventType: 'error', timestampMs: 1500),
      );

      final result = await db.queryByType(
        'notification_received',
        sinceMs: 1000,
      );
      expect(result, hasLength(1));
      expect(result.first.timestampMs, 1500);
    });
  });

  group('deleteOldSyncedEvents', () {
    test('deletes synced events older than threshold', () async {
      final id1 = await db.insertEvent(
        makeEvent(createdAtMs: 500),
      );
      await db.insertEvent(makeEvent(createdAtMs: 1500));
      await db.markAsSynced([id1]);

      final deleted = await db.deleteOldSyncedEvents(beforeMs: 1000);
      expect(deleted, 1);
    });

    test('does not delete unsynced events', () async {
      await db.insertEvent(makeEvent(createdAtMs: 500));
      final deleted = await db.deleteOldSyncedEvents(beforeMs: 1000);
      expect(deleted, 0);
    });
  });
}
