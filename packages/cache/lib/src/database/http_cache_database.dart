import 'package:cache/src/database/http_cache_entries_table.dart';
import 'package:drift/drift.dart';

part 'http_cache_database.g.dart';

@DriftDatabase(tables: [HttpCacheEntries])
class CacheDatabase extends _$CacheDatabase {
  CacheDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
