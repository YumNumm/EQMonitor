# App Drift SWR キャッシュ Implementation Plan (計画D)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴一覧/詳細を Drift 永続キャッシュ + SWR (stale-while-revalidate) 化し、起動直後にキャッシュ即時表示しつつ裏で差分のみ取得して更新する。

**Architecture:** 新規 Drift DB (`CacheDatabase`) に一覧/詳細/同期カーソル/メタを永続化。`floorToHourJst` で量子化した `?lastUpdatedSince=` で差分取得し、`(eventId, updatedAt)` で冪等マージ。書き込みは単一直列キュー (`CacheWriteQueue`) 経由。既存の UI が使う `EarthquakeHistoryDataSource` (paging_view) を SWR ベースへ書き換える。WebSocket realtime は維持。

**Tech Stack:** Drift (SQLite, 新規), Riverpod (`hooks_riverpod ^3.0.3` + `riverpod_generator ^4.0.0+1`), Freezed, paging_view, talker。

## Global Constraints

- Dart `dart analyze` 警告ゼロ (CI 強制)。`dart format` 準拠。
- パッケージ間は package import。
- **1ファイル1公開Provider** ([[one-public-provider-per-file]])。
- 新規 class/関数のIFは契約書 (`docs/superpowers/plans/2026-06-23-earthquake-swr-CONTRACT.md`) に厳密一致させる。
- 場当たり的な複雑化を避ける ([[avoid-incidental-complexity]])。冗長フィールド/抽象は入れない。
- コード生成後は `dart run build_runner build --delete-conflicting-outputs` を実行し生成物 (`*.g.dart`/`*.freezed.dart`/`*.drift.dart` 相当) をコミット。
- PR は **`gh pr create --repo YumNumm/EQMonitor --base develop`**。develop で直接実装しない (専用ブランチ)。

## 依存 (前提)

- **計画B 完了**: api パッケージの `api.EarthquakePartial` に `updatedAt`/`lastReportedAt` (DateTime)、`getV2Earthquake`/intensity scope 4 メソッドに `lastUpdatedSince`/`cacheId` クエリ、`StartResponse.cacheId` が生成済み。
- **計画C 完了**: `httpCacheStore` provider、`HttpCacheStore.evict(String)`/`clearAll()`/`primaryKeyForUrl(RequestOptions)`、定数 `kHttpCacheSchemaVersion` が存在。

## 対象の確定 (調査結果)

- UI が使う一覧 provider は **`earthquakeHistoryDataSourceProvider`** (`app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart`)。`EarthquakeHistoryNotifier` (同 `earthquake_history_notifier.dart`) は **UI 未使用**なので本計画では触らない (将来削除候補として懸念に記載)。
- app は独自の `EarthquakePartial` (`app/lib/feature/earthquake_history/data/model/earthquake_partial.dart`) を持つ。`api.EarthquakePartial → app EarthquakePartial` 変換は `EarthquakePartialApiExtension.toEarthquakePartial`。**app モデルに `updatedAt`/`lastReportedAt` が無い**ため、Task 1 で追加する。
- repository `fetchEarthquakeList`/`searchByPrefecture`/`searchByCity`/`fetchEarthquakeDetail` (`app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart`) が変換の出口。

---

## パッケージ境界 (契約書 §0 — 改訂)

> **重要**: 本計画のインフラは `app/lib/core/cache/` ではなく **新規パッケージ `packages/cache`** (計画C が scaffold 済み) に置く。以降のタスク本文中の `app/lib/core/cache/...` パスと `package:eqmonitor/core/cache/...` import は、下表の `packages/cache` パス・`package:cache/cache.dart` import に読み替える。Riverpod provider・scope ヘルパ・SWR 結線・UI・ドメインは `app` 残留。

## ファイル構成

**`packages/cache` (Riverpod 非依存。計画C で scaffold 済み。本計画で drift 依存を追加):**

- `packages/cache/lib/src/cache_constants.dart` — `const int kCacheSchemaVersion` (計画C `kHttpCacheSchemaVersion` と同値)。
- `packages/cache/lib/src/model/hour_bucket_jst.dart` — `HourBucketJst`。
- `packages/cache/lib/src/model/cache_revalidation_state.dart` — sealed state。
- `packages/cache/lib/src/drift/cache_database.dart` — Drift `CacheDatabase` + テーブル + DAO。
- `packages/cache/lib/src/write/cache_write_queue.dart` — 直列キュー。
- `packages/cache/lib/src/swr/cache_merge.dart` — 純粋マージ/カーソル (**ジェネリック**: `mergeIncoming<T>(T?, T, DateTime Function(T))` 等。app モデル非依存)。
- `packages/cache/lib/src/swr/self_heal_guard.dart` — `SelfHealGuard`。
- `packages/cache/lib/cache.dart` — export 追記。
- `packages/cache/pubspec.yaml` — `drift`/`drift_flutter` + dev `drift_dev` 追加。

**`app` (Riverpod provider・domain・SWR 結線):**

- `app/lib/core/cache/cache_database_provider.dart` — `@Riverpod(keepAlive: true) cacheDatabase` (公開Provider 1個)。
- `app/lib/core/cache/cache_write_queue_provider.dart` — `@Riverpod(keepAlive: true) cacheWriteQueue`。
- `app/lib/feature/earthquake_history/data/cache/cache_scope.dart` — `cacheScopeOf()`/`isCacheableScope()` (app feature 型依存)。
- `app/lib/feature/earthquake_history/data/notifier/cache_revalidation_state_notifier.dart` — `cacheRevalidationStateProvider`。
- `app/lib/core/cache/cache_wipe_service.dart` — 起動時 wipe 判定。
- 変更: `.../model/earthquake_partial.dart` (`updatedAt`/`lastReportedAt` + 変換拡張)、`.../earthquake_history_data_source.dart` (SWR 化)、`.../earthquake_history_repository.dart` (`lastUpdatedSince`/`cacheId`)、`.../earthquake_history_details_notifier.dart` (詳細キャッシュ)、`app/lib/core/provider/log/talker.dart` (`EarthquakeCacheLog`)。`app/pubspec.yaml` の `cache` path 依存は計画C で追加済み。

---

## Task 1: app `EarthquakePartial` に `updatedAt`/`lastReportedAt` を追加

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake_partial.dart`
- Test: `app/test/feature/earthquake_history/data/earthquake_partial_conversion_test.dart`

**Interfaces:**
- Consumes: `api.EarthquakePartial.updatedAt` / `.lastReportedAt` (計画B, DateTime)。
- Produces: app `EarthquakePartial.updatedAt: DateTime` / `.lastReportedAt: DateTime` (必須)。`EarthquakePartialApiExtension.toEarthquakePartial` がそれらを写像。

- [ ] **Step 1: 失敗テストを書く**

```dart
// app/test/feature/earthquake_history/data/earthquake_partial_conversion_test.dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
// jmaParameter を要する変換は parameter を渡す。最小の api.EarthquakePartial を構築。

