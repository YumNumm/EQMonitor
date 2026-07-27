import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:eqmonitor/core/api/http_cache_migrator.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('未移行なら全削除後にversionを保存する', () async {
    final db = CacheDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: 'test');
    await store.write(_entry('old'));
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final prefs = await SharedPreferences.getInstance();
    final dataSource = SharedPreferencesDataSource(sharedPreferences: prefs);

    await HttpCacheMigrator(
      clearCache: store.clearAll,
      dataSource: dataSource,
    ).migrate();

    expect(await store.listSummaries(), isEmpty);
    expect(
      await dataSource.getInt(
        key: SharedPreferencesKey.httpCacheScopeMigrationVersion,
      ),
      kHttpCacheScopeMigrationVersion,
    );
  });

  test('移行済みなら新しいエントリを削除しない', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.httpCacheScopeMigrationVersion.key:
          kHttpCacheScopeMigrationVersion,
    });
    final db = CacheDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: 'test');
    await store.write(_entry('allowed'));
    final prefs = await SharedPreferences.getInstance();

    await HttpCacheMigrator(
      clearCache: store.clearAll,
      dataSource: SharedPreferencesDataSource(sharedPreferences: prefs),
    ).migrate();

    expect(await store.listSummaries(), hasLength(1));
  });

  test('削除失敗時はversionを保存しない', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final prefs = await SharedPreferences.getInstance();

    await expectLater(
      HttpCacheMigrator(
        clearCache: () async => throw StateError('clear failed'),
        dataSource: SharedPreferencesDataSource(sharedPreferences: prefs),
      ).migrate(),
      throwsA(isA<StateError>()),
    );
    expect(
      prefs.getInt(SharedPreferencesKey.httpCacheScopeMigrationVersion.key),
      isNull,
    );
  });
}

HttpCacheEntry _entry(String key) => HttpCacheEntry(
  key: key,
  statusCode: 200,
  eTag: 'W/\"$key\"',
  headers: const {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
  responseType: 'json',
  body: Uint8List.fromList(utf8.encode('{\"value\":\"$key\"}')),
  updatedAtMs: 0,
);
