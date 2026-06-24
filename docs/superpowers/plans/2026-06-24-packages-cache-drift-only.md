# packages/cache を Drift 自前実装へ移行 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `packages/cache` から `dio_cache_interceptor` / `http_cache_drift_store` を排除し、ETag/304 HTTP キャッシュを Drift のみで自前実装する。

**Architecture:** Drift テーブル `HttpCacheEntries` を `CacheDatabase`(QueryExecutor 注入) で操作し、`HttpCacheStore` ファサード越しに `HttpCacheInterceptor`(Dio Interceptor) が読み書き。本番 DB は `drift_flutter` で `packages/cache` 内にオープン。app は interceptor と store provider を差し替える。

**Tech Stack:** Dart/Flutter, Drift, drift_flutter, dio, http_mock_adapter, Riverpod。

## Global Constraints

- `packages/cache` は外部キャッシュパッケージ(`dio_cache_interceptor`, `http_cache_drift_store`)を一切使わない。ストレージは Drift のみ。
- 新規パッケージ追加は承認済の `drift` / `drift_flutter` / `path_provider` / dev:`drift_dev` / dev:`sqlite3` のみ。それ以外の新規パッケージ追加はユーザー承認が必要。
- `dio` 依存は維持してよい。
- 自明なコメントを書かない。コメントは非自明な理由のみ。
- `melos run analyze` が警告ゼロで通ること。`dart format` 準拠。
- 公開 Provider は 1 ファイル 1 つまで。
- 生成ファイル(`*.g.dart`)はコミットする。
- 参照パターン: `packages/telemetry_store`（Drift + QueryExecutor 注入 + `NativeDatabase.memory()` テスト）。
- 全コマンドは worktree ルート `/Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/.claude/worktrees/packages-cache-drift-only` から実行。

---

### Task 1: packages/cache の依存差し替えと Drift スキャフォールド

**Files:**
- Modify: `packages/cache/pubspec.yaml`
- Create: `packages/cache/lib/src/database/http_cache_entries_table.dart`
- Create: `packages/cache/lib/src/database/http_cache_database.dart`
- Create: `packages/cache/build.yaml`（任意・drift options 不要なら省略可）

**Interfaces:**
- Produces: `class HttpCacheEntries extends Table`（DataClass `HttpCacheEntryRow`）, `class CacheDatabase extends _$CacheDatabase { CacheDatabase(super.e); }`

- [ ] **Step 1: pubspec を書き換える**

`packages/cache/pubspec.yaml` を以下にする:

```yaml
name: cache
description: HTTP ETag/304 cache backed by Drift for EQMonitor.
version: 1.0.0
publish_to: "none"

environment:
  sdk: ^3.11.0
  flutter: ^3.44.0

resolution: workspace

dependencies:
  dio: ^5.8.0+1
  drift: ^2.22.0
  drift_flutter: ^0.2.0
  flutter:
    sdk: flutter
  path_provider: ^2.1.5

dev_dependencies:
  altive_lints: ^2.3.0
  build_runner: ^2.7.1
  drift_dev: ^2.22.0
  eqmonitor_lints:
    path: ../eqmonitor_lints
  flutter_test:
    sdk: flutter
  http_mock_adapter: ^0.6.1
  sqlite3: ^2.7.0
  test: ^1.29.0
```

- [ ] **Step 2: テーブルを定義する**

`packages/cache/lib/src/database/http_cache_entries_table.dart`:

```dart
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
```

- [ ] **Step 3: データベースクラスを定義する（DAO は次タスク）**

`packages/cache/lib/src/database/http_cache_database.dart`:

```dart
import 'package:cache/src/database/http_cache_entries_table.dart';
import 'package:drift/drift.dart';

part 'http_cache_database.g.dart';

@DriftDatabase(tables: [HttpCacheEntries])
class CacheDatabase extends _$CacheDatabase {
  CacheDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
```

- [ ] **Step 4: bootstrap して生成する**

Run:
```bash
dart pub global run melos bootstrap
dart pub global run melos exec --scope=cache -- dart run build_runner build --delete-conflicting-outputs
```
Expected: `packages/cache/lib/src/database/http_cache_database.g.dart` が生成され、`_$CacheDatabase` が解決する。エラーなし。