void main() {
  test('toEarthquakePartial maps updatedAt/lastReportedAt', () {
    final src = api.EarthquakePartial(
      eventId: '20260623120000',
      status: api.TelegramStatus.normal,
      originTimePrecision: api.OriginTimePrecision.second,
      datasource: api.EarthquakeDatasource.jmaDisasterInformationXml,
      telegramTypes: const [],
      earthquakeType: api.EarthquakeType.normal,
      updatedAt: DateTime.utc(2026, 6, 23, 3, 5),
      lastReportedAt: DateTime.utc(2026, 6, 23, 3, 0),
    );
    final app = src.toEarthquakePartial(parameter: testEarthquakeParameter);
    expect(app.updatedAt, DateTime.utc(2026, 6, 23, 3, 5));
    expect(app.lastReportedAt, DateTime.utc(2026, 6, 23, 3, 0));
  });
}
```

> `testEarthquakeParameter` は既存テストの fixture を流用 (`app/test/` 内で `EarthquakeParameter` を組む既存ヘルパを grep し再利用)。無ければ最小の空 `EarthquakeParameter` を組む。

- [ ] **Step 2: テスト失敗を確認**

Run: `cd app && flutter test test/feature/earthquake_history/data/earthquake_partial_conversion_test.dart`
Expected: コンパイルエラー (`updatedAt` is not defined / api 側に未追加なら計画B 未完)。

- [ ] **Step 3: app モデルにフィールド追加**

```dart
// earthquake_partial.dart の factory に追加
const factory EarthquakePartial({
  required String eventId,
  required TelegramStatus status,
  required DateTime? originTime,
  required OriginTimePrecision originTimePrecision,
  required DateTime? arrivalTime,
  required EarthquakeDataSource dataSource,
  required EarthquakeHypocenter? hypocenter,
  required EarthquakeIntensityPartial? intensity,
  required EarthquakeType earthquakeType,
  required List<EarthquakeTelegramType> telegramTypes,
  required String? estimatedIntensityTileUrl,
  required DateTime updatedAt,
  required DateTime lastReportedAt,
}) = _EarthquakePartial;
```

```dart
// 変換拡張に追加
EarthquakePartial toEarthquakePartial({required EarthquakeParameter parameter}) =>
    EarthquakePartial(
      // ...既存...
      updatedAt: updatedAt,
      lastReportedAt: lastReportedAt,
    );
```

- [ ] **Step 4: codegen + テスト緑**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs && flutter test test/feature/earthquake_history/data/earthquake_partial_conversion_test.dart`
Expected: PASS

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/earthquake_history/data/model/earthquake_partial.dart app/lib/feature/earthquake_history/data/model/earthquake_partial.* app/test/feature/earthquake_history/data/earthquake_partial_conversion_test.dart
git commit -m "feat(earthquake): add updatedAt/lastReportedAt to app EarthquakePartial"
```

---

## Task 2: `cache_constants.dart` + `EarthquakeCacheLog`

**Files:**
- Create: `app/lib/core/cache/cache_constants.dart`
- Modify: `app/lib/core/provider/log/talker.dart`

**Interfaces:**
- Produces: `const int kCacheSchemaVersion = 1;` / `class EarthquakeCacheLog extends TalkerLog`。

- [ ] **Step 1: 定数を作成**

```dart
// app/lib/core/cache/cache_constants.dart
/// Drift SWR キャッシュのモデルスキーマ世代。
/// app モデル (EarthquakePartial 等) の構造を変えたら +1 する。
/// 起動時に cache_meta.schemaVersion と比較し不一致なら bulk clear。
const int kCacheSchemaVersion = 1;
```

- [ ] **Step 2: typed log 追加**

```dart
// talker.dart の末尾の log 群に追加
class EarthquakeCacheLog extends TalkerLog {
  EarthquakeCacheLog(super.message);
  @override
  String get title => 'EarthquakeCache';
  @override
  final pen = AnsiPen()..cyan();
}
```

- [ ] **Step 3: analyze + コミット**

Run: `cd app && dart analyze lib/core/cache/cache_constants.dart lib/core/provider/log/talker.dart`
Expected: No issues
```bash
git add app/lib/core/cache/cache_constants.dart app/lib/core/provider/log/talker.dart
git commit -m "feat(cache): add cache schema version constant and EarthquakeCacheLog"
```

---

## Task 3: `HourBucketJst` 値オブジェクト

**Files:**
- Create: `app/lib/core/cache/model/hour_bucket_jst.dart`
- Test: `app/test/core/cache/hour_bucket_jst_test.dart`

**Interfaces:**
- Produces: `class HourBucketJst { factory HourBucketJst.floor(DateTime instant); String get value; }`。`value` = `yyyy-MM-ddTHH:00:00+09:00`。

- [ ] **Step 1: 失敗テスト**

```dart
// app/test/core/cache/hour_bucket_jst_test.dart
import 'package:eqmonitor/core/cache/model/hour_bucket_jst.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('floors a UTC instant to the JST hour boundary', () {
    // 2026-06-23T03:35Z == 2026-06-23T12:35+09:00 → floor → 12:00+09:00
    final b = HourBucketJst.floor(DateTime.utc(2026, 6, 23, 3, 35, 12));
    expect(b.value, '2026-06-23T12:00:00+09:00');
  });

  test('floors across the JST date boundary', () {
    // 2026-06-23T15:10Z == 2026-06-24T00:10+09:00 → floor → 00:00+09:00
    final b = HourBucketJst.floor(DateTime.utc(2026, 6, 23, 15, 10));
    expect(b.value, '2026-06-24T00:00:00+09:00');
  });

  test('value matches the backend HourBucketJst regex', () {
    final b = HourBucketJst.floor(DateTime.utc(2026, 1, 1, 0, 0));
    expect(
      RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:00:00\+09:00$').hasMatch(b.value),
      isTrue,
    );
  });
}
```

- [ ] **Step 2: 失敗確認**

Run: `cd app && flutter test test/core/cache/hour_bucket_jst_test.dart`
Expected: FAIL (HourBucketJst undefined)

- [ ] **Step 3: 実装**

```dart
// app/lib/core/cache/model/hour_bucket_jst.dart
import 'package:meta/meta.dart';

/// 差分取得カーソル `?lastUpdatedSince=` に渡す JST 時境界量子化値。
/// JST はサマータイムが無いため +09:00 固定で年中ブレない。
@immutable
class HourBucketJst {
  const HourBucketJst._(this.value);

  /// 絶対時刻 [instant] を JST の時境界へ切り下げる。
  factory HourBucketJst.floor(DateTime instant) {
    // UTC+9 の壁時計に変換 (DST 無しなので単純加算)。
    final jst = instant.toUtc().add(const Duration(hours: 9));
    final floored = DateTime.utc(jst.year, jst.month, jst.day, jst.hour);
    final s = floored;
    String two(int v) => v.toString().padLeft(2, '0');
    return HourBucketJst._(
      '${s.year.toString().padLeft(4, '0')}-${two(s.month)}-${two(s.day)}'
      'T${two(s.hour)}:00:00+09:00',
    );
  }

