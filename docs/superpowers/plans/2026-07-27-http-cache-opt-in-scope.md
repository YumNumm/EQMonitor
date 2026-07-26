# HTTP Cache Opt-in Scope Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** HTTPキャッシュを専用APIクライアントへの明示的なオプトインに限定し、paging・検索・ユーザー固有・Realtime GETを永続保存しない。

**Architecture:** 認証や通信設定を共有する `ApiDioFactory` から、キャッシュなしの通常Dioと `HttpCacheInterceptor` を持つ専用Dioを構築する。`CachedNotifier` だけがcache-only読み出しと専用Dioによる再検証を使い、Feed一覧を含むpaging経路は通常クライアントへ戻す。旧バージョンの広範囲なエントリは、バージョン付き移行処理で一度だけ全消去する。

**Tech Stack:** Flutter、Dart、Riverpod 3、Dio、Drift、SharedPreferences、flutter_test、EQMonitor `packages/cache`

## Global Constraints

- Flutter / Dartコマンドは必ず `mise exec --` 経由で実行する。
- HTTPキャッシュは承認済みの非paging GETだけが明示的に利用する。
- cursor、page、またはpaging目的のlimitを使うAPIはすべて対象外とする。
- ユーザー固有API、Realtime API、今後追加される未指定GETは既定で対象外とする。
- キャッシュ無効化中は読み出し、保存、`If-None-Match`、304復元をすべて停止する。
- キャッシュDBまたは移行が失敗しても固定値へフォールバックせず、ネットワーク取得へ縮退する。
- 地震詳細はRealtime upsert/deleteとデバッグoverrideをstale HTTPキャッシュより優先する。
- SharedPreferencesキーは `SharedPreferencesKey` enumで管理する。
- `dynamic`、`Object` 型の新規利用と `!` 演算子を避ける。
- ユーザー所有の `backend` サブモジュール差分と未追跡設定ファイルをステージしない。

## File Map

- `app/lib/core/api/http_cache_migrator.dart`: 旧HTTPキャッシュを一度だけ消去する移行ロジック。
- `app/lib/core/api/http_cache_store_provider.dart`: DBを開き、移行完了後のstoreだけを公開する。
- `app/lib/core/provider/api_dio_factory.dart`: 共通設定・認証・ログを持つDioを組み立てる単一責務のfactory。
- `app/lib/core/provider/dio_provider.dart`: キャッシュなし通常Dioを公開する。
- `app/lib/core/provider/http_cached_dio_provider.dart`: キャッシュ対応Dioを公開し、store失敗時はキャッシュなしへ縮退する。
- `app/lib/core/api/http_cached_api_client_provider.dart`: cache-first再検証用 `ApiClient` を公開する。
- `app/lib/core/provider/cache_only_dio_provider.dart`: キャッシュ無効時はDBを読まず、必ずcache missを返す。
- `app/lib/core/provider/cached_notifier.dart`: cache-only読み出し後の再検証先を専用クライアントへ切り替える。
- `app/lib/feature/feed/data/notifier/feed_notifier.dart`: Home用Feed初回取得を通常ネットワーク専用にする。
- `app/lib/feature/feed/data/notifier/feed_data_source.dart`: Feed pagingを通常ネットワーク専用にする。
- `app/lib/feature/feed/ui/page/feed_page.dart`: paging向け再検証バナーを撤去する。
- `packages/cache/lib/src/http/cache_only_interceptor.dart`: キャッシュ無効時にstoreなしでmissを返すconstructorを提供する。
- `docs/knowledge/20260727_http_cache_opt_in_scope.md`: 今後のHTTPキャッシュ対象選定ルールを記録する。

---

### Task 1: 旧HTTPキャッシュの一回限り移行

**Files:**
- Create: `app/lib/core/api/http_cache_migrator.dart`
- Modify: `app/lib/core/api/http_cache_store_provider.dart`
- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`
- Test: `app/test/core/api/http_cache_migrator_test.dart`

**Interfaces:**
- Consumes: `HttpCacheStore.clearAll()`、`SharedPreferencesDataSource.getInt()`、`SharedPreferencesDataSource.setInt()`。
- Produces: `const kHttpCacheScopeMigrationVersion = 1`、`HttpCacheMigrator.migrate(): Future<void>`。Task 2のキャッシュ対応Dioは、移行済み `httpCacheStoreProvider` だけを受け取る。

- [ ] **Step 1: 移行の失敗テストと一回限り実行テストを書く**

`app/test/core/api/http_cache_migrator_test.dart` を作成する。`dart:convert`、
`dart:typed_data`、`cache/cache.dart`、`dio/dio.dart`、`drift/native.dart`、
SharedPreferences data source/key、`shared_preferences`、`flutter_test` をimportする。
in-memory Drift DBと `SharedPreferences.setMockInitialValues` を使い、次を具体的に検証する。

```dart
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

