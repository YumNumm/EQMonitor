# 計画C: ETag/304 横断層 + `packages/cache` 新設 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 新規パッケージ `packages/cache` を切り、Flutter アプリの API 層に横断的な ETag/`If-None-Match` → 304 条件付き GET キャッシュを `dio_cache_interceptor` で組み込む。無変更レスポンスをバイトゼロで短絡しつつ、URL 単位 evict / 全消去 / schema version 名前空間化を公開する。

**Architecture:** インフラ (`HttpCacheStore` クラス・`buildHttpCacheKey`・`kHttpCacheSchemaVersion`) は **Riverpod 非依存の `packages/cache`** に置く (既存 `eqmonitor_api` 等と同じパターン)。Riverpod の結線 (`httpCacheStore` provider・`dioProvider` への interceptor 登録) は **`app`** が行う。`dio_cache_interceptor` 4.x (`http_cache_core` ベース) + Drift ストア (`http_cache_drift_store`) を採用。GET のみ `CachePolicy.refreshForceCache` で再検証し、keyBuilder は schema version + app build で名前空間化する。

**Tech Stack:** Dart/Flutter, Dio ^5.8.0+1, `dio_cache_interceptor` 4.x, `http_cache_drift_store` 7.x, Riverpod (`riverpod_annotation` ^4.0.0 + `riverpod_generator` ^4.0.0+1), talker, `http_mock_adapter` (dev)。

## Global Constraints

- **PR / ブランチ**: PR は常に `YumNumm/EQMonitor` の `origin` のみ。`gh pr create --repo YumNumm/EQMonitor --base develop`。develop で直接実装しない (専用ブランチ)。
- **パッケージ境界** (契約書 §0): `packages/cache` は **Riverpod / app 非依存**のインフラのみ。Riverpod provider・UI・ドメイン結線は `app`。`packages/cache` は `app`・`eqmonitor` を import しない。
- **1 ファイル 1 公開 Provider** ([[one-public-provider-per-file]]): `httpCacheStore` provider は app 側専用ファイル。
- **新規IFは契約書厳守**: `HttpCacheStore`(`evict`/`clearAll`/`primaryKeyForUrl`)・`kHttpCacheSchemaVersion`・`buildHttpCacheKey`・provider 名 `httpCacheStore` は契約書 §3 通り。計画D が消費するため改名禁止。
- **場当たり的な複雑化を避ける** ([[avoid-incidental-complexity]]): HTTP キャッシュ層は「ETag/304 透過キャッシュ」責務のみ。ドメイン永続化 (Drift SWR)・自己修復・保持戦略・Chip は計画D/E。
- **import**: クロスパッケージは package import。`dart analyze` 警告ゼロ。`dart format` 準拠。
- **codegen**: `*.g.dart` はコミット対象。アノテーション変更後は `dart run build_runner build --delete-conflicting-outputs`。

## バージョン (Task 0 で pub.dev 解決値に固定)

| パッケージ | 仮置き | 備考 |
|---|---|---|
| `dio_cache_interceptor` | `^4.0.6` | dio `^5.2.0+1` / `http_cache_core` `^1.1.3` 依存。アプリ dio `^5.8.0+1` と整合。`DioCacheInterceptor`/`CacheOptions`/`CachePolicy`/`CacheResponse`/`MemCacheStore` を提供 |
| `http_cache_drift_store` | `^7.0.0` | Drift ベースの `CacheStore`。**旧 `dio_cache_interceptor_db_store` は discontinued** のためこちらを採用。クラス `DriftCacheStore` |
| `http_mock_adapter` (dev) | `^0.6.1` | `DioAdapter` でモック |

> Task 0 で `dart pub add` の解決結果を確認し制約を実値へ固定する。`DriftCacheStore` のコンストラクタ (`databasePath` か `databaseName` か) を Task 0 Step 3 で検証。

---

## File Structure

