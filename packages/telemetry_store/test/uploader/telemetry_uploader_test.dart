import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:telemetry_store/src/database/telemetry_database.dart';
import 'package:telemetry_store/src/uploader/event_sender.dart';
import 'package:telemetry_store/src/uploader/telemetry_uploader.dart';
import 'package:test/test.dart';

class _SuccessSender extends EventSender {
  final List<List<Map<String, dynamic>>> calls = [];

  @override
  Future<bool> send(List<Map<String, dynamic>> events) async {
    calls.add(events);
    return true;
  }
}

class _FailSender extends EventSender {
  @override
  Future<bool> send(List<Map<String, dynamic>> events) async => false;
}

void main() {
  late TelemetryDatabase db;

  setUp(() {
    db = TelemetryDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> insertTestEvents(int count) async {
    await db.insertEvents([
      for (var i = 0; i < count; i++)
        TelemetryEventsCompanion.insert(
          eventType: 'test_event',
          timestampMs: 1000 + i,
          eventId: Value('eq-$i'),
          payload: '{"index":$i}',
          createdAtMs: 1000 + i,
        ),
    ]);
  }

  group('flush', () {
    test('returns zero counts when no unsynced events', () async {
      final uploader = TelemetryUploader(
        db: db,
        sender: _SuccessSender(),
      );
      final result = await uploader.flush();
      expect(result.sentCount, 0);
      expect(result.failedCount, 0);
    });

    test('sends unsynced events and marks as synced', () async {
      await insertTestEvents(3);
      final sender = _SuccessSender();
      final uploader = TelemetryUploader(db: db, sender: sender);

      final result = await uploader.flush();
      expect(result.sentCount, 3);
      expect(result.failedCount, 0);
      expect(sender.calls, hasLength(1));
      expect(sender.calls.first, hasLength(3));

      final remaining = await db.getUnsyncedEvents();
      expect(remaining, isEmpty);
    });

    test('respects batchSize', () async {
      await insertTestEvents(5);
      final sender = _SuccessSender();
      final uploader = TelemetryUploader(
        db: db,
        sender: sender,
        batchSize: 2,
      );

      final result = await uploader.flush();
      expect(result.sentCount, 2);

      final remaining = await db.getUnsyncedEvents();
      expect(remaining, hasLength(3));
    });

    test('does not mark as synced on sender failure', () async {
      await insertTestEvents(3);
      final uploader = TelemetryUploader(db: db, sender: _FailSender());

      final result = await uploader.flush();
      expect(result.sentCount, 0);
      expect(result.failedCount, 3);

      final remaining = await db.getUnsyncedEvents();
      expect(remaining, hasLength(3));
    });

    test('sends correct row data', () async {
      await db.insertEvent(
        TelemetryEventsCompanion.insert(
          eventType: 'notification_received',
          timestampMs: 2000,
          eventId: const Value('eq-test'),
          payload: '{"framework":"fcm"}',
          createdAtMs: 2000,
        ),
      );

      final sender = _SuccessSender();
      final uploader = TelemetryUploader(db: db, sender: sender);
      await uploader.flush();

      final sent = sender.calls.first.first;
      expect(sent['event_type'], 'notification_received');
      expect(sent['timestamp_ms'], 2000);
      expect(sent['event_id'], 'eq-test');
      expect(sent['payload'], '{"framework":"fcm"}');
      expect(sent['created_at_ms'], 2000);
    });
  });
}