HttpCacheEntry _entry(String key) => HttpCacheEntry(
  key: key,
  statusCode: 200,
  eTag: 'W/"$key"',
  headers: const {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
  responseType: 'json',
  body: Uint8List.fromList(utf8.encode('{"value":"$key"}')),
  updatedAtMs: 0,
);
```

削除callbackを例外にし、versionが保存されず例外が伝播するテストも追加する。

```dart
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
```

- [ ] **Step 2: テストが失敗することを確認する**

Run:

```bash
cd app
mise exec -- flutter test test/core/api/http_cache_migrator_test.dart
```

Expected: `HttpCacheMigrator` と `httpCacheScopeMigrationVersion` が未定義でFAIL。

- [ ] **Step 3: キーと移行クラスを最小実装する**

`SharedPreferencesKey` にsnake_case値を追加する。

```dart
httpCacheScopeMigrationVersion('http_cache_scope_migration_version'),
```

`app/lib/core/api/http_cache_migrator.dart` を作成する。

```dart
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';

const kHttpCacheScopeMigrationVersion = 1;

final class HttpCacheMigrator {
  const HttpCacheMigrator({
    required this.clearCache,
    required this.dataSource,
  });

  final Future<void> Function() clearCache;
  final SharedPreferencesDataSource dataSource;

  Future<void> migrate() async {
    final current = await dataSource.getInt(
      key: SharedPreferencesKey.httpCacheScopeMigrationVersion,
    );
    if ((current ?? 0) >= kHttpCacheScopeMigrationVersion) {
      return;
    }
    await clearCache();
    await dataSource.setInt(
      key: SharedPreferencesKey.httpCacheScopeMigrationVersion,
      value: kHttpCacheScopeMigrationVersion,
    );
  }
}
```

- [ ] **Step 4: store providerを移行完了ゲートにする**

`httpCacheStoreProvider` でDBとstoreを作った後、`sharedPreferencesDataSourceProvider.future` を取得して `migrate()` をawaitする。失敗時はDBをcloseしてrethrowし、未移行storeを公開しない。

```dart
final store = HttpCacheStore(
  db: db,
  schemaVersion: kHttpCacheSchemaVersion,
  appBuild: '${package.version}+${package.buildNumber}',
);
try {
  final dataSource = await ref.watch(
    sharedPreferencesDataSourceProvider.future,
  );
  await HttpCacheMigrator(
    clearCache: store.clearAll,
    dataSource: dataSource,
  ).migrate();
} on Object {
  await db.close();
  rethrow;
}
ref.onDispose(db.close);
return store;
```

- [ ] **Step 5: テストと静的解析を通す**

Run:

```bash
cd app
mise exec -- flutter test test/core/api/http_cache_migrator_test.dart
mise exec -- flutter analyze --no-pub lib/core/api/http_cache_migrator.dart lib/core/api/http_cache_store_provider.dart lib/core/data/preferences/shared/shared_preferences_key.dart test/core/api/http_cache_migrator_test.dart
```

Expected: 全テストPASS、`No issues found!`。

- [ ] **Step 6: Task 1をコミットする**

```bash
git add app/lib/core/api/http_cache_migrator.dart app/lib/core/api/http_cache_store_provider.dart app/lib/core/data/preferences/shared/shared_preferences_key.dart app/test/core/api/http_cache_migrator_test.dart
git commit -m "fix: 旧HTTPキャッシュを初回移行で削除"
```

---

### Task 2: 通常Dioとキャッシュ対応Dioの分離

**Files:**
- Create: `app/lib/core/provider/api_dio_factory.dart`
- Create: `app/lib/core/provider/http_cached_dio_provider.dart`
- Create: `app/lib/core/api/http_cached_api_client_provider.dart`
- Modify: `app/lib/core/provider/dio_provider.dart`
- Modify: `app/lib/core/provider/cache_only_dio_provider.dart`
- Modify: `packages/cache/lib/src/http/cache_only_interceptor.dart`
- Test: `app/test/core/provider/api_dio_factory_test.dart`
- Test: `app/test/core/provider/http_cached_dio_provider_test.dart`
- Test: `packages/cache/test/http/cache_only_interceptor_test.dart`
- Regenerate: `app/lib/core/provider/api_dio_factory.g.dart`
- Regenerate: `app/lib/core/provider/http_cached_dio_provider.g.dart`
- Regenerate: `app/lib/core/api/http_cached_api_client_provider.g.dart`

**Interfaces:**
- Consumes: Task 1の移行済み `httpCacheStoreProvider.future`。
- Produces: `ApiDioFactory.build({HttpCacheStore? httpCacheStore}): Dio`、`httpCachedDioProvider`、`httpCachedApiClientProvider`、`CacheOnlyInterceptor.disabled()`。Task 3の `CachedNotifier` が後者2providerを使用する。

- [ ] **Step 1: factory境界の失敗テストを書く**

`app/test/core/provider/api_dio_factory_test.dart` に、通常DioとキャッシュDioのインターセプタ境界を記述する。

```dart
test('通常DioにはHTTPキャッシュがなく、キャッシュDioだけに1個ある', () {
  final db = CacheDatabase(NativeDatabase.memory());
  addTearDown(db.close);
  final store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: 'test');
  final base = Interceptor();
  final factory = ApiDioFactory(
    baseUrl: 'https://example.com',
    headers: const {'x-eqmonitor-version': 'test'},
    baseInterceptors: [base],
  );

  final normal = factory.build();
  final cached = factory.build(httpCacheStore: store);

  expect(normal.interceptors.whereType<HttpCacheInterceptor>(), isEmpty);
  expect(cached.interceptors.whereType<HttpCacheInterceptor>(), hasLength(1));
  expect(normal.interceptors, contains(base));
  expect(cached.interceptors, contains(base));
});
```

同じテストでcache interceptorが `TalkerDioLogger` より前にあること、共通BaseOptionsのtimeout・content type・list formatが一致することも検証する。

`app/test/core/provider/http_cached_dio_provider_test.dart` では、無効化中に
`httpCacheStoreProvider` を読まないことをprovider境界で固定する。

```dart
final class _DisabledHttpCache extends HttpCacheDisabled {
  @override
  Future<bool> build() async => true;
}