| ファイル | 責務 | 種別 |
|---|---|---|
| `packages/cache/pubspec.yaml` | `cache` パッケージ定義 (dio/dio_cache_interceptor/http_cache_drift_store + dev http_mock_adapter) | Create |
| `packages/cache/analysis_options.yaml` | `include: package:eqmonitor_lints/analysis_options.yaml` | Create |
| `packages/cache/lib/cache.dart` | barrel export | Create |
| `packages/cache/lib/src/http/http_cache_key.dart` | `kHttpCacheSchemaVersion` + 純関数 `buildHttpCacheKey` | Create |
| `packages/cache/lib/src/http/http_cache_store.dart` | `HttpCacheStore` (CacheStore ラッパ。Riverpod 無し) | Create |
| `packages/cache/test/http/http_cache_key_test.dart` | keyBuilder 名前空間化テスト | Create (Test) |
| `packages/cache/test/http/http_cache_store_test.dart` | evict/clearAll/primaryKeyForUrl テスト | Create (Test) |
| `packages/cache/test/http/http_cache_interceptor_test.dart` | ETag 保存・304 復元・200 更新・名前空間化 統合テスト | Create (Test) |
| `app/lib/core/api/http_cache_store_provider.dart` | `@Riverpod(keepAlive: true) httpCacheStore` (DriftCacheStore 生成 + HttpCacheStore ラップ) | Create |
| `app/lib/core/provider/log/talker.dart` | `HttpCacheLog extends TalkerLog` 追加 | Modify |
| `app/lib/core/provider/dio_provider.dart` | `DioCacheInterceptor` を `TalkerDioLogger` の前に登録 | Modify |
| `app/pubspec.yaml` | `cache` への path 依存追加 | Modify |
| `app/test/core/api/http_cache_store_provider_test.dart` | provider が HttpCacheStore を供給することの確認 | Create (Test) |

> root `pubspec.yaml` の `workspace:` は `packages/*` glob なので新パッケージ追加で**自動認識** (root 編集不要)。`kHttpCacheSchemaVersion` は計画D の `kCacheSchemaVersion` (同 `packages/cache`) と同値で同期。

---

## Task 0: `packages/cache` パッケージ scaffold + 依存追加

**Files:**
- Create: `packages/cache/pubspec.yaml` / `packages/cache/analysis_options.yaml` / `packages/cache/lib/cache.dart`

**Interfaces:**
- Produces: パッケージ `cache` が workspace に追加され、`dio_cache_interceptor`(`DioCacheInterceptor`/`CacheOptions`/`CachePolicy`/`CacheResponse`/`MemCacheStore`)、`http_cache_drift_store`(`DriftCacheStore`)、dev `http_mock_adapter`(`DioAdapter`) が利用可能。

- [ ] **Step 1: pubspec.yaml 作成**

`packages/cache/pubspec.yaml` (バージョンは Step 4 で実値固定):
```yaml
name: cache
description: HTTP ETag/304 cache + Drift SWR cache infrastructure for EQMonitor.
version: 1.0.0
publish_to: "none"

environment:
  sdk: ^3.11.0
  flutter: ^3.44.0

resolution: workspace

dependencies:
  dio: ^5.8.0+1
  dio_cache_interceptor: ^4.0.6
  http_cache_drift_store: ^7.0.0

dev_dependencies:
  altive_lints: ^2.3.0
  build_runner: ^2.7.1
  eqmonitor_lints:
    path: ../eqmonitor_lints
  http_mock_adapter: ^0.6.1
  test: ^1.29.0
```

> Drift 本体 (`drift`/`drift_flutter`/`drift_dev`) は計画D の `CacheDatabase` で追加する。本計画では `http_cache_drift_store` が内部で使う drift のみ (推移依存)。

- [ ] **Step 2: analysis_options.yaml**

`packages/cache/analysis_options.yaml`:
```yaml
include: package:eqmonitor_lints/analysis_options.yaml
```

- [ ] **Step 3: barrel export 作成 (最初は空に近い)**

`packages/cache/lib/cache.dart`:
```dart
/// EQMonitor のキャッシュ基盤 (HTTP ETag/304 + Drift SWR)。Riverpod 非依存。
library;

export 'src/http/http_cache_key.dart';
export 'src/http/http_cache_store.dart';
```

> 上記 export 先は Task 1/2 で作成する。Task 0 Step 5 の `melos bootstrap` 時点では未作成のため、**この export はコメントアウトしておき Task 2 完了時に有効化**する (もしくは Task 1 の後に追記)。Task 0 では `library;` のみの空 barrel で良い。