  /// `yyyy-MM-ddTHH:00:00+09:00`
  final String value;

  @override
  bool operator ==(Object other) =>
      other is HourBucketJst && other.value == value;
  @override
  int get hashCode => value.hashCode;
  @override
  String toString() => 'HourBucketJst($value)';
}
```

- [ ] **Step 4: 緑 + コミット**

Run: `cd app && flutter test test/core/cache/hour_bucket_jst_test.dart`
Expected: PASS
```bash
git add app/lib/core/cache/model/hour_bucket_jst.dart app/test/core/cache/hour_bucket_jst_test.dart
git commit -m "feat(cache): add HourBucketJst value object"
```

---

## Task 4: `cacheScopeOf()` scope ヘルパ

**Files:**
- Create: `app/lib/core/cache/model/cache_scope.dart`
- Test: `app/test/core/cache/cache_scope_test.dart`

**Interfaces:**
- Consumes: `EarthquakeHistoryParameter` (`regionSearchType`/`regionCode`)。
- Produces: `String cacheScopeOf(EarthquakeHistoryParameter parameter)`。`bool isCacheableScope(EarthquakeHistoryParameter)` — 任意フィルタ付き (差分非対象) を弾く。

- [ ] **Step 1: 失敗テスト**

```dart
// app/test/core/cache/cache_scope_test.dart
import 'package:eqmonitor/core/cache/model/cache_scope.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('default parameter → national', () {
    expect(cacheScopeOf(const EarthquakeHistoryParameter()), 'national');
    expect(isCacheableScope(const EarthquakeHistoryParameter()), isTrue);
  });

  test('city region → city:<code>', () {
    const p = EarthquakeHistoryParameter(
      regionSearchType: RegionSearchType.city,
      regionCode: '2010100',
    );
    expect(cacheScopeOf(p), 'city:2010100');
    expect(isCacheableScope(p), isTrue);
  });

  test('parameter with arbitrary filter is not cacheable', () {
    const p = EarthquakeHistoryParameter(magnitudeGte: 5);
    expect(isCacheableScope(p), isFalse);
  });
}
```

- [ ] **Step 2: 失敗確認** — Run: `cd app && flutter test test/core/cache/cache_scope_test.dart` → FAIL

- [ ] **Step 3: 実装**

```dart
// app/lib/core/cache/model/cache_scope.dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';

/// SWR キャッシュ対象のスコープ文字列。national / region: / prefecture: / city:。
String cacheScopeOf(EarthquakeHistoryParameter parameter) {
  final code = parameter.regionCode;
  switch (parameter.regionSearchType) {
    case RegionSearchType.prefecture:
      return 'prefecture:$code';
    case RegionSearchType.city:
      return 'city:$code';
    case RegionSearchType.region:
      return 'region:$code';
    case null:
      return 'national';
  }
}

/// 差分 SWR の対象スコープ (全国 / region 履歴) か。
/// 任意フィルタ付き検索は差分共有キャッシュ対象外 (従来通り毎回ネットワーク)。
bool isCacheableScope(EarthquakeHistoryParameter p) {
  // national: 完全デフォルトのみ。
  if (p.regionSearchType == null) {
    return p == const EarthquakeHistoryParameter();
  }
  // region 系: regionCode + (任意フィルタ無し) のみ許容。
  return p.regionCode != null &&
      p.magnitudeGte == null && p.magnitudeLte == null &&
      p.depthGte == null && p.depthLte == null &&
      p.intensityGte == null && p.intensityLte == null &&
      p.epicenterCode == null && p.earthquakeType == null &&
      p.originTimeGte == null && p.originTimeLte == null &&
      p.maxLpgmIntensityGte == null && p.maxLpgmIntensityLte == null &&
      p.regionIntensityGte == null && p.regionIntensityLte == null;
}
```

> `RegionSearchType` の列挙子は実ファイルを Read して網羅 (region/prefecture/city)。存在しない値があれば switch を実体に合わせる。

- [ ] **Step 4: 緑 + コミット**

Run: `cd app && flutter test test/core/cache/cache_scope_test.dart` → PASS
```bash
git add app/lib/core/cache/model/cache_scope.dart app/test/core/cache/cache_scope_test.dart
git commit -m "feat(cache): add cacheScopeOf and isCacheableScope helpers"
```

---

## Task 5: Drift `CacheDatabase` + テーブル + DAO

**Files:**
- Create: `app/lib/core/cache/drift/cache_database.dart`
- Create: `app/lib/core/cache/drift/cache_database_provider.dart`
- Modify: `app/pubspec.yaml`
- Test: `app/test/core/cache/cache_database_test.dart`

**Interfaces:**
- Produces:
  - `class CacheDatabase extends _$CacheDatabase` (Drift 生成)。
  - テーブル: `EarthquakeCacheTable`(`earthquake_cache`), `EarthquakeDetailCacheTable`(`earthquake_detail_cache`), `CacheSyncStateTable`(`cache_sync_state`), `CacheMetaTable`(`cache_meta`)。
  - DAO メソッド (計画E も消費): `Future<List<EarthquakeCacheRow>> readScope(String scope)`、`Future<void> upsertList(String scope, List<EarthquakeCacheCompanion>)`、`Future<void> deleteScopeRow(String scope, String eventId)`、`Future<String?> readSinceCursor(String scope)`、`Future<void> writeSinceCursor(String scope, String? cursor, DateTime syncedAt)`、`Future<int> deleteOlderThan(DateTime threshold)` (lastReportedAt 基準)、`Future<void> clearAllCache()`、`Future<int> readSchemaVersion()`/`Future<void> writeSchemaVersion(int)`、`Future<String?> readLastSeenCacheId()`/`Future<void> writeLastSeenCacheId(String)`、詳細用 `Future<EarthquakeDetailCacheRow?> readDetail(String eventId)`/`Future<void> upsertDetail(EarthquakeDetailCacheCompanion)`。
  - `@Riverpod(keepAlive: true) CacheDatabase cacheDatabase(Ref ref)` (provider 1個)。

- [ ] **Step 1: 依存追加**

`app/pubspec.yaml` に追記 (バージョンは pub.dev 最新安定を `flutter pub add` で解決):
```bash
cd app && flutter pub add drift drift_flutter && flutter pub add --dev drift_dev
```
(`drift_flutter` が `sqlite3_flutter_libs` + path_provider を内包。手動で `BuildConfig` 不要。)

- [ ] **Step 2: 失敗テスト (in-memory DB)**

```dart
// app/test/core/cache/cache_database_test.dart
import 'package:drift/native.dart';
import 'package:eqmonitor/core/cache/drift/cache_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CacheDatabase db;
  setUp(() => db = CacheDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('upsert then read by scope', () async {
    await db.upsertList('national', [
      EarthquakeCacheCompanion.insert(
        scope: 'national',
        eventId: '20260623120000',
        payload: '{"event_id":"20260623120000"}',
        updatedAt: DateTime.utc(2026, 6, 23, 3, 5),
        lastReportedAt: DateTime.utc(2026, 6, 23, 3, 0),
        fetchedAt: DateTime.utc(2026, 6, 23, 4, 0),
      ),
    ]);
    final rows = await db.readScope('national');
    expect(rows, hasLength(1));
    expect(rows.single.eventId, '20260623120000');
  });

  test('deleteOlderThan removes by lastReportedAt only', () async {
    await db.upsertList('national', [
      EarthquakeCacheCompanion.insert(
        scope: 'national', eventId: 'old', payload: '{}',
        updatedAt: DateTime.utc(2026, 1, 1),
        lastReportedAt: DateTime.utc(2026, 1, 1), // 古い
        fetchedAt: DateTime.utc(2026, 6, 23), // 最近 fetch しても消える
      ),
    ]);
    final deleted = await db.deleteOlderThan(DateTime.utc(2026, 6, 1));
    expect(deleted, 1);
    expect(await db.readScope('national'), isEmpty);
  });
}
```

- [ ] **Step 3: 失敗確認** — Run: `cd app && flutter test test/core/cache/cache_database_test.dart` → FAIL

- [ ] **Step 4: Drift テーブル + DB 実装**

```dart
// app/lib/core/cache/drift/cache_database.dart
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'cache_database.g.dart';