test('無効化中はstoreを読まずcacheなしDioを返す', () async {
  final factory = ApiDioFactory(
    baseUrl: 'https://example.com',
    headers: const {},
    baseInterceptors: const [],
  );
  final container = ProviderContainer(
    overrides: [
      apiDioFactoryProvider.overrideWith((ref) async => factory),
      httpCacheDisabledProvider.overrideWith(_DisabledHttpCache.new),
      httpCacheStoreProvider.overrideWith(
        (ref) async => throw StateError('store must not be read'),
      ),
    ],
  );
  addTearDown(container.dispose);

  final dio = await container.read(httpCachedDioProvider.future);

  expect(dio.interceptors.whereType<HttpCacheInterceptor>(), isEmpty);
});
```

- [ ] **Step 2: disabled cache-onlyの失敗テストを書く**

`packages/cache/test/http/cache_only_interceptor_test.dart` に追加する。

```dart
test('disabled constructorはstoreなしで必ずcache missを返す', () async {
  final dio = Dio()
    ..interceptors.add(CacheOnlyInterceptor.disabled())
    ..httpClientAdapter = _FailIfCalledAdapter();

  await expectLater(
    dio.get<Map<String, Object?>>('https://example.com/value'),
    throwsA(
      isA<DioException>().having(
        (e) => e.error,
        'error',
        isA<CacheMissException>(),
      ),
    ),
  );
});
```

`_FailIfCalledAdapter.fetch` は `StateError('network must not be called')` を投げる。これにより無効時にDBもnetworkも使わないことを固定する。

```dart
final class _FailIfCalledAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) => throw StateError('network must not be called');

  @override
  void close({bool force = false}) {}
}
```

- [ ] **Step 3: テストが失敗することを確認する**

Run:

```bash
cd packages/cache
mise exec -- flutter test test/http/cache_only_interceptor_test.dart
cd ../../app
mise exec -- flutter test test/core/provider/api_dio_factory_test.dart
```

Expected: factoryとdisabled constructorが未定義でFAIL。

- [ ] **Step 4: `CacheOnlyInterceptor.disabled()` を実装する**

storeをnullable fieldとして保持し、request冒頭でlocal variableへ束縛する。nullなら既存と同じ `CacheMissException` をrejectし、`!` は使用しない。

```dart
class CacheOnlyInterceptor extends Interceptor {
  CacheOnlyInterceptor(HttpCacheStore store) : _store = store;
  CacheOnlyInterceptor.disabled() : _store = null;

  final HttpCacheStore? _store;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final cacheMiss = DioException(
      requestOptions: options,
      error: const CacheMissException(),
      type: .cancel,
      message: 'Cacheミスのため、リクエストをキャンセルします',
      stackTrace: StackTrace.current,
    );
    final store = _store;
    if (options.method.toUpperCase() != 'GET' || store == null) {
      handler.reject(cacheMiss);
      return;
    }
    final cached = await store.read(store.primaryKeyForUrl(options));
    if (cached == null) {
      handler.reject(cacheMiss);
      return;
    }
    handler.resolve(restoreResponse(options, cached));
  }
}
```

- [ ] **Step 5: `ApiDioFactory` とproviderを実装する**

`ApiDioFactory` はbase URL、headers、base interceptorsをconstructorで受け、Dio生成だけを担う。`build` ではcacheをTalker loggerより前に追加する。

```dart
final class ApiDioFactory {
  const ApiDioFactory({
    required this.baseUrl,
    required this.headers,
    required this.baseInterceptors,
  });