- [ ] **Step 4: 依存解決 (pub.dev 解決値を確認)**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
dart pub global run melos bootstrap   # または: melos bootstrap
```
Run: `cat packages/cache/pubspec_overrides.yaml 2>/dev/null; cd packages/cache && dart pub deps --style=compact | grep -E 'dio_cache_interceptor|http_cache_core|http_cache_drift_store|drift'`
Expected: `dio_cache_interceptor` 4.x / `http_cache_core` 1.x / `http_cache_drift_store` 7.x / `drift` が解決。pubspec の制約を解決値に合わせ `^x.y.z` で固定。

- [ ] **Step 5: ストアのクラス名・コンストラクタ・CachePolicy を import 確認**

`packages/cache/tool/_verify_http_cache_api.dart` を作成:
```dart
// ignore_for_file: unused_local_variable, avoid_print
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_cache_drift_store/http_cache_drift_store.dart';

void main() {
  final CacheStore store = DriftCacheStore(databasePath: '/tmp/x');
  final options = CacheOptions(store: store, policy: CachePolicy.refreshForceCache);
  print(options.policy);
}
```
Run: `cd packages/cache && dart analyze tool/_verify_http_cache_api.dart`
Expected: 解析が通る。違えば `http_cache_drift_store` の export を確認し正しい名前 (`databaseName` 等) に直し後続タスクの該当箇所も合わせる。確認後 `tool/_verify_http_cache_api.dart` を削除。

- [ ] **Step 6: Commit**

```bash
git add packages/cache/pubspec.yaml packages/cache/analysis_options.yaml packages/cache/lib/cache.dart pubspec.lock app/pubspec.lock
git commit -m "build(cache): scaffold packages/cache for ETag/304 + SWR infra"
```

---

## Task 1: keyBuilder 名前空間化 (純関数 + 定数) — `packages/cache`

`dio_cache_interceptor` の keyBuilder は「同一リクエストに同一キー」を返す純関数。schema version + app build を prefix し、モデル変更後に旧 body が 304 再生されパース失敗するのを防ぐ。interceptor の keyBuilder と `HttpCacheStore.primaryKeyForUrl` が**同一ロジック**を使うため純関数として切り出す。

**Files:**
- Create: `packages/cache/lib/src/http/http_cache_key.dart`
- Test: `packages/cache/test/http/http_cache_key_test.dart`

**Interfaces:**
- Produces:
  - `const int kHttpCacheSchemaVersion` (現状 `1`)。計画D の `kCacheSchemaVersion` と同値で同期。
  - `String buildHttpCacheKey({required int schemaVersion, required String appBuild, required RequestOptions options})` — `CacheOptions.defaultCacheKeyBuilder(options)` を base に `v<schemaVersion>:<appBuild>:` を prefix。

- [ ] **Step 1: 失敗テスト**

`packages/cache/test/http/http_cache_key_test.dart`:
```dart
import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  RequestOptions options() => RequestOptions(
    path: '/v2/earthquake',
    baseUrl: 'https://v2.api.eqmonitor.app',
    method: 'GET',
    queryParameters: <String, dynamic>{'limit': '10'},
  );

  test('同一リクエストは同一キー (決定的)', () {
    expect(
      buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', options: options()),
      buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', options: options()),
    );
  });

  test('schemaVersion が変わるとキーが変わる', () {
    expect(
      buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', options: options()),
      isNot(buildHttpCacheKey(schemaVersion: 2, appBuild: '3.0.0+100', options: options())),
    );
  });

  test('appBuild が変わるとキーが変わる', () {
    expect(
      buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', options: options()),
      isNot(buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+101', options: options())),
    );
  });

  test('クエリが変わるとキーが変わる', () {
    final other = RequestOptions(
      path: '/v2/earthquake',
      baseUrl: 'https://v2.api.eqmonitor.app',
      method: 'GET',
      queryParameters: <String, dynamic>{'limit': '50'},
    );
    expect(
      buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', options: options()),
      isNot(buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', options: other)),
    );
  });

  test('キーは名前空間 prefix を含む', () {
    final key = buildHttpCacheKey(schemaVersion: 7, appBuild: '3.0.0+100', options: options());
    expect(key, startsWith('v7:3.0.0+100:'));
  });
}
```

- [ ] **Step 2: 失敗確認**

> `cache.dart` barrel の export を有効化 (`export 'src/http/http_cache_key.dart';`)。
Run: `cd packages/cache && dart test test/http/http_cache_key_test.dart`
Expected: FAIL (`buildHttpCacheKey` undefined / URI not exist)

- [ ] **Step 3: 実装**

`packages/cache/lib/src/http/http_cache_key.dart`:
```dart
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

/// HTTP キャッシュ (ETag/304 透過層) のスキーマバージョン。
///
/// モデル変更でキャッシュ済み body が古くなった場合にこの値を上げると、
/// keyBuilder の名前空間が変わり旧 body が 304 で復元されなくなる。
/// 計画D の `kCacheSchemaVersion` (lib/src/cache_constants.dart) と同値で同期。
const int kHttpCacheSchemaVersion = 1;

/// interceptor の keyBuilder と HttpCacheStore.primaryKeyForUrl が共用する
/// 名前空間化済みキャッシュキー生成関数。
///
/// dio_cache_interceptor の既定キー生成 (method + uri ハッシュ) を base に
/// `v<schemaVersion>:<appBuild>:` を prefix して名前空間を分離する。
String buildHttpCacheKey({
  required int schemaVersion,
  required String appBuild,
  required RequestOptions options,
}) {
  final base = CacheOptions.defaultCacheKeyBuilder(options);
  return 'v$schemaVersion:$appBuild:$base';
}
```

> `CacheOptions.defaultCacheKeyBuilder` のシグネチャ (引数 `RequestOptions` 1 つで `String`) は Task 0 Step 5 で確認済み。型が異なれば確認結果に合わせる。

- [ ] **Step 4: 緑** — Run: `cd packages/cache && dart test test/http/http_cache_key_test.dart` → PASS (5)

- [ ] **Step 5: Commit**
```bash
git add packages/cache/lib/cache.dart packages/cache/lib/src/http/http_cache_key.dart packages/cache/test/http/http_cache_key_test.dart
git commit -m "feat(cache): add namespaced HTTP cache key builder + kHttpCacheSchemaVersion"
```

---

## Task 2: `HttpCacheStore` ラッパ — `packages/cache` (Riverpod 無し)

`CacheStore` をラップし契約書 §3 の API (`evict`/`clearAll`/`primaryKeyForUrl`) を公開。`primaryKeyForUrl` は Task 1 の `buildHttpCacheKey` を使い interceptor の keyBuilder と完全一致させる (計画D の自己修復が「URL → key → evict」を正しく解決するため)。

**Files:**
- Create: `packages/cache/lib/src/http/http_cache_store.dart`
- Modify: `packages/cache/lib/cache.dart` (export 追加)
- Test: `packages/cache/test/http/http_cache_store_test.dart`

**Interfaces:**
- Consumes: `kHttpCacheSchemaVersion`/`buildHttpCacheKey` (Task 1)、`dio_cache_interceptor` の `CacheStore`/`MemCacheStore`/`CacheResponse`。
- Produces:
  - `class HttpCacheStore { HttpCacheStore({required CacheStore store, required int schemaVersion, required String appBuild}); final CacheStore store; final int schemaVersion; final String appBuild; Future<void> evict(String); Future<void> clearAll(); String primaryKeyForUrl(RequestOptions); }`。
  - **Riverpod provider は含めない** (app 側 Task 4)。

- [ ] **Step 1: 失敗テスト**

`packages/cache/test/http/http_cache_store_test.dart`:
```dart
import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:test/test.dart';

void main() {
  RequestOptions options() => RequestOptions(
    path: '/v2/earthquake',
    baseUrl: 'https://v2.api.eqmonitor.app',
    method: 'GET',
    queryParameters: <String, dynamic>{'limit': '10'},
  );

  CacheResponse responseFor(String key) => CacheResponse(
    key: key,
    url: 'https://v2.api.eqmonitor.app/v2/earthquake?limit=10',
    eTag: 'W/"abc"',
    content: const [1, 2, 3],
    date: DateTime.now(),
    expires: null,
    headers: null,
    lastModified: null,
    maxStale: null,
    priority: CachePriority.normal,
    requestDate: DateTime.now(),
    responseDate: DateTime.now(),
    cacheControl: CacheControl(),
  );

  test('primaryKeyForUrl は buildHttpCacheKey と一致', () {
    final sut = HttpCacheStore(store: MemCacheStore(), schemaVersion: 1, appBuild: '3.0.0+100');
    expect(
      sut.primaryKeyForUrl(options()),
      buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', options: options()),
    );
  });

  test('evict は指定キーのみ削除', () async {
    final mem = MemCacheStore();
    final sut = HttpCacheStore(store: mem, schemaVersion: 1, appBuild: '3.0.0+100');
    final key = sut.primaryKeyForUrl(options());
    await mem.set(responseFor(key));
    expect(await mem.exists(key), isTrue);
    await sut.evict(key);
    expect(await mem.exists(key), isFalse);
  });

  test('clearAll は全削除', () async {
    final mem = MemCacheStore();
    final sut = HttpCacheStore(store: mem, schemaVersion: 1, appBuild: '3.0.0+100');
    await mem.set(responseFor('k1'));
    await mem.set(responseFor('k2'));
    await sut.clearAll();
    expect(await mem.exists('k1'), isFalse);
    expect(await mem.exists('k2'), isFalse);
  });
}
```

> `CacheResponse` のフィールド名は Task 0 Step 5 の `dart analyze` で確認済みのものを使う。違えば合わせる。

- [ ] **Step 2: 失敗確認** — Run: `cd packages/cache && dart test test/http/http_cache_store_test.dart` → FAIL

- [ ] **Step 3: 実装**

`packages/cache/lib/src/http/http_cache_store.dart`:
```dart
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'http_cache_key.dart';

/// dio_cache_interceptor の [CacheStore] をラップし、URL 単位 evict と
/// 全消去、キャッシュキー解決を公開する横断 HTTP キャッシュストア。
/// Riverpod 非依存 (provider は app が供給)。
class HttpCacheStore {
  HttpCacheStore({
    required this.store,
    required this.schemaVersion,
    required this.appBuild,
  });

  /// 内部の dio_cache_interceptor ストア (Drift / Mem)。
  final CacheStore store;
  final int schemaVersion;
  final String appBuild;

  Future<void> evict(String primaryKey) => store.delete(primaryKey);
  Future<void> clearAll() => store.clean();
  String primaryKeyForUrl(RequestOptions options) => buildHttpCacheKey(
    schemaVersion: schemaVersion,
    appBuild: appBuild,
    options: options,
  );
}
```

`packages/cache/lib/cache.dart` に `export 'src/http/http_cache_store.dart';` を追加。

- [ ] **Step 4: 緑** — Run: `cd packages/cache && dart test test/http/http_cache_store_test.dart` → PASS (3)

- [ ] **Step 5: analyze + Commit**

Run: `cd packages/cache && dart analyze` → No issues
```bash
git add packages/cache/lib/src/http/http_cache_store.dart packages/cache/lib/cache.dart packages/cache/test/http/http_cache_store_test.dart
git commit -m "feat(cache): add HttpCacheStore wrapper (evict/clearAll/primaryKeyForUrl)"
```

---

## Task 3: ETag/304 統合テスト (パッケージ内) + HttpCacheLog

インターセプタ単体の ETag/304 振る舞いをパッケージ内で回帰ガードし、app 側に typed talker ログを足す。

**Files:**
- Create: `packages/cache/test/http/http_cache_interceptor_test.dart`
- Modify: `app/lib/core/provider/log/talker.dart`

**Interfaces:**
- Produces: `class HttpCacheLog extends TalkerLog` (`title => 'HttpCache'`)。

- [ ] **Step 1: 統合テスト (ETag 保存・If-None-Match 再送・304 復元・200 更新・名前空間化)**

`packages/cache/test/http/http_cache_interceptor_test.dart`:
```dart
import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

CacheOptions buildCacheOptions({
  required CacheStore store,
  required int schemaVersion,
  required String appBuild,
}) => CacheOptions(
  store: store,
  policy: CachePolicy.refreshForceCache,
  keyBuilder: (options) => buildHttpCacheKey(
    schemaVersion: schemaVersion,
    appBuild: appBuild,
    options: options,
  ),
);

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late MemCacheStore store;

  setUp(() {
    store = MemCacheStore();
    dio = Dio(BaseOptions(baseUrl: 'https://v2.api.eqmonitor.app'));
    dio.interceptors.add(DioCacheInterceptor(
      options: buildCacheOptions(store: store, schemaVersion: kHttpCacheSchemaVersion, appBuild: '3.0.0+100'),
    ));
    adapter = DioAdapter(dio: dio);
  });

  test('200 で ETag/body 保存 → 再GETで 304 → body 復元', () async {
    const path = '/v2/earthquake';
    const eTag = 'W/"v1"';
    adapter.onGet(path, (s) => s.reply(200, {'items': []},
        headers: {'etag': [eTag], 'cache-control': ['no-cache']}));
    final first = await dio.get<Map<String, dynamic>>(path);
    expect(first.data, {'items': []});

    adapter.onGet(path, (s) => s.reply(304, null, headers: {'etag': [eTag]}),
        headers: {'if-none-match': eTag});
    final second = await dio.get<Map<String, dynamic>>(path);
    expect(second.data, {'items': []});
  });

  test('200 応答で body 更新', () async {
    const path = '/v2/earthquake';
    adapter.onGet(path, (s) => s.reply(200, {'v': 1},
        headers: {'etag': ['W/"v1"'], 'cache-control': ['no-cache']}));
    await dio.get<Map<String, dynamic>>(path);
    adapter.onGet(path, (s) => s.reply(200, {'v': 2},
        headers: {'etag': ['W/"v2"'], 'cache-control': ['no-cache']}));
    final updated = await dio.get<Map<String, dynamic>>(path);
    expect(updated.data!['v'], 2);
  });

  test('schemaVersion 変更で旧 body が復元されない (名前空間化)', () async {
    const path = '/v2/earthquake';
    adapter.onGet(path, (s) => s.reply(200, {'gen': 1},
        headers: {'etag': ['W/"v1"'], 'cache-control': ['no-cache']}));
    await dio.get<Map<String, dynamic>>(path);

    final dio2 = Dio(BaseOptions(baseUrl: 'https://v2.api.eqmonitor.app'))
      ..interceptors.add(DioCacheInterceptor(
        options: buildCacheOptions(store: store, schemaVersion: 2, appBuild: '3.0.0+100'),
      ));
    final adapter2 = DioAdapter(dio: dio2);
    adapter2.onGet(path, (s) => s.reply(200, {'gen': 2},
        headers: {'etag': ['W/"v2"'], 'cache-control': ['no-cache']}));
    final res = await dio2.get<Map<String, dynamic>>(path);
    expect(res.data!['gen'], 2);
  });
}
```

> `http_mock_adapter` の `If-None-Match` マッチャは版依存。304 body 復元アサート (`second.data`) が本質。ヘッダマッチが効かなければ Task 0 解決版の仕様に合わせ capture 方式へ調整。

- [ ] **Step 2: 緑** — Run: `cd packages/cache && dart test test/http/http_cache_interceptor_test.dart` → PASS

- [ ] **Step 3: HttpCacheLog 追加 (app)**

`app/lib/core/provider/log/talker.dart` の `GoRouterLog` 直後に:
```dart
class HttpCacheLog extends TalkerLog {
  HttpCacheLog(super.message);
  @override
  String get title => 'HttpCache';
  @override
  final pen = AnsiPen()..blue();
}
```

- [ ] **Step 4: analyze + Commit**

Run: `cd packages/cache && dart analyze && cd ../../app && dart analyze lib/core/provider/log/talker.dart` → No issues
```bash
git add packages/cache/test/http/http_cache_interceptor_test.dart app/lib/core/provider/log/talker.dart
git commit -m "feat(cache): add ETag/304 integration test + HttpCacheLog"
```

---

## Task 4: app に `httpCacheStore` provider + dioProvider 登録

`packages/cache` を app の依存に加え、`DriftCacheStore` を生成して `HttpCacheStore` で包む Riverpod provider を app に置く。`DioCacheInterceptor` を `TalkerDioLogger` の**前**に登録する。

**Files:**
- Modify: `app/pubspec.yaml`
- Create: `app/lib/core/api/http_cache_store_provider.dart`
- Modify: `app/lib/core/provider/dio_provider.dart`
- Test: `app/test/core/api/http_cache_store_provider_test.dart`

**Interfaces:**
- Consumes: `package:cache/cache.dart` の `HttpCacheStore`/`buildHttpCacheKey`/`kHttpCacheSchemaVersion`、`DriftCacheStore`、`packageInfoProvider`。
- Produces: `@Riverpod(keepAlive: true) HttpCacheStore httpCacheStore(Ref ref)`。`dioProvider` の Dio が ETag/304 を透過処理。計画D が `ref.watch(httpCacheStoreProvider)` で消費。

- [ ] **Step 1: app に cache 依存追加**

`app/pubspec.yaml` の `dependencies` に:
```yaml
  cache:
    path: ../packages/cache