- [ ] **Step 5: アナライズ**

Run: `dart pub global run melos exec --scope=cache -- dart analyze`
Expected: No issues found（旧 `http_cache_store.dart`/`http_cache_key.dart` は dio_cache_interceptor を import したままなので、この時点ではエラーが出る。次タスク以降で順次置換する。Step5 は新規 2 ファイルにエラーが無いことの確認に留める）。

- [ ] **Step 6: コミット**

```bash
git add packages/cache/pubspec.yaml packages/cache/lib/src/database/ packages/cache/pubspec_overrides.yaml pubspec.lock packages/cache/lib/src/database/http_cache_database.g.dart
git commit -m "chore(cache): swap deps to drift and scaffold CacheDatabase"
```

---

### Task 2: CacheDatabase DAO（put/get/delete/clear）

**Files:**
- Modify: `packages/cache/lib/src/database/http_cache_database.dart`
- Test: `packages/cache/test/database/http_cache_database_test.dart`

**Interfaces:**
- Consumes: `CacheDatabase`, `HttpCacheEntries`, `HttpCacheEntryRow`, `HttpCacheEntriesCompanion`
- Produces:
  - `Future<HttpCacheEntryRow?> getEntry(String key)`
  - `Future<void> putEntry(HttpCacheEntriesCompanion data)`
  - `Future<void> deleteEntry(String key)`
  - `Future<void> clear()`

- [ ] **Step 1: 失敗するテストを書く**

`packages/cache/test/database/http_cache_database_test.dart`:

```dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/src/database/http_cache_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CacheDatabase db;

  setUp(() => db = CacheDatabase(NativeDatabase.memory()));
  tearDown(() async => db.close());

  HttpCacheEntriesCompanion entry(String key, {int status = 200, String? eTag}) =>
      HttpCacheEntriesCompanion.insert(
        key: key,
        statusCode: status,
        eTag: Value(eTag),
        headers: jsonEncode(<String, List<String>>{}),
        responseType: 'json',
        body: Uint8List.fromList(utf8.encode('{}')),
        updatedAtMs: 0,
      );

  test('putEntry then getEntry returns the row', () async {
    await db.putEntry(entry('k1', eTag: 'W/"a"'));
    final row = await db.getEntry('k1');
    expect(row, isNotNull);
    expect(row!.eTag, 'W/"a"');
  });

  test('putEntry replaces on same key', () async {
    await db.putEntry(entry('k1', status: 200));
    await db.putEntry(entry('k1', status: 201));
    final row = await db.getEntry('k1');
    expect(row!.statusCode, 201);
  });

  test('getEntry returns null for missing key', () async {
    expect(await db.getEntry('nope'), isNull);
  });

  test('deleteEntry removes only that key', () async {
    await db.putEntry(entry('k1'));
    await db.putEntry(entry('k2'));
    await db.deleteEntry('k1');
    expect(await db.getEntry('k1'), isNull);
    expect(await db.getEntry('k2'), isNotNull);
  });

  test('clear removes all', () async {
    await db.putEntry(entry('k1'));
    await db.putEntry(entry('k2'));
    await db.clear();
    expect(await db.getEntry('k1'), isNull);
    expect(await db.getEntry('k2'), isNull);
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd packages/cache && flutter test test/database/http_cache_database_test.dart`
Expected: コンパイルエラー（`getEntry`/`putEntry`/`deleteEntry`/`clear` 未定義）。

- [ ] **Step 3: DAO を実装**

`packages/cache/lib/src/database/http_cache_database.dart` の `CacheDatabase` 本体に追記:

```dart
  Future<HttpCacheEntryRow?> getEntry(String key) =>
      (select(httpCacheEntries)..where((t) => t.key.equals(key)))
          .getSingleOrNull();

  Future<void> putEntry(HttpCacheEntriesCompanion data) =>
      into(httpCacheEntries).insertOnConflictUpdate(data);

  Future<void> deleteEntry(String key) =>
      (delete(httpCacheEntries)..where((t) => t.key.equals(key))).go();

  Future<void> clear() => delete(httpCacheEntries).go();
```

- [ ] **Step 4: パスを確認**