  final String baseUrl;
  final Map<String, String> headers;
  final List<Interceptor> baseInterceptors;

  Dio build({HttpCacheStore? httpCacheStore}) {
    final dio = Dio(buildApiBaseOptions(baseUrl: baseUrl));
    dio.options
      ..headers.addAll(headers)
      ..connectTimeout = const Duration(seconds: 10)
      ..sendTimeout = const Duration(seconds: 10);
    dio.interceptors.addAll(baseInterceptors);
    if (httpCacheStore != null) {
      dio.interceptors.add(HttpCacheInterceptor(httpCacheStore));
    }
    dio.interceptors.add(
      TalkerDioLogger(
        settings: TalkerDioLoggerSettings(
          errorPen: AnsiPen()..red(),
          requestPen: AnsiPen()..yellow(),
          responsePen: AnsiPen()..green(),
          printRequestHeaders: true,
          hiddenHeaders: {'X-Firebase-AppCheck', 'Authorization'},
          printResponseData: false,
          printErrorMessage: false,
        ),
        talker: talker,
      ),
    );
    return dio;
  }
}
```

同じファイルのRiverpod providerで、現在の `dioProvider` が集めているApp Check、device ID、device auth、Chuckを `baseInterceptors` に組み立てる。テストでは生成結果に `TalkerDioLogger` があり、cache interceptorより後ろに並ぶことを確認する。

```dart
@Riverpod(keepAlive: true)
Future<ApiDioFactory> apiDioFactory(Ref ref) async {
  final package = ref.watch(packageInfoProvider);
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  final baseInterceptors = <Interceptor>[
    ref.watch(appCheckInterceptorProvider),
    await ref.watch(deviceIdInterceptorProvider.future),
    await ref.watch(deviceAuthTokenInterceptorProvider.future),
  ];
  if (chuckBuildModePolicy.captureTraffic) {
    baseInterceptors.add(ref.watch(chuckProvider).dioInterceptor);
  }
  return ApiDioFactory(
    baseUrl: telegramUrl.restApiUrl,
    headers: {
      'x-eqmonitor-version': '${package.version}+${package.buildNumber}',
      'x-eqmonitor-platform': Platform.isAndroid ? 'android' : 'ios',
    },
    baseInterceptors: baseInterceptors,
  );
}
```

`dioProvider` は次だけに縮小する。

```dart
@Riverpod(keepAlive: true)
Future<Dio> dio(Ref ref) async {
  final factory = await ref.watch(apiDioFactoryProvider.future);
  return factory.build();
}
```

`httpCachedDioProvider` は無効時にcacheなしDioを返し、storeまたは移行失敗もログ後にcacheなしへ縮退する。

```dart
@Riverpod(keepAlive: true)
Future<Dio> httpCachedDio(Ref ref) async {
  final factory = await ref.watch(apiDioFactoryProvider.future);
  final disabled = await ref.watch(httpCacheDisabledProvider.future);
  if (disabled) {
    return factory.build();
  }
  try {
    final store = await ref.watch(httpCacheStoreProvider.future);
    return factory.build(httpCacheStore: store);
  } on Object catch (error, stackTrace) {
    talker.warning('HTTPキャッシュを利用できないため通常通信へ切り替えます', error, stackTrace);
    return factory.build();
  }
}
```

`httpCachedApiClientProvider` はこのDioから `ApiClient` を作る。

```dart
@Riverpod(keepAlive: true)
Future<ApiClient> httpCachedApiClient(Ref ref) async {
  final dio = await ref.watch(httpCachedDioProvider.future);
  return ApiClient(dio);
}
```

- [ ] **Step 6: cache-only providerに無効化ゲートを追加する**

`httpCacheDisabledProvider.future` をstoreより先に評価する。無効なら `CacheOnlyInterceptor.disabled()` を登録してreturnし、DBを開かない。有効時だけ移行済みstoreをwatchする。

```dart
final disabled = await ref.watch(httpCacheDisabledProvider.future);
final telegramUrl = await ref.watch(telegramUrlProvider.future);
final dio = Dio(buildApiBaseOptions(baseUrl: telegramUrl.restApiUrl));
if (disabled) {
  dio.interceptors.add(CacheOnlyInterceptor.disabled());
  return dio;
}
final store = await ref.watch(httpCacheStoreProvider.future);
dio.interceptors.add(CacheOnlyInterceptor(store));
return dio;
```

- [ ] **Step 7: Riverpodコードを生成する**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: 新providerの `.g.dart` が生成される。今回のprovider変更と無関係な生成差分はステージしない。

- [ ] **Step 8: package/appテストと解析を通す**

Run:

```bash
cd packages/cache
mise exec -- flutter test test/http/cache_only_interceptor_test.dart test/http/http_cache_interceptor_test.dart test/http/force_fresh_test.dart
cd ../../app
mise exec -- flutter test test/core/provider/api_dio_factory_test.dart test/core/provider/http_cached_dio_provider_test.dart
mise exec -- flutter analyze --no-pub lib/core/provider/api_dio_factory.dart lib/core/provider/dio_provider.dart lib/core/provider/http_cached_dio_provider.dart lib/core/provider/cache_only_dio_provider.dart lib/core/api/http_cached_api_client_provider.dart test/core/provider/api_dio_factory_test.dart test/core/provider/http_cached_dio_provider_test.dart
```

Expected: 全テストPASS、`No issues found!`。

- [ ] **Step 9: Task 2をコミットする**

生成物を含め、次のファイルだけをステージし、`git status` と `git diff --cached` で境界を確認してからコミットする。

```bash
git add packages/cache/lib/src/http/cache_only_interceptor.dart packages/cache/test/http/cache_only_interceptor_test.dart app/lib/core/provider/api_dio_factory.dart app/lib/core/provider/api_dio_factory.g.dart app/lib/core/provider/dio_provider.dart app/lib/core/provider/http_cached_dio_provider.dart app/lib/core/provider/http_cached_dio_provider.g.dart app/lib/core/provider/cache_only_dio_provider.dart app/lib/core/api/http_cached_api_client_provider.dart app/lib/core/api/http_cached_api_client_provider.g.dart app/test/core/provider/api_dio_factory_test.dart app/test/core/provider/http_cached_dio_provider_test.dart
git commit -m "refactor: HTTPキャッシュ専用APIクライアントを分離"
```

---

### Task 3: cache-first providerを専用クライアントへ接続

**Files:**
- Modify: `app/lib/core/provider/cached_notifier.dart`
- Modify tests that override cache/network clients:
  - `app/test/core/provider/cached_notifier_test.dart`
  - `app/test/feature/changelog/changelog_repository_cache_key_test.dart`
  - `app/test/feature/feed/feed_by_source_provider_test.dart`
  - `app/test/feature/intensity_history/city_highest_notifier_test.dart`
  - `app/test/feature/earthquake_history/data/earthquake_debug_override_notifier_test.dart`
  - `app/test/feature/earthquake_history/earthquake_history_realtime_details_test.dart`
  - `app/test/feature/earthquake_history/ui/earthquake_history_debug_sheet_test.dart`

**Interfaces:**
- Consumes: Task 2の `httpCachedApiClientProvider` と `httpCachedDioProvider`。
- Produces: `CachedNotifier.cachedBuild()` がcache-only hit後も専用クライアントだけで再検証し、`_fetchForceFresh()` も専用Dioを複製する。start、changelog、parameter、最大震度、地震詳細、電文詳細、Feed個別詳細がこの経路を共有する。

- [ ] **Step 1: `CachedNotifier` のクライアント境界テストを先に変更する**

`cached_notifier_test.dart` の `_normalClient` を `_httpCachedClient` に改名し、対応するDioを `_httpCachedDio` として保持する。provider overrideを新providerへ変更し、通常 `apiClientProvider` には呼ばれたら失敗するoverrideを置く。

```dart
httpCachedApiClientProvider.overrideWith((ref) async => _httpCachedClient),
httpCachedDioProvider.overrideWith((ref) async => _httpCachedDio),
apiClientProvider.overrideWith(
  (ref) async => throw StateError('normal ApiClient must not be used'),
),
```

cache miss、cache hit後の背景更新、corrupt cache後のforce-freshの各テストが `_httpCachedClient` から値を得ることをassertする。

- [ ] **Step 2: 変更前テストが失敗することを確認する**

Run:

```bash
cd app
mise exec -- flutter test test/core/provider/cached_notifier_test.dart
```

Expected: 現行 `CachedNotifier` が `apiClientProvider` / `dioProvider` を読むためFAIL。

- [ ] **Step 3: `CachedNotifier` の再検証先を置き換える**

通常取得3箇所を `httpCachedApiClientProvider.future` へ変更し、force-freshの元Dioを `httpCachedDioProvider.future` へ変更する。

```dart
await fetch(await ref.read(httpCachedApiClientProvider.future))
```

```dart
final cachedDio = await ref.read(httpCachedDioProvider.future);
final dio = Dio(cachedDio.options);
dio.interceptors.add(ForceFreshInterceptor());
dio.interceptors.addAll(cachedDio.interceptors);
```

cache-only読み出しは `cacheOnlyApiClientProvider` のまま維持する。Task 2の無効化ゲートにより、無効時はcache missとなってcacheなし専用Dioへ進む。

- [ ] **Step 4: 対象providerテストのoverrideを新providerへ更新する**

上記Files一覧の各テストで、fresh/revalidate用overrideを `httpCachedApiClientProvider` と `httpCachedDioProvider` に変更する。地震詳細テストでは既存のRealtime優先assertを一切弱めない。

- [ ] **Step 5: cache-first回帰テストを実行する**

Run:

```bash
cd app
mise exec -- flutter test test/core/provider/cached_notifier_test.dart test/feature/changelog/changelog_repository_cache_key_test.dart test/feature/feed/feed_by_source_provider_test.dart test/feature/intensity_history/city_highest_notifier_test.dart test/feature/earthquake_history/data/earthquake_debug_override_notifier_test.dart test/feature/earthquake_history/earthquake_history_realtime_details_test.dart test/feature/earthquake_history/ui/earthquake_history_debug_sheet_test.dart test/feature/parameter/parameter_repository_refresh_test.dart
mise exec -- flutter analyze --no-pub lib/core/provider/cached_notifier.dart test/core/provider/cached_notifier_test.dart
```

Expected: cache-first、304復元、Realtime優先を含め全テストPASS。

- [ ] **Step 6: Task 3をコミットする**

```bash
git add app/lib/core/provider/cached_notifier.dart app/test/core/provider/cached_notifier_test.dart app/test/feature/changelog/changelog_repository_cache_key_test.dart app/test/feature/feed/feed_by_source_provider_test.dart app/test/feature/intensity_history/city_highest_notifier_test.dart app/test/feature/earthquake_history/data/earthquake_debug_override_notifier_test.dart app/test/feature/earthquake_history/earthquake_history_realtime_details_test.dart app/test/feature/earthquake_history/ui/earthquake_history_debug_sheet_test.dart
git commit -m "refactor: cache-first取得を専用クライアントへ接続"
```

---

### Task 4: Feed一覧とpaging cache-firstの撤去

**Files:**
- Modify: `app/lib/feature/feed/data/notifier/feed_notifier.dart`
- Modify: `app/lib/feature/feed/data/notifier/feed_data_source.dart`
- Modify: `app/lib/feature/feed/ui/page/feed_page.dart`
- Modify: `app/test/feature/feed/feed_notifier_test.dart`
- Modify: `app/test/feature/feed/feed_data_source_test.dart`
- Delete: `app/lib/core/paging/cache_first_refresh.dart`
- Delete: `app/test/core/paging/cache_first_refresh_test.dart`

**Interfaces:**
- Consumes: 通常の `FeedRepository.fetch({String? after, ApiClient? client})`。`client` を省略するとrepositoryが保持する通常 `ApiClient` を使う。
- Produces: Feedの初回一覧と追加ページが常に `client == null` でrepositoryへ入り、HTTPキャッシュ経路を利用しない。

- [ ] **Step 1: FeedNotifierをネットワーク専用とする失敗テストを書く**

`feed_notifier_test.dart` のcache hit/missテストを削除し、fake repositoryで受け取った `client` とcursorを記録する。

```dart
test('初回取得はcache-only clientを渡さない', () async {
  final repository = _RecordingFeedRepository();
  final container = _container(repository);
  addTearDown(container.dispose);

  final result = await container.read(feedProvider.future);

  expect(result.items.first.id, 'fresh-1');
  expect(repository.clients, [null]);
  expect(repository.cursors, [null]);
});