```
Run: `cd app && flutter pub get` → 成功

- [ ] **Step 2: 失敗テスト (provider が HttpCacheStore を供給)**

`app/test/core/api/http_cache_store_provider_test.dart`:
```dart
import 'package:cache/cache.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  test('httpCacheStore が HttpCacheStore を供給し appBuild を組む', () {
    final container = ProviderContainer(overrides: [
      packageInfoProvider.overrideWithValue(
        PackageInfo(appName: 'x', packageName: 'x', version: '3.0.0', buildNumber: '100'),
      ),
    ]);
    addTearDown(container.dispose);
    final store = container.read(httpCacheStoreProvider);
    expect(store, isA<HttpCacheStore>());
    expect(store.appBuild, '3.0.0+100');
    expect(store.schemaVersion, kHttpCacheSchemaVersion);
  });
}
```

> `packageInfoProvider` の型/override 方法は `app/lib/core/provider/package_info.dart` を Read して合わせる。`DriftCacheStore` がパスを要求し test で生成困難なら、provider を「store ファクトリ注入」に分けず、テストでは `appBuild`/`schemaVersion` のみ検証 (DriftCacheStore 生成は実機/統合で担保) する。

- [ ] **Step 3: 失敗確認** — Run: `cd app && flutter test test/core/api/http_cache_store_provider_test.dart` → FAIL

- [ ] **Step 4: provider 実装**

`app/lib/core/api/http_cache_store_provider.dart`:
```dart
import 'dart:async';

