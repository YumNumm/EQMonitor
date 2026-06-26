import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:telemetry_store/src/database/telemetry_database.dart';
import 'package:telemetry_store/src/models/telemetry_event.dart';

class TelemetryRecorder {
  TelemetryRecorder(this._db);

  final TelemetryDatabase _db;

  Future<void> record(TelemetryEvent event) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.insertEvent(
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
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.insertEvents([
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
