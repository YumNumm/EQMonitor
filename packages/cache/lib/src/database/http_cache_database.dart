import 'package:cache/src/database/http_cache_entries_table.dart';
import 'package:drift/drift.dart';

part 'http_cache_database.g.dart';

@DriftDatabase(tables: [HttpCacheEntries])
class CacheDatabase extends _$CacheDatabase {
  new(super.e);

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

  Future<
    List<
      ({
        String key,
        int statusCode,
        String? eTag,
        String headers,
        String responseType,
        int updatedAtMs,
        int bodySizeBytes,
      })
    >
  >
  listEntrySummaries() {
    return customSelect(
      'SELECT key, status_code, e_tag, headers, response_type, '
      'updated_at_ms, length(body) AS body_size_bytes '
      'FROM http_cache_entries '
      'ORDER BY updated_at_ms DESC',
      readsFrom: {httpCacheEntries},
    ).map((row) {
      return (
        key: row.read<String>('key'),
        statusCode: row.read<int>('status_code'),
        eTag: row.readNullable<String>('e_tag'),
        headers: row.read<String>('headers'),
        responseType: row.read<String>('response_type'),
        updatedAtMs: row.read<int>('updated_at_ms'),
        bodySizeBytes: row.read<int>('body_size_bytes'),
      );
    }).get();
  }
}