import 'package:cache/cache.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:http_cache_drift_store/http_cache_drift_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_cache_store_provider.g.dart';

@Riverpod(keepAlive: true)
HttpCacheStore httpCacheStore(Ref ref) {
  final package = ref.watch(packageInfoProvider);
  final appBuild = '${package.version}+${package.buildNumber}';
  final store = DriftCacheStore(databasePath: _httpCacheDatabasePath);
  ref.onDispose(() => unawaited(store.close()));
  return HttpCacheStore(
    store: store,
    schemaVersion: kHttpCacheSchemaVersion,
    appBuild: appBuild,
  );
}
```

> **DriftCacheStore のパス引数**: Task 0 Step 5 の確認に合わせる。`databaseName` のみ受ける版なら `DriftCacheStore(databaseName: 'http_cache')` とし `_httpCacheDatabasePath` を削除 (同期で確定でき最適)。絶対パス必須なら provider を `FutureProvider` 化し `getApplicationSupportDirectory()` を await。**その場合は契約書 §3 と計画D へ「戻り値型変更 (`httpCacheStoreProvider.future`)」を連絡**。同期確定を最優先。

Run: `cd app && dart run build_runner build --delete-conflicting-outputs` → `http_cache_store_provider.g.dart` 生成。

- [ ] **Step 5: 緑** — Run: `cd app && flutter test test/core/api/http_cache_store_provider_test.dart` → PASS

- [ ] **Step 6: dioProvider に DioCacheInterceptor 登録**

`app/lib/core/provider/dio_provider.dart` に import 追加:
```dart
import 'package:cache/cache.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
```
`deviceAuthTokenInterceptor` の watch 後に `httpCacheStore` を取得し、interceptor 登録列を次の順 (`DioCacheInterceptor` を `TalkerDioLogger` の直前):
```dart
  final httpCache = ref.watch(httpCacheStoreProvider);
  // ...
  dio.interceptors.add(AppCheckInterceptor());
  dio.interceptors.add(DeviceIdInterceptor(deviceId: deviceId));
  dio.interceptors.add(deviceAuthTokenInterceptor);
  dio.interceptors.add(
    DioCacheInterceptor(
      options: CacheOptions(
        store: httpCache.store,
        policy: CachePolicy.refreshForceCache,
        keyBuilder: (options) => buildHttpCacheKey(
          schemaVersion: httpCache.schemaVersion,
          appBuild: httpCache.appBuild,
          options: options,
        ),
      ),
    ),
  );
  dio.interceptors.add(TalkerDioLogger(/* 既存設定のまま */));