class EarthquakeCacheTable extends Table {
  @override
  String get tableName => 'earthquake_cache';
  TextColumn get scope => text()();
  TextColumn get eventId => text()();
  TextColumn get payload => text()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastReportedAt => dateTime()();
  DateTimeColumn get fetchedAt => dateTime()();
  @override
  Set<Column<Object>> get primaryKey => {scope, eventId};
}

class EarthquakeDetailCacheTable extends Table {
  @override
  String get tableName => 'earthquake_detail_cache';
  TextColumn get eventId => text()();
  TextColumn get payload => text()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastReportedAt => dateTime()();
  DateTimeColumn get fetchedAt => dateTime()();
  @override
  Set<Column<Object>> get primaryKey => {eventId};
}

class CacheSyncStateTable extends Table {
  @override
  String get tableName => 'cache_sync_state';
  TextColumn get scope => text()();
  TextColumn get sinceCursor => text().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  @override
  Set<Column<Object>> get primaryKey => {scope};
}

class CacheMetaTable extends Table {
  @override
  String get tableName => 'cache_meta';
  // 単一行 (id=0 固定)。
  IntColumn get id => integer().withDefault(const Constant(0))();
  IntColumn get schemaVersion => integer()();
  TextColumn get lastSeenCacheId => text().nullable()();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    EarthquakeCacheTable,
    EarthquakeDetailCacheTable,
    CacheSyncStateTable,
    CacheMetaTable,
  ],
)
class CacheDatabase extends _$CacheDatabase {
  CacheDatabase() : super(driftDatabase(name: 'eqmonitor_cache'));
  CacheDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  Future<List<EarthquakeCacheTableData>> readScope(String scope) =>
      (select(earthquakeCacheTable)
            ..where((t) => t.scope.equals(scope))
            ..orderBy([(t) => OrderingTerm.desc(t.lastReportedAt)]))
          .get();

  Future<void> upsertList(
    String scope,
    List<EarthquakeCacheTableCompanion> rows,
  ) => batch((b) => b.insertAllOnConflictUpdate(earthquakeCacheTable, rows));

  Future<void> deleteScopeRow(String scope, String eventId) =>
      (delete(earthquakeCacheTable)
            ..where((t) => t.scope.equals(scope) & t.eventId.equals(eventId)))
          .go();

  Future<String?> readSinceCursor(String scope) async {
    final row = await (select(cacheSyncStateTable)
          ..where((t) => t.scope.equals(scope)))
        .getSingleOrNull();
    return row?.sinceCursor;
  }

  Future<void> writeSinceCursor(
    String scope,
    String? cursor,
    DateTime syncedAt,
  ) => into(cacheSyncStateTable).insertOnConflictUpdate(
        CacheSyncStateTableCompanion.insert(
          scope: scope,
          sinceCursor: Value(cursor),
          lastSyncedAt: Value(syncedAt),
        ),
      );

  Future<int> deleteOlderThan(DateTime threshold) async {
    final a = await (delete(earthquakeCacheTable)
          ..where((t) => t.lastReportedAt.isSmallerThanValue(threshold)))
        .go();
    final b = await (delete(earthquakeDetailCacheTable)
          ..where((t) => t.lastReportedAt.isSmallerThanValue(threshold)))
        .go();
    return a + b;
  }

  Future<void> clearAllCache() => transaction(() async {
        await delete(earthquakeCacheTable).go();
        await delete(earthquakeDetailCacheTable).go();
        await delete(cacheSyncStateTable).go();
      });

  Future<int> readSchemaVersionMeta() async {
    final row = await (select(cacheMetaTable)
          ..where((t) => t.id.equals(0)))
        .getSingleOrNull();
    return row?.schemaVersion ?? 0;
  }

  Future<void> writeMeta({required int schemaVersion, String? lastSeenCacheId}) =>
      into(cacheMetaTable).insertOnConflictUpdate(
        CacheMetaTableCompanion.insert(
          id: const Value(0),
          schemaVersion: schemaVersion,
          lastSeenCacheId: Value(lastSeenCacheId),
        ),
      );

  Future<String?> readLastSeenCacheId() async {
    final row = await (select(cacheMetaTable)..where((t) => t.id.equals(0)))
        .getSingleOrNull();
    return row?.lastSeenCacheId;
  }

  Future<EarthquakeDetailCacheTableData?> readDetail(String eventId) =>
      (select(earthquakeDetailCacheTable)
            ..where((t) => t.eventId.equals(eventId)))
          .getSingleOrNull();

  Future<void> upsertDetail(EarthquakeDetailCacheTableCompanion row) =>
      into(earthquakeDetailCacheTable).insertOnConflictUpdate(row);
}
```

> 生成型名 (`EarthquakeCacheTableData`/`EarthquakeCacheTableCompanion` 等) は Drift の命名規則どおり。テストの `EarthquakeCacheCompanion.insert` は実際の生成名 (`EarthquakeCacheTableCompanion.insert`) に Step 6 で揃える。

- [ ] **Step 5: provider**

```dart
// app/lib/core/cache/drift/cache_database_provider.dart
import 'package:eqmonitor/core/cache/drift/cache_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_database_provider.g.dart';