test('次ページもcursorだけを渡しcache clientを渡さない', () async {
  final repository = _RecordingFeedRepository(nextCursor: 'next-1');
  final container = _container(repository);
  addTearDown(container.dispose);
  await container.read(feedProvider.future);

  await container.read(feedProvider.notifier).fetchNextData();

  expect(repository.clients, [null, null]);
  expect(repository.cursors, [null, 'next-1']);
});
```

- [ ] **Step 2: FeedDataSourceのpagingテストをネットワーク専用へ書き換える**

`upsertItems` のテストを、RefreshとAppendが `client == null` で正しいcursorを渡すテストへ置き換える。

```dart
test('RefreshとAppendは通常repositoryだけを使う', () async {
  final repository = _RecordingFeedRepository();
  final dataSource = FeedDataSource(repository: repository);
  addTearDown(dataSource.dispose);

  await dataSource.refresh();
  await dataSource.load(Append(key: 'cursor-1'));

  expect(repository.clients, [null, null]);
  expect(repository.cursors, [null, 'cursor-1']);
});
```

- [ ] **Step 3: 変更前テストが失敗することを確認する**

Run:

```bash
cd app
mise exec -- flutter test test/feature/feed/feed_notifier_test.dart test/feature/feed/feed_data_source_test.dart
```

Expected: 現行実装がcache-only clientを渡す、または新constructorと一致せずFAIL。

- [ ] **Step 4: FeedNotifierから `CachedNotifier` を外す**

`build()` でrepositoryの通常取得をawaitし、既存state型へ変換する。`fetchNextData()` は通常repository利用を維持する。

```dart
@riverpod
class FeedNotifier extends _$FeedNotifier {
  @override
  Future<FeedNotifierState> build() async {
    final repository = await ref.watch(feedRepositoryProvider.future);
    final response = await repository.fetch();
    return (items: response.feeds, nextCursor: response.nextCursor);
  }