```

> `CacheOptions` は GET 以外を既定でキャッシュしない (`allowPostMethod` 既定 false)。登録順の根拠: `add` 順に `onRequest`、`onResponse` は逆順 → `DioCacheInterceptor` を先に add すると req 時にキャッシュ判定→ログ、res 時にログ→キャッシュ保存/復元。「`TalkerDioLogger` の前」を満たす。

- [ ] **Step 7: analyze + 回帰 + Commit**

Run: `cd app && dart analyze lib/core && flutter test test/core/`
Expected: No issues / PASS (既存 `dio_list_format_test` 等含め緑)
```bash
git add app/pubspec.yaml app/lib/core/api/http_cache_store_provider.dart app/lib/core/api/http_cache_store_provider.g.dart app/lib/core/provider/dio_provider.dart app/test/core/api/http_cache_store_provider_test.dart
git commit -m "feat(app): wire DioCacheInterceptor (ETag/304) via packages/cache HttpCacheStore"
```

---

## Task 5: PR 作成

- [ ] **Step 1: ブランチ確認・全 analyze・全テスト・format**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
git branch --show-current   # develop でないこと (例: feat/etag-304-cache-package)
melos run analyze
cd packages/cache && dart test && cd ../../app && flutter test
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor && dart format --set-exit-if-changed packages/cache app/lib/core/api app/lib/core/provider
```
Expected: 全 PASS / No issues