@Riverpod(keepAlive: true)
CacheDatabase cacheDatabase(Ref ref) {
  final db = CacheDatabase();
  ref.onDispose(db.close);
  return db;
}
```

- [ ] **Step 6: codegen + テスト緑**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
→ 生成された Companion 名に合わせてテストの型名を修正。
Run: `cd app && flutter test test/core/cache/cache_database_test.dart`
Expected: PASS

- [ ] **Step 7: コミット**

```bash
git add app/lib/core/cache/drift/ app/pubspec.yaml app/pubspec.lock app/test/core/cache/cache_database_test.dart
git commit -m "feat(cache): add Drift CacheDatabase with cache tables and DAO"
```

---

## Task 6: `CacheRevalidationState` + provider

**Files:**
- Create: `app/lib/core/cache/model/cache_revalidation_state.dart`
- Create: `app/lib/feature/earthquake_history/data/notifier/cache_revalidation_state_notifier.dart`
- Test: `app/test/core/cache/cache_revalidation_state_test.dart`

**Interfaces:**
- Produces:
  ```dart
  sealed class CacheRevalidationState {}
  class CacheRevalidationIdle extends CacheRevalidationState {}
  class CacheRevalidationRevalidating extends CacheRevalidationState {}
  class CacheRevalidationOffline extends CacheRevalidationState {}
  class CacheRevalidationFailed extends CacheRevalidationState { final Object error; }
  ```
  `cacheRevalidationStateProvider(String scope)` — family Notifier。`set(CacheRevalidationState)` を SWR フローから呼ぶ。

- [ ] **Step 1: 失敗テスト**

```dart
// app/test/core/cache/cache_revalidation_state_test.dart
import 'package:eqmonitor/core/cache/model/cache_revalidation_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('failed carries error', () {
    final s = CacheRevalidationFailed(Exception('x'));
    expect(s, isA<CacheRevalidationState>());
    expect(s.error, isA<Exception>());
  });
}
```

- [ ] **Step 2: 失敗確認** → FAIL

- [ ] **Step 3: sealed state 実装**

```dart
// app/lib/core/cache/model/cache_revalidation_state.dart
sealed class CacheRevalidationState {
  const CacheRevalidationState();
}
class CacheRevalidationIdle extends CacheRevalidationState {
  const CacheRevalidationIdle();
}
class CacheRevalidationRevalidating extends CacheRevalidationState {
  const CacheRevalidationRevalidating();
}
class CacheRevalidationOffline extends CacheRevalidationState {
  const CacheRevalidationOffline();
}
class CacheRevalidationFailed extends CacheRevalidationState {
  const CacheRevalidationFailed(this.error);
  final Object error;
}
```

- [ ] **Step 4: notifier**

```dart
// cache_revalidation_state_notifier.dart
import 'package:eqmonitor/core/cache/model/cache_revalidation_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_revalidation_state_notifier.g.dart';

@riverpod
class CacheRevalidationStateNotifier extends _$CacheRevalidationStateNotifier {
  @override
  CacheRevalidationState build(String scope) => const CacheRevalidationIdle();

  void set(CacheRevalidationState next) => state = next;
}
```

- [ ] **Step 5: codegen + 緑 + コミット**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs && flutter test test/core/cache/cache_revalidation_state_test.dart` → PASS
```bash
git add app/lib/core/cache/model/cache_revalidation_state.dart app/lib/feature/earthquake_history/data/notifier/cache_revalidation_state_notifier.* app/test/core/cache/cache_revalidation_state_test.dart
git commit -m "feat(cache): add CacheRevalidationState and provider"
```

---

## Task 7: 純粋マージ/カーソルロジック `earthquake_cache_merge.dart`

**Files:**
- Create: `app/lib/core/cache/swr/earthquake_cache_merge.dart`
- Test: `app/test/core/cache/earthquake_cache_merge_test.dart`

**Interfaces:**
- Produces:
  - `EarthquakePartial? mergeIncoming(EarthquakePartial? existing, EarthquakePartial incoming)` — `incoming.updatedAt < existing.updatedAt` なら null (破棄)、それ以外 incoming。
  - `DateTime? maxUpdatedAt(Iterable<EarthquakePartial> items)`。
  - `HourBucketJst computeLastUpdatedSince({required DateTime? maxUpdatedAt, required DateTime now, required Duration retention})` — `floorToHourJst(max(maxUpdatedAt, now - retention))`。null は now-retention。
  - `bool shouldFullReload({required DateTime? maxUpdatedAt, required DateTime now, required Duration retention})` — ギャップが retention 超過。

- [ ] **Step 1: 失敗テスト**

```dart
// app/test/core/cache/earthquake_cache_merge_test.dart
import 'package:eqmonitor/core/cache/swr/earthquake_cache_merge.dart';
import 'package:flutter_test/flutter_test.dart';
// _partial(updatedAt) ヘルパで最小 EarthquakePartial を組む (Task 1 のモデル)。

void main() {
  test('discards stale incoming (older updatedAt)', () {
    final existing = _partial(DateTime.utc(2026, 6, 23, 5));
    final incoming = _partial(DateTime.utc(2026, 6, 23, 4));
    expect(mergeIncoming(existing, incoming), isNull);
  });

  test('accepts newer incoming', () {
    final existing = _partial(DateTime.utc(2026, 6, 23, 4));
    final incoming = _partial(DateTime.utc(2026, 6, 23, 5));
    expect(mergeIncoming(existing, incoming)?.updatedAt,
        DateTime.utc(2026, 6, 23, 5));
  });

  test('computeLastUpdatedSince clamps to now-retention on null', () {
    final since = computeLastUpdatedSince(
      maxUpdatedAt: null,
      now: DateTime.utc(2026, 6, 23, 3, 0),
      retention: const Duration(days: 90),
    );
    // now-90d = 2026-03-25T12:00+09:00 を時フロア
    expect(since.value, '2026-03-25T12:00:00+09:00');
  });

  test('shouldFullReload when gap exceeds retention', () {
    expect(
      shouldFullReload(
        maxUpdatedAt: DateTime.utc(2026, 1, 1),
        now: DateTime.utc(2026, 6, 23),
        retention: const Duration(days: 90),
      ),
      isTrue,
    );
  });
}
```

- [ ] **Step 2: 失敗確認** → FAIL

- [ ] **Step 3: 実装**

```dart
// app/lib/core/cache/swr/earthquake_cache_merge.dart
import 'package:eqmonitor/core/cache/model/hour_bucket_jst.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';

EarthquakePartial? mergeIncoming(
  EarthquakePartial? existing,
  EarthquakePartial incoming,
) {
  if (existing != null && incoming.updatedAt.isBefore(existing.updatedAt)) {
    return null;
  }
  return incoming;
}

DateTime? maxUpdatedAt(Iterable<EarthquakePartial> items) {
  DateTime? max;
  for (final i in items) {
    if (max == null || i.updatedAt.isAfter(max)) {
      max = i.updatedAt;
    }
  }
  return max;
}

HourBucketJst computeLastUpdatedSince({
  required DateTime? maxUpdatedAt,
  required DateTime now,
  required Duration retention,
}) {
  final floor = now.subtract(retention);
  final base = (maxUpdatedAt == null || maxUpdatedAt.isBefore(floor))
      ? floor
      : maxUpdatedAt;
  return HourBucketJst.floor(base);
}

bool shouldFullReload({
  required DateTime? maxUpdatedAt,
  required DateTime now,
  required Duration retention,
}) {
  if (maxUpdatedAt == null) {
    return false; // キャッシュ無し → 通常コールドロード扱い (full load)
  }
  return now.difference(maxUpdatedAt) > retention;
}
```