Run: `cd packages/cache && flutter test test/database/http_cache_database_test.dart`
Expected: All tests passed.

- [ ] **Step 5: コミット**

```bash
git add packages/cache/lib/src/database/http_cache_database.dart packages/cache/lib/src/database/http_cache_database.g.dart packages/cache/test/database/http_cache_database_test.dart
git commit -m "feat(cache): add CacheDatabase DAO methods"
```

---

### Task 3: buildHttpCacheKey を dio_cache_interceptor 非依存に書換

**Files:**
- Modify: `packages/cache/lib/src/http/http_cache_key.dart`
- Test: `packages/cache/test/http/http_cache_key_test.dart`

**Interfaces:**
- Produces:
  - `const int kHttpCacheSchemaVersion = 1;`
  - `String buildHttpCacheKey({required int schemaVersion, required String appBuild, required Uri url, Map<String, String>? headers, Object? body})`

- [ ] **Step 1: テストを書き換える**

`packages/cache/test/http/http_cache_key_test.dart` の import を以下にし、本体の 5 テストはそのまま（既存の `package:cache/cache.dart` import で `buildHttpCacheKey` を使う）:

```dart
import 'package:cache/cache.dart';
import 'package:flutter_test/flutter_test.dart';
```

（既存テスト本体: 決定性 / schemaVersion 差分 / appBuild 差分 / query 差分 / `startsWith('v7:3.0.0+100:')` はそのまま維持する。）

- [ ] **Step 2: 失敗を確認**

Run: `cd packages/cache && flutter test test/http/http_cache_key_test.dart`
Expected: `http_cache_key.dart` が `dio_cache_interceptor` を import しておりコンパイルエラー、または `cache.dart` の export 連鎖でエラー。

- [ ] **Step 3: 実装を書き換える**

`packages/cache/lib/src/http/http_cache_key.dart` 全体を置換:

```dart
const kHttpCacheSchemaVersion = 1;

String buildHttpCacheKey({
  required int schemaVersion,
  required String appBuild,
  required Uri url,
  Map<String, String>? headers,
  Object? body,
}) => 'v$schemaVersion:$appBuild:$url';
```

- [ ] **Step 4: パスを確認**

Run: `cd packages/cache && flutter test test/http/http_cache_key_test.dart`
Expected: All tests passed.

- [ ] **Step 5: コミット**

```bash
git add packages/cache/lib/src/http/http_cache_key.dart packages/cache/test/http/http_cache_key_test.dart
git commit -m "refactor(cache): drop dio_cache_interceptor from cache key builder"
```

---

### Task 4: HttpCacheEntry モデル + HttpCacheStore ファサード

**Files:**
- Create: `packages/cache/lib/src/http/http_cache_entry.dart`
- Modify: `packages/cache/lib/src/http/http_cache_store.dart`
- Test: `packages/cache/test/http/http_cache_store_test.dart`

**Interfaces:**
- Consumes: `CacheDatabase`, `HttpCacheEntryRow`, `HttpCacheEntriesCompanion`, `buildHttpCacheKey`
- Produces:
  - `class HttpCacheEntry { key, statusCode, eTag, headers, responseType, body, updatedAtMs }`
  - `class HttpCacheStore({required CacheDatabase db, required int schemaVersion, required String appBuild})`
    - `Future<HttpCacheEntry?> read(String key)`
    - `Future<void> write(HttpCacheEntry entry)`
    - `Future<void> evict(String key)`
    - `Future<void> clearAll()`
    - `String primaryKeyForUrl(RequestOptions options)`

- [ ] **Step 1: HttpCacheEntry を作る**

`packages/cache/lib/src/http/http_cache_entry.dart`:

```dart
import 'dart:typed_data';

class HttpCacheEntry {
  const HttpCacheEntry({
    required this.key,
    required this.statusCode,
    required this.eTag,
    required this.headers,
    required this.responseType,
    required this.body,
    required this.updatedAtMs,
  });

  final String key;
  final int statusCode;
  final String? eTag;
  final Map<String, List<String>> headers;
  final String responseType;
  final Uint8List body;
  final int updatedAtMs;
}
```

- [ ] **Step 2: 失敗するテストを書く**

`packages/cache/test/http/http_cache_store_test.dart` 全体を置換:

```dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/cache.dart';
import 'package:cache/src/database/http_cache_database.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CacheDatabase db;
  late HttpCacheStore store;

  setUp(() {
    db = CacheDatabase(NativeDatabase.memory());
    store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: '3.0.0+100');
  });
  tearDown(() async => db.close());

  RequestOptions options() => RequestOptions(
    path: '/v2/earthquake',
    baseUrl: 'https://v2.api.eqmonitor.app',
    method: 'GET',
    queryParameters: <String, dynamic>{'limit': '10'},
  );

  HttpCacheEntry entryFor(String key) => HttpCacheEntry(
    key: key,
    statusCode: 200,
    eTag: 'W/"abc"',
    headers: const {'content-type': ['application/json']},
    responseType: 'json',
    body: Uint8List.fromList(utf8.encode('{}')),
    updatedAtMs: 0,
  );

  test('primaryKeyForUrl は buildHttpCacheKey と一致', () {
    expect(
      store.primaryKeyForUrl(options()),
      buildHttpCacheKey(
        schemaVersion: 1,
        appBuild: '3.0.0+100',
        url: options().uri,
      ),
    );
  });

  test('write した内容が read で往復する', () async {
    final key = store.primaryKeyForUrl(options());
    await store.write(entryFor(key));
    final got = await store.read(key);
    expect(got, isNotNull);
    expect(got!.eTag, 'W/"abc"');
    expect(utf8.decode(got.body), '{}');
    expect(got.headers['content-type'], ['application/json']);
  });

  test('evict は指定キーのみ削除', () async {
    final key = store.primaryKeyForUrl(options());
    await store.write(entryFor(key));
    expect(await store.read(key), isNotNull);
    await store.evict(key);
    expect(await store.read(key), isNull);
  });

  test('clearAll は全削除', () async {
    await store.write(entryFor('k1'));
    await store.write(entryFor('k2'));
    await store.clearAll();
    expect(await store.read('k1'), isNull);
    expect(await store.read('k2'), isNull);
  });
}
```

- [ ] **Step 3: 失敗を確認**

Run: `cd packages/cache && flutter test test/http/http_cache_store_test.dart`
Expected: コンパイルエラー（旧 `HttpCacheStore` は `dio_cache_interceptor` の `CacheStore` を要求）。

- [ ] **Step 4: HttpCacheStore を実装**

`packages/cache/lib/src/http/http_cache_store.dart` 全体を置換:

```dart
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
```

- [ ] **Step 5: パスを確認**

Run: `cd packages/cache && flutter test test/http/http_cache_store_test.dart`
Expected: All tests passed.

- [ ] **Step 6: コミット**

```bash
git add packages/cache/lib/src/http/http_cache_entry.dart packages/cache/lib/src/http/http_cache_store.dart packages/cache/test/http/http_cache_store_test.dart
git commit -m "feat(cache): drift-backed HttpCacheStore and HttpCacheEntry"
```

---

### Task 5: HttpCacheInterceptor（ETag/304）

**Files:**
- Create: `packages/cache/lib/src/http/http_cache_interceptor.dart`
- Test: `packages/cache/test/http/http_cache_interceptor_test.dart`

**Interfaces:**
- Consumes: `HttpCacheStore`, `HttpCacheEntry`, `dio` の `Interceptor`/`RequestOptions`/`Response`/`Headers`
- Produces: `class HttpCacheInterceptor extends Interceptor { HttpCacheInterceptor(this.store); }`

- [ ] **Step 1: 失敗するテストを書く**

`packages/cache/test/http/http_cache_interceptor_test.dart` 全体を置換:

