import 'package:cache/src/database/http_cache_entries_table.dart';
import 'package:drift/drift.dart';

part 'http_cache_database.g.dart';

@DriftDatabase(tables: [HttpCacheEntries])
class CacheDatabase extends _$CacheDatabase {
  CacheDatabase(super.e);

  @override
  int get schemaVersion => 1;

  Future<HttpCacheEntryRow?> getEntry(String key) => (select(
    httpCacheEntries,
  )..where((t) => t.key.equals(key))).getSingleOrNull();

  Future<void> putEntry(HttpCacheEntriesCompanion data) =>
      into(httpCacheEntries).insertOnConflictUpdate(data);

  Future<void> deleteEntry(String key) =>
      (delete(httpCacheEntries)..where((t) => t.key.equals(key))).go();

  Future<void> clear() => delete(httpCacheEntries).go();

  Future<void> vacuum() => customStatement('VACUUM');
}