  // fetchNextData は既存のguardPlusとcursor処理を維持する。
}
```

- [ ] **Step 5: FeedDataSourceを通常pagingだけに単純化する**

providerとconstructorから `cacheOnlyClient` を削除する。`Refresh()` は `_fetch(null)`、`Append(key)` は `_fetch(key)` とする。`isRevalidating`、`upsertItems`、disposeフラグ、cache-first importsを削除する。

```dart
@override
Future<LoadResult<String?, FeedItem>> load(
  LoadAction<String?> action,
) async => switch (action) {
  Refresh() => await _fetch(null),
  Append(:final key) => await _fetch(key),
  Prepend() => const None(),
};
```

- [ ] **Step 6: paging専用helperとFeed再検証表示を削除する**

利用箇所が0になる `cache_first_refresh.dart` と対応テストを削除する。`feed_page.dart` から `RevalidatingBanner` と関連importを削除する。地震履歴ページの `RevalidatingBanner` はHTTPキャッシュではなくRealtime再検証状態にも使うため変更しない。

- [ ] **Step 7: Feedテスト・Widget解析を通す**

Run:

```bash
cd app
mise exec -- flutter test test/feature/feed/feed_notifier_test.dart test/feature/feed/feed_data_source_test.dart test/feature/feed/feed_by_source_provider_test.dart
mise exec -- flutter analyze --no-pub lib/feature/feed/data/notifier/feed_notifier.dart lib/feature/feed/data/notifier/feed_data_source.dart lib/feature/feed/ui/page/feed_page.dart test/feature/feed/feed_notifier_test.dart test/feature/feed/feed_data_source_test.dart
```

Expected: Feed一覧はネットワーク専用、Feed個別詳細のcache-firstはPASS。

- [ ] **Step 8: Task 4をコミットする**

```bash
git add app/lib/feature/feed/data/notifier/feed_notifier.dart app/lib/feature/feed/data/notifier/feed_data_source.dart app/lib/feature/feed/ui/page/feed_page.dart app/test/feature/feed/feed_notifier_test.dart app/test/feature/feed/feed_data_source_test.dart app/lib/core/paging/cache_first_refresh.dart app/test/core/paging/cache_first_refresh_test.dart
git commit -m "fix: paging対象からHTTPキャッシュを除外"
```

---

### Task 5: 適用範囲の統合回帰テストと知見記録

**Files:**
- Create: `app/test/core/provider/http_cache_scope_test.dart`
- Create: `docs/knowledge/20260727_http_cache_opt_in_scope.md`
- Verify: `app/test/feature/seismicity/data/provider/seismicity_repository_provider_test.dart`

**Interfaces:**
- Consumes: Task 2の `ApiDioFactory`、Task 1の `HttpCacheStore`、Task 3/4で確定した呼び分け。
- Produces: paging・検索・ユーザー固有・Realtimeの代表GETが通常Dioで保存されず、許可GETが専用Dioで保存される回帰テスト。今後の対象追加時に参照する運用ルール。

- [ ] **Step 1: 通常Dioが対象外GETを保存しない統合テストを書く**

in-memory storeと常にJSON 200 + ETagを返すadapterを用意する。同じfactoryから通常DioとキャッシュDioを作成する。

```dart
test('通常Dioのpaging・検索・個人・Realtime GETは保存されない', () async {
  final db = CacheDatabase(NativeDatabase.memory());
  addTearDown(db.close);
  final store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: 'test');
  final factory = ApiDioFactory(
    baseUrl: 'https://example.com',
    headers: const {},
    baseInterceptors: const [],
  );
  final dio = factory.build()..httpClientAdapter = _JsonAdapter();

  await dio.get<Map<String, Object?>>(
    '/v2/earthquake',
    queryParameters: {'cursor': 'next', 'magnitude_gte': '5.0'},
  );
  await dio.get<Map<String, Object?>>('/v2/device/me');
  await dio.get<Map<String, Object?>>('/v2/realtime/ticket');

  expect(await store.listSummaries(), isEmpty);
});
```

- [ ] **Step 2: キャッシュ対応Dioが許可GETを保存するテストを書く**

```dart
test('キャッシュ対応Dioは許可された詳細GETを保存する', () async {
  final db = CacheDatabase(NativeDatabase.memory());
  addTearDown(db.close);
  final store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: 'test');
  final dio = ApiDioFactory(
    baseUrl: 'https://example.com',
    headers: const {},
    baseInterceptors: const [],
  ).build(httpCacheStore: store)
    ..httpClientAdapter = _JsonAdapter();

  await dio.get<Map<String, Object?>>('/v2/earthquake/202607270001');

  final entries = await store.listSummaries();
  expect(entries, hasLength(1));
  expect(entries.single.key, contains('/v2/earthquake/202607270001'));
});