- [ ] **Step 4: 緑 + コミット** — Run → PASS
```bash
git add app/lib/core/cache/swr/earthquake_cache_merge.dart app/test/core/cache/earthquake_cache_merge_test.dart
git commit -m "feat(cache): add pure SWR merge and cursor logic"
```

---

## Task 8: `CacheWriteQueue` (直列書き込み)

**Files:**
- Create: `app/lib/core/cache/write/cache_write_queue.dart`
- Test: `app/test/core/cache/cache_write_queue_test.dart`

**Interfaces:**
- Produces: `class CacheWriteQueue { Future<T> run<T>(Future<T> Function() action); }` — 投入順に直列実行 (1つ完了まで次を開始しない)。

- [ ] **Step 1: 失敗テスト**

```dart
// app/test/core/cache/cache_write_queue_test.dart
import 'package:eqmonitor/core/cache/write/cache_write_queue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('runs actions strictly in order, never overlapping', () async {
    final queue = CacheWriteQueue();
    final order = <int>[];
    var active = 0;
    Future<void> task(int n, Duration d) => queue.run(() async {
          active++;
          expect(active, 1); // 同時実行されない
          await Future<void>.delayed(d);
          order.add(n);
          active--;
        });
    await Future.wait([
      task(1, const Duration(milliseconds: 30)),
      task(2, const Duration(milliseconds: 5)),
      task(3, const Duration(milliseconds: 1)),
    ]);
    expect(order, [1, 2, 3]);
  });
}
```

- [ ] **Step 2: 失敗確認** → FAIL

- [ ] **Step 3: 実装**

```dart
// app/lib/core/cache/write/cache_write_queue.dart
import 'dart:async';

/// 全 Drift 書き込みを単一直列チェーン経由にし、並行ライター
/// (timer / lifecycle / WS / 差分ページ / 自己修復) の競合を防ぐ。
class CacheWriteQueue {
  Future<void> _tail = Future<void>.value();

  Future<T> run<T>(Future<T> Function() action) {
    final completer = Completer<T>();
    _tail = _tail.then((_) async {
      try {
        completer.complete(await action());
      } on Object catch (e, st) {
        completer.completeError(e, st);
      }
    });
    return completer.future;
  }
}
```

- [ ] **Step 4: 緑 + コミット** → PASS
```bash
git add app/lib/core/cache/write/cache_write_queue.dart app/test/core/cache/cache_write_queue_test.dart
git commit -m "feat(cache): add serial CacheWriteQueue"
```

---

## Task 9: repository に `lastUpdatedSince`/`cacheId` 引数を追加

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart`
- Test: `app/test/feature/earthquake_history/data/repository_diff_query_test.dart`

**Interfaces:**
- Produces: `fetchEarthquakeList`/`searchByPrefecture`/`searchByCity` に `String? lastUpdatedSince`、`String? cacheId` を追加し `getV2Earthquake(...)` 等へ pass-through。

- [ ] **Step 1: 失敗テスト (DioAdapter モックで送信クエリ検証)**

```dart
// app/test/feature/earthquake_history/data/repository_diff_query_test.dart
// http_mock_adapter で getV2Earthquake が lastUpdatedSince/cacheId を送ることを検証。
// 既存の repository テスト (あれば) のセットアップを流用。
```

> 既存 repository テストの有無を grep。無ければ `ApiClient` を `DioAdapter` 付き Dio で構築する最小テストを書く。送信クエリに `lastUpdatedSince=...&cacheId=...` が含まれることを `DioAdapter.onGet` のマッチャで検証。

- [ ] **Step 2: 失敗確認** → FAIL (引数未定義)

- [ ] **Step 3: 実装** — 3 メソッドに引数追加し pass-through:

```dart
Future<EarthquakeListResponse> fetchEarthquakeList({
  // ...既存引数...
  String? lastUpdatedSince,
  String? cacheId,
}) async {
  final response = await _api.earthquake.getV2Earthquake(
    // ...既存...
    lastUpdatedSince: lastUpdatedSince,
    cacheId: cacheId,
  );
  return response.data.toEarthquakeListResponse(parameter: earthquakeParameter);
}
```
(searchByPrefecture/searchByCity も同様に `lastUpdatedSince`/`cacheId` を該当 scope メソッドへ。)

- [ ] **Step 4: codegen 不要 / analyze + 緑 + コミット**

Run: `cd app && flutter test test/feature/earthquake_history/data/repository_diff_query_test.dart` → PASS
```bash
git add app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart app/test/feature/earthquake_history/data/repository_diff_query_test.dart
git commit -m "feat(earthquake): thread lastUpdatedSince/cacheId through repository"
```

---

## Task 10: `EarthquakeHistoryDataSource` を SWR 化

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart`
- Test: `app/test/feature/earthquake_history/data/swr_flow_test.dart`

**Interfaces:**
- Consumes: `cacheDatabaseProvider`, `cacheWriteQueue` (Task 8 を provider 化: `@Riverpod(keepAlive: true) CacheWriteQueue cacheWriteQueue(Ref ref)` を本タスクで追加), `cacheScopeOf`, `isCacheableScope`, `computeLastUpdatedSince`/`shouldFullReload`/`mergeIncoming`, `cacheRevalidationStateProvider`, `httpCacheStore` (計画C), `StartResponse.cacheId`。
- Produces: 既存 `earthquakeHistoryDataSourceProvider(parameter)` の挙動を SWR に置換 (provider 名・戻り型 `EarthquakeHistoryDataSource` は維持)。

**SWR フロー (cacheable scope のみ。非 cacheable は従来通りネットワーク `load`):**
1. provider build: `isCacheableScope` なら Drift `readScope(scope)` を `payload` から `EarthquakePartial` に復元し DataSource へ即時投入 (stale 表示)。
2. `cacheRevalidationStateProvider(scope).set(CacheRevalidationRevalidating())`。
3. `since = readSinceCursor(scope)` 優先、無ければ `computeLastUpdatedSince(maxUpdatedAt(rows), now, retention)`。`shouldFullReload` なら `lastUpdatedSince=null` の full load。
4. `repository.fetchEarthquakeList(limit: 50, lastUpdatedSince: since.value, cacheId: cacheId, cursor: ...)` を**ページごと**に呼び、各ページ到着で `cacheWriteQueue.run(() => upsert + UI 反映)`。マージは `mergeIncoming` (古い updatedAt は破棄)。
5. **全ページ完走後にのみ** `writeSinceCursor(scope, newCursor, now)`。途中中断は前進させない。
6. 完了で `set(CacheRevalidationIdle())`。`DioException`(オフライン) → `set(CacheRevalidationOffline())`、その他失敗 → `set(CacheRevalidationFailed(e))`。
7. 既存の 5分 timer / lifecycle / realtime upsert は「最新10件 full fetch → upsert」を**差分取得 trigger に置換** (同じ SWR revalidate を呼ぶ)。realtime delete は `removeItemByEventId` + Drift `deleteScopeRow` 維持。

