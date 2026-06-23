import 'package:drift/drift.dart';

@DataClassName('TelemetryEventRow')
class TelemetryEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get eventType => text()();
  IntColumn get timestampMs => integer()();
  TextColumn get eventId => text().nullable()();
  TextColumn get payload => text()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  IntColumn get createdAtMs => integer()();
}