final class _JsonAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    '{"ok":true}',
    200,
    headers: const {
      Headers.contentTypeHeader: [Headers.jsonContentType],
      'etag': ['W/"scope-test"'],
    },
  );

  @override
  void close({bool force = false}) {}
}
```

- [ ] **Step 3: 統合テストを実行する**

Run:

```bash
cd app
mise exec -- flutter test test/core/provider/http_cache_scope_test.dart test/feature/seismicity/data/provider/seismicity_repository_provider_test.dart
```

Expected: 対象外は0件、許可詳細は1件、GeoJSON専用Dioは `HttpCacheInterceptor` 1個のみでPASS。

- [ ] **Step 4: 今後の適用判断をknowledgeへ記録する**

`docs/knowledge/20260727_http_cache_opt_in_scope.md` に次を明記する。

```markdown
# HTTPキャッシュは明示的にオプトインする

- 通常の `apiClientProvider` / `dioProvider` はHTTPキャッシュを持たない。
- cache-first表示が必要な非paging GETだけを `CachedNotifier` から
  `httpCachedApiClientProvider` へ接続する。
- cursor、page、paging目的のlimit、検索条件、ユーザー固有情報、Realtime情報は
  キャッシュ対象にしない。
- 新しい対象を追加する際は設計書の許可一覧、cache-firstテスト、
  `http_cache_scope_test.dart` を同時に更新する。