- [ ] **Step 1: `cacheWriteQueue` provider 追加 (1ファイル1公開)**

```dart
// app/lib/core/cache/write/cache_write_queue_provider.dart
import 'package:eqmonitor/core/cache/write/cache_write_queue.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cache_write_queue_provider.g.dart';
@Riverpod(keepAlive: true)
CacheWriteQueue cacheWriteQueue(Ref ref) => CacheWriteQueue();
```

- [ ] **Step 2: 失敗テスト (SWR stale-then-revalidate)**

```dart
// app/test/feature/earthquake_history/data/swr_flow_test.dart
// ProviderContainer + override で:
//  - cacheDatabaseProvider を in-memory CacheDatabase に override
//  - earthquakeHistoryRepositoryProvider を fake repo に override (差分2ページを返す)
//  - httpCacheStore を fake に override
// 検証:
//  1. build 直後に Drift の stale 行が即時に DataSource に出る
//  2. 差分ページ反映後に新着がマージされる
//  3. 全ページ完走後に since_cursor が前進する
//  4. 1ページ目で例外 → since_cursor 不変 (再取得で同じ since)
//  5. revalidation state が revalidating → idle と遷移
```

> paging_view の `GroupedDataSource` は内部状態をテストしづらいため、SWR の中核ロジック (revalidate 1サイクル) を DataSource の public メソッド `Future<void> revalidate({required DiffDeps deps})` に切り出してユニットテストする。`DiffDeps` は repository/db/queue/cacheId/now/retention を束ねる注入用 record。UI 結線は Step 5 のウィジェットテストで担保。

- [ ] **Step 3: 失敗確認** → FAIL

- [ ] **Step 4: SWR 実装**

`earthquakeHistoryDataSource` provider に: cacheable scope 判定 → Drift 即時投入 → `revalidate` 起動。`EarthquakeHistoryDataSource` に `revalidate`/`_applyDiffPage`/Drift 復元ヘルパを実装。`since_cursor` 前進は全ページ完走後のみ。realtime/timer/lifecycle のハンドラ本体を `revalidate` 呼び出しへ差し替え。

> 実コードは既存 `_fetch`/`upsertItems`/`removeItemByEventId` の構造 (本計画「対象の確定」で引用) を保ちつつ拡張する。`payload` の JSON は `api.EarthquakePartial.toJson()` 由来をそのまま保存し、復元時は `api.EarthquakePartial.fromJson(...).toEarthquakePartial(parameter:)` で app モデル化。

- [ ] **Step 5: ウィジェット/プロバイダ統合テスト** — 一覧 page が stale を即描画し revalidate 後に更新されることを `pumpWidget` で確認。

- [ ] **Step 6: codegen + analyze + 緑 + コミット**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs && flutter test test/feature/earthquake_history/data/swr_flow_test.dart && dart analyze lib/feature/earthquake_history lib/core/cache`
Expected: PASS / No issues
```bash
git add app/lib/core/cache/write/cache_write_queue_provider.* app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart app/test/feature/earthquake_history/data/swr_flow_test.dart
git commit -m "feat(earthquake): SWR-ify history data source with Drift cache + diff fetch"
```

---

## Task 11: 自己修復 + schema ガード

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart` (復元パス)
- Create: `app/lib/core/cache/swr/self_heal_guard.dart`
- Test: `app/test/core/cache/self_heal_test.dart`

**Interfaces:**
- Produces: `class SelfHealGuard { bool canHeal(String eventId); void markAttempt(String eventId); void markFailed(String eventId); bool isFailed(String eventId); }` — `(eventId)` ごと 1回まで (appSchemaVersion はプロセス内なので暗黙)。

- [ ] **Step 1: 失敗テスト** — `canHeal` が2回目で false、`markFailed` 後 `isFailed` true。

- [ ] **Step 2: 失敗確認** → FAIL

- [ ] **Step 3: 実装**

```dart
// app/lib/core/cache/swr/self_heal_guard.dart
class SelfHealGuard {
  final _attempts = <String, int>{};
  final _failed = <String>{};
  bool canHeal(String eventId) =>
      !_failed.contains(eventId) && (_attempts[eventId] ?? 0) < 1;
  void markAttempt(String eventId) =>
      _attempts[eventId] = (_attempts[eventId] ?? 0) + 1;
  void markFailed(String eventId) => _failed.add(eventId);
  bool isFailed(String eventId) => _failed.contains(eventId);
}
```

- [ ] **Step 4: 復元パスへ結線** — Drift 行の `payload` パースが `CheckedFromJsonException`/`FormatException` を投げたら: schema 検証 (`db.readSchemaVersionMeta() != kCacheSchemaVersion` なら bulk clear へ委譲し per-record 修復しない)、一致時のみ `SelfHealGuard.canHeal` なら該当行 `deleteScopeRow` + `httpCacheStore.evict(primaryKeyForUrl(...))` + 再取得。2回目失敗で `markFailed` + `EarthquakeCacheLog` 記録。

- [ ] **Step 5: 緑 + コミット**

Run: `cd app && flutter test test/core/cache/self_heal_test.dart` → PASS
```bash
git add app/lib/core/cache/swr/self_heal_guard.dart app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart app/test/core/cache/self_heal_test.dart
git commit -m "feat(cache): add per-record self-heal guard and HTTP cache eviction"
```

---

## Task 12: 起動時 bulk wipe (`cacheId` / schema)

**Files:**
- Create: `app/lib/core/cache/wipe/cache_wipe_service.dart`
- Test: `app/test/core/cache/cache_wipe_test.dart`

**Interfaces:**
- Consumes: `CacheDatabase`, `httpCacheStore.clearAll()`, `kCacheSchemaVersion`, `StartResponse.cacheId` (取得元 provider は既存の start provider を Read して特定)。
- Produces: `class CacheWipeService { Future<void> reconcileOnStartup({required String? remoteCacheId}); }` — schema 不一致 or cacheId 不一致で `clearAllCache()` + `httpCacheStore.clearAll()` + `writeMeta(...)`。`remoteCacheId == null` (start 失敗) はフェイルオープン (wipe しない)。

- [ ] **Step 1: 失敗テスト**

```dart
// 1. schema 不一致で wipe される
// 2. cacheId 不一致で wipe + lastSeenCacheId 更新
// 3. cacheId 一致なら wipe しない
// 4. remoteCacheId null (start 失敗) なら wipe しない (フェイルオープン)
```