- [ ] **Step 2: PR 作成**

```bash
gh pr create --repo YumNumm/EQMonitor --base develop \
  --title "feat(cache): new packages/cache + ETag/304 dio interceptor (計画C)" \
  --body "計画C。packages/cache を新設し ETag/304 横断キャッシュ (dio_cache_interceptor + http_cache_drift_store) を導入。backend 非依存。設計: docs/superpowers/specs/2026-06-23-earthquake-swr-cache-design.md セクション6。後続: 計画D が packages/cache に Drift SWR を追加。"
```

---

## Self-Review

**1. Spec coverage (契約書 §0/§3 + 設計セクション6):**
- `packages/cache` 新設 (Riverpod 非依存) → Task 0。
- `dio_cache_interceptor` + Drift ストア (`http_cache_drift_store`、旧 db_store は discontinued) → Task 0。
- `buildHttpCacheKey` + `kHttpCacheSchemaVersion` 名前空間化 → Task 1 (packages/cache)。
- `HttpCacheStore`(`evict`/`clearAll`/`primaryKeyForUrl`) → Task 2 (packages/cache、Riverpod 無し)。
- ETag 保存・If-None-Match 再送・304 復元・200 更新・名前空間化テスト → Task 1/3。
- `HttpCacheLog` (typed talker) → Task 3 (app)。
- `httpCacheStore` provider (app、1ファイル1公開) + `dioProvider` 登録 (`TalkerDioLogger` の前、`refreshForceCache`、GET のみ) → Task 4 (app)。