```dart
import 'dart:convert';

import 'package:cache/cache.dart';
import 'package:cache/src/database/http_cache_database.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

Map<String, List<String>> jsonHeaders(String eTag) => {
  'etag': [eTag],
  'content-type': ['application/json'],
};

void main() {
  late CacheDatabase db;

  setUp(() => db = CacheDatabase(NativeDatabase.memory()));
  tearDown(() async => db.close());

  Dio buildDio({int schemaVersion = 1}) {
    final store = HttpCacheStore(
      db: db,
      schemaVersion: schemaVersion,
      appBuild: '3.0.0+100',
    );
    final dio = Dio(BaseOptions(baseUrl: 'https://v2.api.eqmonitor.app'))
      ..interceptors.add(HttpCacheInterceptor(store));
    return dio;
  }

  test('200 で保存 → 再GETで 304 → body 復元', () async {
    const path = '/v2/earthquake';
    final dio = buildDio();
    final adapter = DioAdapter(dio: dio);

    adapter.onGet(
      path,
      (server) => server.reply(
        200,
        {'items': <dynamic>[]},
        headers: jsonHeaders('W/"v1"'),
      ),
    );
    final first = await dio.get<dynamic>(path);
    expect((first.data as Map)['items'], <dynamic>[]);

    adapter.onGet(
      path,
      (server) => server.reply(304, '', headers: {'etag': ['W/"v1"']}),
    );
    final second = await dio.get<dynamic>(path);
    expect((second.data as Map)['items'], <dynamic>[]);
  });

  test('200 応答で body 更新', () async {
    const path = '/v2/earthquake';
    final dio = buildDio();
    final adapter = DioAdapter(dio: dio);

    adapter.onGet(path, (s) => s.reply(200, {'v': 1}, headers: jsonHeaders('W/"v1"')));
    await dio.get<dynamic>(path);
    adapter.onGet(path, (s) => s.reply(200, {'v': 2}, headers: jsonHeaders('W/"v2"')));
    final updated = await dio.get<dynamic>(path);
    expect((updated.data as Map)['v'], 2);
  });

  test('schemaVersion 変更で旧 body が復元されない', () async {
    const path = '/v2/earthquake';
    final dio1 = buildDio();
    final adapter1 = DioAdapter(dio: dio1);
    adapter1.onGet(path, (s) => s.reply(200, {'gen': 1}, headers: jsonHeaders('W/"v1"')));
    await dio1.get<dynamic>(path);

    final dio2 = buildDio(schemaVersion: 2);
    final adapter2 = DioAdapter(dio: dio2);
    adapter2.onGet(path, (s) => s.reply(200, {'gen': 2}, headers: jsonHeaders('W/"v2"')));
    final res = await dio2.get<dynamic>(path);
    expect((res.data as Map)['gen'], 2);
  });
}
```

- [ ] **Step 2: 失敗を確認**

Run: `cd packages/cache && flutter test test/http/http_cache_interceptor_test.dart`
Expected: コンパイルエラー（`HttpCacheInterceptor` 未定義）。

- [ ] **Step 3: インターセプタを実装**

`packages/cache/lib/src/http/http_cache_interceptor.dart`:

```dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/src/http/http_cache_entry.dart';
import 'package:cache/src/http/http_cache_store.dart';
import 'package:dio/dio.dart';

const _keyExtra = 'cache.key';

class HttpCacheInterceptor extends Interceptor {
  HttpCacheInterceptor(this.store);

  final HttpCacheStore store;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.method.toUpperCase() != 'GET') {
      handler.next(options);
      return;
    }
    final key = store.primaryKeyForUrl(options);
    options.extra[_keyExtra] = key;
    final base = options.validateStatus;
    options.validateStatus = (status) =>
        status == 304 || base(status);
    final cached = await store.read(key);
    if (cached?.eTag != null) {
      options.headers['if-none-match'] = cached!.eTag;
    }
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    final key = response.requestOptions.extra[_keyExtra] as String?;
    if (key == null) {
      handler.next(response);
      return;
    }
    if (response.statusCode == 304) {
      final cached = await store.read(key);
      if (cached == null) {
        handler.next(response);
        return;
      }
      handler.resolve(_restore(response.requestOptions, cached));
      return;
    }
    if (response.statusCode == 200) {
      final entry = _toEntry(key, response);
      if (entry != null) {
        await store.write(entry);
      }
    }
    handler.next(response);
  }

  Response<dynamic> _restore(RequestOptions options, HttpCacheEntry entry) {
    final dynamic data;
    switch (entry.responseType) {
      case 'bytes':
        data = entry.body;
      case 'plain':
        data = utf8.decode(entry.body);
      case 'json':
      default:
        data = jsonDecode(utf8.decode(entry.body));
    }
    return Response<dynamic>(
      requestOptions: options,
      statusCode: entry.statusCode,
      data: data,
      headers: Headers.fromMap(entry.headers),
    );
  }

  HttpCacheEntry? _toEntry(String key, Response<dynamic> response) {
    final type = response.requestOptions.responseType;
    final Uint8List body;
    final String typeName;
    switch (type) {
      case ResponseType.bytes:
        body = Uint8List.fromList((response.data as List).cast<int>());
        typeName = 'bytes';
      case ResponseType.plain:
        body = Uint8List.fromList(utf8.encode(response.data as String));
        typeName = 'plain';
      case ResponseType.json:
        body = Uint8List.fromList(utf8.encode(jsonEncode(response.data)));
        typeName = 'json';
      case ResponseType.stream:
        return null;
    }
    return HttpCacheEntry(
      key: key,
      statusCode: response.statusCode ?? 200,
      eTag: response.headers.value('etag'),
      headers: response.headers.map,
      responseType: typeName,
      body: body,
      updatedAtMs: 0,
    );
  }
}
```

