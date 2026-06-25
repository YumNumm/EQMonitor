import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/src/database/http_cache_database.dart';
import 'package:cache/src/http/http_cache_entry.dart';
import 'package:cache/src/http/http_cache_key.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

class HttpCacheStore {
  HttpCacheStore({
    required this.db,
    required this.schemaVersion,
    required this.appBuild,
  });

  final CacheDatabase db;
  final int schemaVersion;
  final String appBuild;

  Future<HttpCacheEntry?> read(String key) async {
    final row = await db.getEntry(key);
    if (row == null) {
      return null;
    }
    final decoded = (jsonDecode(row.headers) as Map<String, dynamic>).map(
      (k, v) => MapEntry(k, (v as List).cast<String>()),
    );
    return HttpCacheEntry(
      key: row.key,
      statusCode: row.statusCode,
      eTag: row.eTag,
      headers: decoded,
      responseType: row.responseType,
      body: Uint8List.fromList(row.body),
      updatedAtMs: row.updatedAtMs,
    );
  }

  Future<void> write(HttpCacheEntry entry) => db.putEntry(
    HttpCacheEntriesCompanion.insert(
      key: entry.key,
      statusCode: entry.statusCode,
      eTag: Value(entry.eTag),
      headers: jsonEncode(entry.headers),
      responseType: entry.responseType,
      body: entry.body,
      updatedAtMs: entry.updatedAtMs,
    ),
  );

  Future<void> evict(String key) => db.deleteEntry(key);

  Future<void> clearAll() => db.clear();

  String primaryKeyForUrl(RequestOptions options) => buildHttpCacheKey(
    schemaVersion: schemaVersion,
    appBuild: appBuild,
    url: options.uri,
  );
}
