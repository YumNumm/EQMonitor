import 'package:drift/drift.dart';
import 'package:telemetry_store/src/database/telemetry_events_table.dart';

part 'telemetry_database.g.dart';

@DriftDatabase(tables: [TelemetryEvents])
class TelemetryDatabase extends _$TelemetryDatabase {
  new(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_telemetry_synced '
        'ON telemetry_events(synced) WHERE synced = 0',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_telemetry_event_type '
        'ON telemetry_events(event_type, timestamp_ms)',
      );
    },
  );

  Future<int> insertEvent(TelemetryEventsCompanion data) =>
      into(telemetryEvents).insert(data);

  Future<void> insertEvents(List<TelemetryEventsCompanion> data) =>
      batch((b) => b.insertAll(telemetryEvents, data));

  Future<List<TelemetryEventRow>> getUnsyncedEvents({int limit = 100}) =>
      (select(telemetryEvents)
            ..where((t) => t.synced.equals(false))
            ..orderBy([(t) => OrderingTerm.asc(t.createdAtMs)])
            ..limit(limit))
          .get();

  Future<void> markAsSynced(List<int> ids) =>
      (update(telemetryEvents)..where((t) => t.id.isIn(ids))).write(
        const TelemetryEventsCompanion(synced: Value(true)),
      );

  Future<List<TelemetryEventRow>> queryByType(
    String eventType, {
    required int sinceMs,
  }) =>
      (select(telemetryEvents)..where(
            (t) =>
                t.eventType.equals(eventType) &
                t.timestampMs.isBiggerOrEqualValue(sinceMs),
          ))
          .get();

  Future<int> deleteOldSyncedEvents({required int beforeMs}) =>
      (delete(telemetryEvents)..where(
            (t) =>
                t.synced.equals(true) &
                t.createdAtMs.isSmallerThanValue(beforeMs),
          ))
          .go();

  Future<List<TelemetryEventRow>> getAllEvents({
    int limit = 200,
    int offset = 0,
  }) =>
      (select(telemetryEvents)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAtMs)])
            ..limit(limit, offset: offset))
          .get();

  Future<int> countEvents() async {
    final count = telemetryEvents.id.count();
    final query = selectOnly(telemetryEvents)..addColumns([count]);
    final row = await query.getSingle();
    return row.read(count)!;
  }

  Future<int> deleteAllEvents() => delete(telemetryEvents).go();
}
