import 'package:drift/drift.dart';

@DataClassName('HttpCacheEntryRow')
class HttpCacheEntries extends Table {
  TextColumn get key => text()();
  IntColumn get statusCode => integer()();
  TextColumn get eTag => text().nullable()();
  TextColumn get headers => text()();
  TextColumn get responseType => text()();
  BlobColumn get body => blob()();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {key};
}