- [ ] **Step 2: 失敗確認** → FAIL

- [ ] **Step 3: 実装**

```dart
// app/lib/core/cache/wipe/cache_wipe_service.dart
import 'package:eqmonitor/core/cache/cache_constants.dart';
import 'package:eqmonitor/core/cache/drift/cache_database.dart';
import 'package:eqmonitor/core/cache/http/http_cache_store.dart';

class CacheWipeService {
  CacheWipeService({required this.db, required this.httpCacheStore});
  final CacheDatabase db;
  final HttpCacheStore httpCacheStore;

  Future<void> reconcileOnStartup({required String? remoteCacheId}) async {
    final schema = await db.readSchemaVersionMeta();
    final lastSeen = await db.readLastSeenCacheId();
    final schemaMismatch = schema != kCacheSchemaVersion;
    // start 失敗 (null) はフェイルオープン: cacheId 由来 wipe をしない。
    final cacheIdMismatch =
        remoteCacheId != null && lastSeen != null && lastSeen != remoteCacheId;
    if (schemaMismatch || cacheIdMismatch) {
      await db.clearAllCache();
      await httpCacheStore.clearAll();
    }
    await db.writeMeta(
      schemaVersion: kCacheSchemaVersion,
      lastSeenCacheId: remoteCacheId ?? lastSeen,
    );
  }
}
```

> stale 即時表示は犠牲にしない: `reconcileOnStartup` は起動時に呼ぶが、一覧 provider の Drift 即時表示をブロックしない (並行に走らせ、wipe 確定後に invalidate)。結線箇所は app 起動シーケンス (main / splash) を Read して特定し、`/v1/start` 解決後に呼ぶ。

- [ ] **Step 4: 緑 + 結線 + コミット**

Run: `cd app && flutter test test/core/cache/cache_wipe_test.dart` → PASS
```bash
git add app/lib/core/cache/wipe/cache_wipe_service.dart app/test/core/cache/cache_wipe_test.dart
git commit -m "feat(cache): add startup bulk wipe on cacheId/schema mismatch"
```

---

## Task 13: 詳細キャッシュ

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart`
- Test: `app/test/feature/earthquake_history/data/detail_cache_test.dart`

**Interfaces:**
- Consumes: `cacheDatabaseProvider.readDetail/upsertDetail`, repository `fetchEarthquakeDetail`。
- Produces: 詳細 build = キャッシュ即返し → `fetchEarthquakeDetail` 単純 refetch (差分なし、ETag/304 は計画C 層が担保) → upsert。

- [ ] **Step 1: 失敗テスト** — キャッシュ有り時に即値を返し、その後ネットワーク値で更新されること。

- [ ] **Step 2〜4: 実装/緑/コミット**

```dart
@riverpod
class EarthquakeHistoryDetailsNotifier extends _$EarthquakeHistoryDetailsNotifier {
  @override
  Future<Earthquake> build(String eventId) async {
    final db = ref.watch(cacheDatabaseProvider);
    final repository = await ref.watch(earthquakeHistoryRepositoryProvider.future);
    final cached = await db.readDetail(eventId);
    if (cached != null) {
      // 即時返し + 裏で refetch
      unawaited(_revalidate(eventId, db, repository));
      return Earthquake.fromJson(jsonDecode(cached.payload) as Map<String, Object?>);
    }
    final fresh = await repository.fetchEarthquakeDetail(eventId: eventId);
    await _store(db, eventId, fresh);
    return fresh;
  }
  // _revalidate / _store は payload(JSON) を upsertDetail。state = AsyncData(fresh)。
}
```
```bash
git commit -m "feat(earthquake): cache earthquake detail with stale-then-refetch"
```

---

## Task 14: PR 作成

- [ ] **Step 1: ブランチ確認・全テスト・analyze**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
git branch --show-current   # develop でないこと (例: feat/earthquake-swr-drift)
cd app && flutter test && dart analyze && dart format --set-exit-if-changed .
```
Expected: 全 PASS / No issues

- [ ] **Step 2: PR 作成**

```bash
gh pr create --repo YumNumm/EQMonitor --base develop \
  --title "feat(earthquake): Drift SWR cache for earthquake history (計画D)" \
  --body "計画D。Drift 永続キャッシュ + SWR (stale-while-revalidate)。依存: 計画B(API型)/計画C(ETag層)。設計: docs/superpowers/specs/2026-06-23-earthquake-swr-cache-design.md セクション2/3/5。"
```

---

## Self-Review

**1. Spec coverage:** §2 (Drift/SWR/段階的マージ/カーソル前進/ロングギャップ/直列キュー/自己修復ガード/保持の domain age) → Task 5/7/8/10/11、§3 (Chip) → Task 6、§5 一部 (自己修復・wipe) → Task 11/12、詳細キャッシュ → Task 13、app モデル拡張 → Task 1。保持戦略トグル/overlay/設定UI は**計画E** に委譲 (本計画は `deleteOlderThan` DAO まで提供)。

**2. Placeholder scan:** Task 10 の SWR 結線・Task 11 の復元パス・Task 12 結線は「実コードは既存構造を Read して拡張」と指示。これは既存 paging_view DataSource の内部に依存するため、純粋ロジック (merge/cursor/queue/guard) を切り出して TDD し、結線部はウィジェット/統合テストで担保する設計。完全な逐次コードは執行時に現行 `earthquake_history_data_source.dart` を確定読込してから書く前提 (no-placeholder の例外を最小化するため核ロジックは全て実コード済み)。

**3. Type consistency:** 契約書 §4 と一致 — `CacheDatabase` / テーブル名 / `cacheScopeOf` / `HourBucketJst.floor`.value / `CacheWriteQueue.run` / `CacheRevalidationState` 4種 / `cacheRevalidationStateProvider(scope)` / `kCacheSchemaVersion`。計画C 消費は `httpCacheStore`/`evict`/`clearAll`/`primaryKeyForUrl`。計画B 消費は `EarthquakePartial.updatedAt/lastReportedAt`・`getV2Earthquake(lastUpdatedSince,cacheId)`・`StartResponse.cacheId`。

**4. 懸念点:**
- `EarthquakeHistoryNotifier` (未使用) と本計画の DataSource が二重に存在。本計画は DataSource のみ SWR 化。未使用 Notifier の削除は別 PR で検討。
- paging_view `GroupedDataSource` の SWR 結線は内部 API 依存度が高い。`revalidate` の純粋部分を切り出してテスト可能にし、UI 結線はウィジェットテストで担保する方針。執行時に paging_view のバージョン (pubspec) と `insertItem`/`updateItem`/`notifier.values` の現行 API を確認。
- `CacheMetaTable` 単一行 (id=0 固定) はシンプル化のため。複数行不要 ([[avoid-incidental-complexity]])。
- `/v1/start` の `cacheId` を読む provider は既存の start 取得経路 (shared_preferences `startBody` に保存される) を Read して特定する必要がある。Task 12 で確定。