- Flutter/Dart検証は `mise exec --` 経由で実行する。
```

- [ ] **Step 5: 全対象のfocused testを実行する**

Run:

```bash
cd packages/cache
mise exec -- flutter test test/http
cd ../../app
mise exec -- flutter test test/core/api/http_cache_migrator_test.dart test/core/provider/api_dio_factory_test.dart test/core/provider/http_cache_scope_test.dart test/core/provider/cached_notifier_test.dart test/feature/feed test/feature/changelog/changelog_repository_cache_key_test.dart test/feature/intensity_history/city_highest_notifier_test.dart test/feature/parameter/parameter_repository_refresh_test.dart test/feature/seismicity/data/provider/seismicity_repository_provider_test.dart test/feature/earthquake_history/data/earthquake_debug_override_notifier_test.dart test/feature/earthquake_history/earthquake_history_realtime_details_test.dart test/feature/earthquake_history/ui/earthquake_history_debug_sheet_test.dart
```

Expected: 全テストPASS。

- [ ] **Step 6: 変更ファイルを解析しdiffを検査する**

Run:

```bash
cd app
mise exec -- flutter analyze --no-pub lib/core/api lib/core/provider lib/feature/feed test/core/api test/core/provider test/feature/feed
cd ..
git diff --check
git --no-pager status --short
```

Expected: `No issues found!`、`git diff --check` 出力なし。`backend` と既存未追跡設定ファイルは作業差分として残るが、ステージ対象外。

- [ ] **Step 7: 適用範囲テストとknowledgeをコミットする**

```bash
git add app/test/core/provider/http_cache_scope_test.dart docs/knowledge/20260727_http_cache_opt_in_scope.md
git commit -m "test: HTTPキャッシュ適用範囲を固定"
```

- [ ] **Step 8: コミット境界とremote反映を確認する**

Run:

```bash
git --no-pager log -5 --oneline
git --no-pager diff origin/develop...HEAD --stat
git push origin HEAD
```

Expected: Task 1〜5の実装コミットだけがpushされ、ユーザー所有差分は含まれない。

## Completion Criteria

- 通常 `dioProvider` に `HttpCacheInterceptor` が存在しない。
- cache-first providerだけが `httpCachedApiClientProvider` を利用する。
- Feed一覧と全paging経路がcache-only読み出しを行わない。
- HTTPキャッシュ無効時とDB/移行失敗時にネットワークへ安全に縮退する。
- 旧キャッシュが一回だけ全消去され、失敗時に移行versionが保存されない。
- paging・検索・ユーザー固有・Realtime代表GETのDBエントリ数が0件である。
- ETag/304、破損復旧、Realtime優先、GeoJSON専用Dioの既存保証が維持される。
- focused test、analyze、`git diff --check` が成功する。
- `docs/knowledge/20260727_http_cache_opt_in_scope.md` がcommit・pushされる。