**2. Placeholder scan:** 全コードステップに実コード記載。バージョン/`DriftCacheStore` API は Task 0 の確認ステップで実値固定 (placeholder ではなく検証手順)。

**3. Type consistency:**
- `buildHttpCacheKey({schemaVersion, appBuild, options})` を Task 1 定義 → Task 2 (`primaryKeyForUrl`)・Task 4 (interceptor keyBuilder) で同一使用。
- `HttpCacheStore.store/schemaVersion/appBuild` を Task 2 公開 → Task 4 が参照。
- `httpCacheStoreProvider` を Task 4 産出 → 計画D が消費。契約書 §3 の D 消費 API (`evict`/`clearAll`/`primaryKeyForUrl`/`kHttpCacheSchemaVersion`/`httpCacheStore`) と一致。
- パッケージ境界: `packages/cache` は Riverpod/app を import しない (provider は app)。契約書 §0 と一致。

**4. 懸念点 (実装者へ申し送り):**
- `http_cache_drift_store` の `DriftCacheStore` コンストラクタ (`databasePath` vs `databaseName`) が同期 Provider で確定できない場合、Task 4 のノートで `databaseName` 版優先 → 不可なら `FutureProvider` 化 + 契約書/計画D へ連絡。
- `CacheOptions.defaultCacheKeyBuilder` / `CacheResponse` / `MemCacheStore` のフィールド名は Task 0 Step 5 で確定。
- `http_mock_adapter` の `If-None-Match` マッチャは版依存 (304 復元アサートが本質)。
- melos workspace は `packages/*` glob で自動認識。`melos bootstrap` 後に IDE/analyzer が新パッケージを解決することを確認。