- [ ] **Step 4: パスを確認**

Run: `cd packages/cache && flutter test test/http/http_cache_interceptor_test.dart`
Expected: All tests passed。失敗する場合は 304 の `validateStatus` 経路（onError ではなく onResponse に来ること）と `Headers.fromMap` の content-type を確認する。

- [ ] **Step 5: コミット**

```bash
git add packages/cache/lib/src/http/http_cache_interceptor.dart packages/cache/test/http/http_cache_interceptor_test.dart
git commit -m "feat(cache): self-implemented ETag/304 HttpCacheInterceptor"
```

---

### Task 6: 本番オープナー + 公開 export

**Files:**
- Create: `packages/cache/lib/src/database/open_http_cache_database.dart`
- Modify: `packages/cache/lib/cache.dart`

**Interfaces:**
- Consumes: `CacheDatabase`, `drift_flutter` の `driftDatabase`
- Produces: `CacheDatabase openHttpCacheDatabase()`

- [ ] **Step 1: オープナーを作る**

`packages/cache/lib/src/database/open_http_cache_database.dart`:

```dart
import 'package:cache/src/database/http_cache_database.dart';
import 'package:drift_flutter/drift_flutter.dart';

CacheDatabase openHttpCacheDatabase() =>
    CacheDatabase(driftDatabase(name: 'eqmonitor_http_cache'));
```

- [ ] **Step 2: export を更新**

`packages/cache/lib/cache.dart` 全体を置換:

```dart
/// EQMonitor の HTTP ETag/304 キャッシュ基盤 (Drift)。Riverpod 非依存。
library;

export 'src/database/http_cache_database.dart' show CacheDatabase;
export 'src/database/open_http_cache_database.dart';
export 'src/http/http_cache_entry.dart';
export 'src/http/http_cache_interceptor.dart';
export 'src/http/http_cache_key.dart';
export 'src/http/http_cache_store.dart';
```

- [ ] **Step 3: パッケージ全体のアナライズとテスト**

Run:
```bash
cd packages/cache && dart analyze && flutter test
```
Expected: No issues found. / All tests passed.

- [ ] **Step 4: コミット**

```bash
git add packages/cache/lib/src/database/open_http_cache_database.dart packages/cache/lib/cache.dart
git commit -m "feat(cache): drift_flutter opener and public exports"
```

---

### Task 7: app 結線の差し替え

**Files:**
- Modify: `app/lib/core/api/http_cache_store_provider.dart`
- Modify: `app/lib/core/provider/dio_provider.dart`
- Modify: `app/pubspec.yaml`
- Regenerate: `app/lib/core/api/http_cache_store_provider.g.dart`

**Interfaces:**
- Consumes: `HttpCacheStore`, `openHttpCacheDatabase`, `HttpCacheInterceptor`, `kHttpCacheSchemaVersion`, `buildHttpCacheKey`

- [ ] **Step 1: http_cache_store_provider を書き換える**

`app/lib/core/api/http_cache_store_provider.dart` 全体を置換:

