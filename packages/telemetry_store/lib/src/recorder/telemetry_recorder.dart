import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:telemetry_store/src/database/telemetry_database.dart';
import 'package:telemetry_store/src/models/telemetry_event.dart';

class TelemetryRecorder {
  new({required TelemetryDatabase db}) : _db = db;

  new disabled() : _db = null;

  final TelemetryDatabase? _db;

  bool get isEnabled => _db != null;

  Future<void> record(TelemetryEvent event) async {
    final db = _db;
    if (db == null) {
      return;
    }
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insertEvent(
      TelemetryEventsCompanion.insert(
        eventType: event.eventType,
        timestampMs: now,
        eventId: Value(event.eventId),
        payload: jsonEncode(event.toPayload()),
        createdAtMs: now,
      ),
    );
  }

  Future<void> recordAll(List<TelemetryEvent> events) async {
    final db = _db;
    if (db == null) {
      return;
    }
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insertEvents([
      for (final event in events)
        TelemetryEventsCompanion.insert(
          eventType: event.eventType,
          timestampMs: now,
          eventId: Value(event.eventId),
          payload: jsonEncode(event.toPayload()),
          createdAtMs: now,
        ),
    ]);
  }
}
