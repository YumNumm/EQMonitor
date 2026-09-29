import 'dart:convert';

import 'package:cache/src/database/http_cache_database.dart';
import 'package:cache/src/http/http_cache_entry.dart';
import 'package:cache/src/http/http_cache_entry_summary.dart';
import 'package:cache/src/http/http_cache_key.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

/// HTTP キャッシュに保持する body の合計サイズ上限 (バイト)。
const kHttpCacheMaxTotalBodyBytes = 5 * 1024 * 1024;

class HttpCacheStore {
  new({
    required this.db,
    required this.schemaVersion,
    required this.appBuild,
    this.maxTotalBodyBytes = kHttpCacheMaxTotalBodyBytes,
  });

  final CacheDatabase db;
  final int schemaVersion;
  final String appBuild;

  /// body の合計がこの値を超えたら、最近使われていない順に削除する。
  final int maxTotalBodyBytes;

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

  /// エントリを保存し、合計サイズの上限を超えた分を LRU で削除する。
  ///
  /// body 単体で上限を超えるエントリは、他のエントリをすべて押し出してしまうため
  /// 保存しない (同じキーの古いエントリは削除する)。
  Future<void> write(HttpCacheEntry entry) async {
    if (entry.body.length > maxTotalBodyBytes) {
      await evict(entry.key);
      return;
    }
    await db.putEntry(
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
    await enforceSizeLimit();
  }

  /// キャッシュを利用した (304 で再検証できた) 時刻を記録する。
  Future<void> touch({required String key, required int updatedAtMs}) =>
      db.touchEntry(key: key, updatedAtMs: updatedAtMs);

  /// 最近使われた順に body サイズを積算し、上限を超えた以降のエントリを削除する。
  /// updated_at_ms が 0 (LRU 導入前の保存分) のエントリは最も古いものとして扱われる。
  Future<void> enforceSizeLimit() async {
    final entries = await db.listEntrySizesByRecency();
    var total = 0;
    final overflowKeys = <String>[];
    for (final entry in entries) {
      total += entry.bodySizeBytes;
      if (total > maxTotalBodyBytes) {
        overflowKeys.add(entry.key);
      }
    }
    if (overflowKeys.isNotEmpty) {
      await db.deleteEntries(overflowKeys);
    }
  }

  Future<void> evict(String key) => db.deleteEntry(key);

  Future<void> clearAll() => db.clear();

  Future<void> vacuum() => db.vacuum();

  Future<List<HttpCacheEntrySummary>> listSummaries() async {
    final rows = await db.listEntrySummaries();
    return [
      for (final row in rows)
        HttpCacheEntrySummary(
          key: row.key,
          statusCode: row.statusCode,
          eTag: row.eTag,
          headers: (jsonDecode(row.headers) as Map<String, dynamic>).map(
            (k, v) => MapEntry(k, (v as List).cast<String>()),
          ),
          responseType: row.responseType,
          updatedAtMs: row.updatedAtMs,
          bodySizeBytes: row.bodySizeBytes,
        ),
    ];
  }

  String primaryKeyForUrl(RequestOptions options) => buildHttpCacheKey(
    schemaVersion: schemaVersion,
    appBuild: appBuild,
    url: options.uri,
  );
}