```dart
import 'package:cache/cache.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_cache_store_provider.g.dart';

@Riverpod(keepAlive: true)
HttpCacheStore httpCacheStore(Ref ref) {
  final package = ref.watch(packageInfoProvider);
  final db = openHttpCacheDatabase();
  ref.onDispose(db.close);
  return HttpCacheStore(
    db: db,
    schemaVersion: kHttpCacheSchemaVersion,
    appBuild: '${package.version}+${package.buildNumber}',
  );
}
```

- [ ] **Step 2: dio_provider を書き換える**

`app/lib/core/provider/dio_provider.dart` で次を行う:

import を変更（`package:dio_cache_interceptor/...` を削除、`http_cache_store_provider` import は維持）:

```dart
import 'package:cache/cache.dart';
```

`httpCache` の取得を `future` 無しの同期 watch にする:

```dart
    final httpCache = ref.watch(httpCacheStoreProvider);
```

`DioCacheInterceptor(...)` ブロック全体を次に置換:

```dart
  dio.interceptors.add(HttpCacheInterceptor(httpCache));
```

（`dio(Ref ref)` は他の `await` が残るため `Future<Dio>` のまま。`httpCacheStoreProvider` が同期 Provider になったので `.future` は使わない。）

- [ ] **Step 3: app/pubspec.yaml から旧依存を削除**

`app/pubspec.yaml` の以下 2 行を削除:

```yaml
  dio_cache_interceptor: ^4.0.6
  http_cache_drift_store: ^7.0.0
```

- [ ] **Step 4: bootstrap と riverpod 再生成**

Run:
```bash
dart pub global run melos bootstrap
dart pub global run melos exec --scope=eqmonitor -- dart run build_runner build --delete-conflicting-outputs
```
Expected: `http_cache_store_provider.g.dart` が `FutureProvider` から `Provider`(同期) へ再生成される。エラーなし。

- [ ] **Step 5: アナライズ**

Run: `dart pub global run melos run analyze`
Expected: No issues found across all packages（`dio_provider.dart` / `http_cache_store_provider.dart` に未解決 import が無いこと）。

- [ ] **Step 6: 旧依存が消えたことを確認**

Run: `grep -rn "dio_cache_interceptor\|http_cache_drift_store" app packages --include=*.dart --include=pubspec.yaml`
Expected: 出力なし（マッチ 0 件）。

- [ ] **Step 7: コミット**

```bash
git add app/lib/core/api/http_cache_store_provider.dart app/lib/core/api/http_cache_store_provider.g.dart app/lib/core/provider/dio_provider.dart app/lib/core/provider/dio_provider.g.dart app/pubspec.yaml pubspec.lock
git commit -m "feat(app): wire HttpCacheInterceptor and drift-backed cache store"
```

---

### Task 8: 全体検証

**Files:** なし（検証のみ）

- [ ] **Step 1: 全テスト**

Run: `dart pub global run melos run test`
Expected: Flutter + Dart 全テストパス（少なくとも `packages/cache` と app の関連テスト）。

- [ ] **Step 2: 全アナライズ**

Run: `dart pub global run melos run analyze`
Expected: No issues found.

- [ ] **Step 3: フォーマット確認**

Run: `dart format --output=none --set-exit-if-changed packages/cache app/lib/core/api/http_cache_store_provider.dart app/lib/core/provider/dio_provider.dart`
Expected: 変更なし（exit 0）。差分があれば `dart format` を適用して再コミット。

---

## Self-Review メモ

- Spec の全節（依存変更 / ファイル構成 / テーブル / 各 IF / app 変更 / テスト）に対応タスクあり。
- 型整合: `CacheDatabase` の DAO 名（`getEntry`/`putEntry`/`deleteEntry`/`clear`）は Task2 定義を Task4/5 で一貫使用。`HttpCacheStore` の `read`/`write`/`evict`/`clearAll`/`primaryKeyForUrl` は Task4 定義を Task5/7 で一貫使用。`HttpCacheEntry` フィールドは Task4 定義に統一。
- `responseType` 文字列（`json`/`plain`/`bytes`）は Task5 の保存・復元で同一語彙。
- `drift_flutter: ^0.2.0` のバージョンは bootstrap 時に workspace 解決へ委ねる。解決不能なら `melos` の制約に合わせ調整（新規パッケージ追加ではなくバージョン調整なので承認不要）。
