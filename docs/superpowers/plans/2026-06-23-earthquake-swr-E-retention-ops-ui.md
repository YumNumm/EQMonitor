# App 保持戦略・運用UI Implementation Plan (計画E)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** SWR キャッシュ (計画D) の保持戦略 (すべて保持 / TTL 90日 / なし) をデバッグ画面で切替可能にし、設定画面に「キャッシュ削除」+ DB サイズ表示を追加し、build flag でキャッシュ状態オーバーレイを出せるようにする。

**Architecture:** 保持戦略は enum + shared_preferences 永続化。起動時に `ttl90Days` なら `CacheDatabase.deleteOlderThan` (last_reported_at 基準) で刈り取り。`none` は Drift 書き込みスキップ。`BuildConfig.isCacheOverlayEnabled` で各 scope のキャッシュ状態を可視化する Overlay ウィジェットを表示。

**Tech Stack:** Riverpod, Freezed, shared_preferences, Flutter (Material), Drift (計画D の `CacheDatabase`)。

## Global Constraints

- `dart analyze` 警告ゼロ。`dart format` 準拠。package import。
- **1ファイル1公開Provider** ([[one-public-provider-per-file]])。
- 新規IFは契約書 (`docs/superpowers/plans/2026-06-23-earthquake-swr-CONTRACT.md`) §5 に一致。
- 場当たり的な複雑化を避ける ([[avoid-incidental-complexity]])。
- codegen 後は `dart run build_runner build --delete-conflicting-outputs` + 生成物コミット。
- PR は **`gh pr create --repo YumNumm/EQMonitor --base develop`**。

## 依存 (前提)

- **計画D 完了**: `CacheDatabase` (`app/lib/core/cache/drift/cache_database.dart`) と `cacheDatabaseProvider`、DAO `deleteOlderThan(DateTime)`/`clearAllCache()`、`CacheWriteQueue`、`cacheScopeOf`、`CacheRevalidationState`/`cacheRevalidationStateProvider(scope)`、`kCacheSchemaVersion` が存在。
- **計画C 完了**: `httpCacheStore` provider + `HttpCacheStore.clearAll()`。
- 計画D が `none` 戦略時に書き込みをスキップできるよう、Task 2 の `cacheRetentionStrategyProvider` を計画D の SWR 書き込みパスが参照する (本計画で provider を提供 → 計画D 側でガードを足す。両計画の結線点を懸念に明記)。

## パッケージ境界 (契約書 §0 — 改訂)

> **重要**: 純粋インフラ (`CacheRetentionStrategy` enum・`CachePruner`) は **`packages/cache`**。Riverpod provider・UI・shared_preferences 結線は `app`。タスク本文中の `app/lib/core/cache/model/...`・`.../retention/cache_pruner.dart` パスは下表の `packages/cache` パスに読み替え、import は `package:cache/cache.dart` に読み替える。

## ファイル構成

**`packages/cache` (Riverpod 非依存):**
- `packages/cache/lib/src/model/cache_retention_strategy.dart` — `CacheRetentionStrategy` enum + `ttl`/`label` + `kDefaultCacheRetentionStrategy`。
- `packages/cache/lib/src/retention/cache_pruner.dart` — `CachePruner.pruneOnStartup(...)` (起動時刈り取り。`CacheDatabase`/`HttpCacheStore` を引数注入)。
- `packages/cache/lib/cache.dart` — export 追記。

**`app` (Riverpod provider・UI):**
- `app/lib/feature/settings/data/cache_retention_provider.dart` — `cacheRetentionStrategyProvider` (永続化付き、公開Provider 1個)。
- `app/lib/core/cache/ui/cache_status_overlay.dart` — overlay ウィジェット。
- `app/lib/feature/settings/children/config/debug/cache_retention_tile.dart` — デバッグ画面トグル。
- `app/lib/feature/settings/components/cache_management_tile.dart` — 設定画面 削除 + サイズ。
- 変更: `app/lib/core/data/preferences/shared/shared_preferences_key.dart` (`cacheRetentionStrategy` 追加)、`app/lib/core/model/environment.dart` (`isCacheOverlayEnabled`)、`app/lib/feature/settings/settings_page.dart` (`CacheManagementTile`)、`.../debug/debug_page.dart` (`CacheRetentionTile`)。
- `CachePruner` の起動結線は app (計画D の `CacheWipeService` と同じ起動箇所)。

---

## Task 1: `CacheRetentionStrategy` enum

**Files:**
- Create: `app/lib/core/cache/model/cache_retention_strategy.dart`
- Test: `app/test/core/cache/cache_retention_strategy_test.dart`

**Interfaces:**
- Produces:
  ```dart
  enum CacheRetentionStrategy {
    keepAll, ttl90Days, none;
    Duration? get ttl; // ttl90Days→90日, それ以外→null
    String get label;  // 日本語表示
  }
  const kDefaultCacheRetentionStrategy = CacheRetentionStrategy.ttl90Days;
  ```

- [ ] **Step 1: 失敗テスト**

```dart
// app/test/core/cache/cache_retention_strategy_test.dart
import 'package:eqmonitor/core/cache/model/cache_retention_strategy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ttl maps only for ttl90Days', () {
    expect(CacheRetentionStrategy.ttl90Days.ttl, const Duration(days: 90));
    expect(CacheRetentionStrategy.keepAll.ttl, isNull);
    expect(CacheRetentionStrategy.none.ttl, isNull);
  });
  test('default is ttl90Days', () {
    expect(kDefaultCacheRetentionStrategy, CacheRetentionStrategy.ttl90Days);
  });
}
```

- [ ] **Step 2: 失敗確認** — Run: `cd app && flutter test test/core/cache/cache_retention_strategy_test.dart` → FAIL

- [ ] **Step 3: 実装**

```dart
// app/lib/core/cache/model/cache_retention_strategy.dart
enum CacheRetentionStrategy {
  keepAll,
  ttl90Days,
  none;

  Duration? get ttl =>
      this == CacheRetentionStrategy.ttl90Days ? const Duration(days: 90) : null;

  String get label => switch (this) {
        CacheRetentionStrategy.keepAll => 'すべて保持',
        CacheRetentionStrategy.ttl90Days => 'TTL 90日 (デフォルト)',
        CacheRetentionStrategy.none => 'キャッシュなし',
      };
}

const kDefaultCacheRetentionStrategy = CacheRetentionStrategy.ttl90Days;
```

- [ ] **Step 4: 緑 + コミット** → PASS
```bash
git add app/lib/core/cache/model/cache_retention_strategy.dart app/test/core/cache/cache_retention_strategy_test.dart
git commit -m "feat(cache): add CacheRetentionStrategy enum"
```

---

## Task 2: 永続化 provider `cacheRetentionStrategyProvider`

**Files:**
- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`
- Create: `app/lib/core/cache/retention/cache_retention_provider.dart`
- Test: `app/test/core/cache/cache_retention_provider_test.dart`

**Interfaces:**
- Consumes: `sharedPreferencesProvider` (`SharedPreferencesAsync`)。
- Produces: `@riverpod class CacheRetentionStrategyNotifier` → `cacheRetentionStrategyProvider`。`build()` で SP から復元 (無ければ default)。`Future<void> set(CacheRetentionStrategy)` で永続化 + state 更新。

- [ ] **Step 1: SharedPreferencesKey 追加**

```dart
// shared_preferences_key.dart の enum に追加
cacheRetentionStrategy('cache_retention_strategy'),
```

- [ ] **Step 2: 失敗テスト**

```dart
// app/test/core/cache/cache_retention_provider_test.dart
// ProviderContainer + sharedPreferencesProvider override (in-memory SharedPreferences)。
// 1. 初期値は kDefaultCacheRetentionStrategy
// 2. set(none) 後に再構築しても none が復元される (SP 永続化)
```

> 既存テストの SharedPreferences override パターン (`SharedPreferences.setMockInitialValues({})` → `sharedPreferencesProvider.overrideWithValue(SharedPreferencesAsync(prefs))`) を `app/test/` から grep して流用。

- [ ] **Step 3: 失敗確認** → FAIL

- [ ] **Step 4: 実装**

```dart
// app/lib/core/cache/retention/cache_retention_provider.dart
import 'package:eqmonitor/core/cache/model/cache_retention_strategy.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_retention_provider.g.dart';

@riverpod
class CacheRetentionStrategyNotifier extends _$CacheRetentionStrategyNotifier {
  @override
  CacheRetentionStrategy build() {
    final raw = ref
        .watch(sharedPreferencesProvider)
        .getString(SharedPreferencesKey.cacheRetentionStrategy.key);
    return CacheRetentionStrategy.values
            .where((e) => e.name == raw)
            .firstOrNull ??
        kDefaultCacheRetentionStrategy;
  }

  Future<void> set(CacheRetentionStrategy value) async {
    await ref
        .read(sharedPreferencesProvider)
        .setString(SharedPreferencesKey.cacheRetentionStrategy.key, value.name);
    state = value;
  }
}
```

> `SharedPreferencesKey.key` の getter 名は実ファイルを Read して確認 (enum 値が `xxx('string')` でフィールド名が `key` か `value` か)。

- [ ] **Step 5: codegen + 緑 + コミット** → PASS
```bash
git add app/lib/core/data/preferences/shared/shared_preferences_key.dart app/lib/core/cache/retention/cache_retention_provider.* app/test/core/cache/cache_retention_provider_test.dart
git commit -m "feat(cache): persist cache retention strategy"
```

---

## Task 3: 起動時 TTL 刈り取り `CachePruner`

**Files:**
- Create: `app/lib/core/cache/retention/cache_pruner.dart`
- Test: `app/test/core/cache/cache_pruner_test.dart`

**Interfaces:**
- Consumes: `CacheDatabase.deleteOlderThan(DateTime)`/`clearAllCache()`, `httpCacheStore.clearAll()`。
- Produces: `class CachePruner { Future<int> pruneOnStartup({required CacheRetentionStrategy strategy, required DateTime now}); }` — `ttl90Days` → `deleteOlderThan(now - 90d)`、`none` → `clearAllCache()` + `httpCacheStore.clearAll()`、`keepAll` → 何もしない (0)。

- [ ] **Step 1: 失敗テスト**

```dart
// 1. ttl90Days: last_reported_at が 90日超の行のみ削除される (件数検証)
// 2. keepAll: 何も削除されない
// 3. none: 全 Drift 行 + httpCacheStore.clearAll() が呼ばれる
```

- [ ] **Step 2: 失敗確認** → FAIL

- [ ] **Step 3: 実装**

```dart
// app/lib/core/cache/retention/cache_pruner.dart
import 'package:eqmonitor/core/cache/drift/cache_database.dart';
import 'package:eqmonitor/core/cache/http/http_cache_store.dart';
import 'package:eqmonitor/core/cache/model/cache_retention_strategy.dart';

class CachePruner {
  CachePruner({required this.db, required this.httpCacheStore});
  final CacheDatabase db;
  final HttpCacheStore httpCacheStore;

  Future<int> pruneOnStartup({
    required CacheRetentionStrategy strategy,
    required DateTime now,
  }) async {
    switch (strategy) {
      case CacheRetentionStrategy.keepAll:
        return 0;
      case CacheRetentionStrategy.ttl90Days:
        final ttl = strategy.ttl!;
        return db.deleteOlderThan(now.subtract(ttl));
      case CacheRetentionStrategy.none:
        await db.clearAllCache();
        await httpCacheStore.clearAll();
        return 0;
    }
  }
}
```

- [ ] **Step 4: 緑 + 起動結線 + コミット**

> 起動シーケンス (計画D Task 12 の `CacheWipeService` を呼ぶ箇所と同じ場所) で `CachePruner.pruneOnStartup` を呼ぶ。stale 即時表示はブロックしない (並行)。結線箇所を Read で特定。
Run: `cd app && flutter test test/core/cache/cache_pruner_test.dart` → PASS
```bash
git add app/lib/core/cache/retention/cache_pruner.dart app/test/core/cache/cache_pruner_test.dart
git commit -m "feat(cache): prune cache on startup per retention strategy"
```

---

## Task 4: `isCacheOverlayEnabled` build flag

**Files:**
- Modify: `app/lib/core/model/environment.dart`
- Test: `app/test/core/model/environment_cache_overlay_test.dart`

**Interfaces:**
- Produces: `bool get isCacheOverlayEnabled => const bool.fromEnvironment('CACHE_OVERLAY_ENABLED');` (`BuildConfig` 内、既存 `isBetaTesting` と同パターン)。

- [ ] **Step 1: 失敗テスト** — `BuildConfig` インスタンスで `isCacheOverlayEnabled` が呼べ、デフォルト (未定義) で false。

- [ ] **Step 2: 失敗確認** → FAIL

- [ ] **Step 3: 実装**

```dart
// environment.dart の BuildConfig に追加 (isBetaTesting の隣)
bool get isCacheOverlayEnabled =>
    const bool.fromEnvironment('CACHE_OVERLAY_ENABLED');
```

- [ ] **Step 4: codegen 不要 / 緑 + コミット** → PASS
```bash
git add app/lib/core/model/environment.dart app/test/core/model/environment_cache_overlay_test.dart
git commit -m "feat(cache): add CACHE_OVERLAY_ENABLED build flag"
```

---

## Task 5: キャッシュ状態オーバーレイ `CacheStatusOverlay`

**Files:**
- Create: `app/lib/core/cache/ui/cache_status_overlay.dart`
- Test: `app/test/core/cache/cache_status_overlay_test.dart`

**Interfaces:**
- Consumes: `buildConfigProvider.isCacheOverlayEnabled`, `cacheRevalidationStateProvider(scope)`, `cacheDatabaseProvider.readScope(scope)` (件数・最新 fetchedAt)。
- Produces: `class CacheStatusOverlay extends ConsumerWidget { final String scope; final Widget child; }` — flag OFF なら `child` をそのまま返す。ON なら `child` の上に小さなバッジ (cached/stale/revalidating/fresh・件数・最新 fetchedAt・scope) を Stack で重ねる。

- [ ] **Step 1: 失敗テスト (ウィジェット)**

```dart
// 1. isCacheOverlayEnabled=false → バッジ非表示 (child のみ)
// 2. isCacheOverlayEnabled=true → scope 文字列と件数がバッジに出る
// 3. revalidation state が revalidating のときラベルに "revalidating" を含む
```

- [ ] **Step 2: 失敗確認** → FAIL

- [ ] **Step 3: 実装**

```dart
// app/lib/core/cache/ui/cache_status_overlay.dart
import 'package:eqmonitor/core/cache/drift/cache_database_provider.dart';
import 'package:eqmonitor/core/cache/model/cache_revalidation_state.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/cache_revalidation_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CacheStatusOverlay extends ConsumerWidget {
  const CacheStatusOverlay({
    required this.scope,
    required this.child,
    super.key,
  });
  final String scope;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(buildConfigProvider).isCacheOverlayEnabled;
    if (!enabled) {
      return child;
    }
    final revalidation = ref.watch(cacheRevalidationStateProvider(scope));
    final label = switch (revalidation) {
      CacheRevalidationIdle() => 'fresh',
      CacheRevalidationRevalidating() => 'revalidating',
      CacheRevalidationOffline() => 'offline',
      CacheRevalidationFailed() => 'failed',
    };
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: IgnorePointer(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              color: Colors.black54,
              child: Text(
                '$scope · $label',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

> 件数・最新 fetchedAt は `cacheDatabaseProvider.readScope(scope)` を `FutureBuilder`/別 provider で取得しラベルに付加 (テスト 2 の検証対象)。実装時に件数 provider を 1 ファイル 1 公開で足すか、overlay 内で読むかを決める。

- [ ] **Step 4: 緑 + 一覧/詳細への結線 + コミット**

> 一覧 page (`earthquake_history_page.dart`) と詳細 page を `CacheStatusOverlay(scope: cacheScopeOf(parameter), child: ...)` で包む。
Run: `cd app && flutter test test/core/cache/cache_status_overlay_test.dart` → PASS
```bash
git add app/lib/core/cache/ui/cache_status_overlay.dart app/test/core/cache/cache_status_overlay_test.dart app/lib/feature/earthquake_history/ui/earthquake_history_page.dart
git commit -m "feat(cache): add cache status overlay behind build flag"
```

---

## Task 6: デバッグ画面 保持戦略トグル

**Files:**
- Create: `app/lib/feature/settings/children/config/debug/cache_retention_tile.dart`
- Modify: `app/lib/feature/settings/children/config/debug/debug_page.dart`
- Test: `app/test/feature/settings/cache_retention_tile_test.dart`

**Interfaces:**
- Consumes: `cacheRetentionStrategyProvider` + `.notifier.set()`。
- Produces: `class CacheRetentionTile extends ConsumerWidget` — 現在戦略を表示し、タップで 3 択ダイアログ → `set()`。

- [ ] **Step 1: 失敗テスト (ウィジェット)** — Tile が現在戦略 label を表示し、選択で `set` が呼ばれること。

- [ ] **Step 2: 失敗確認** → FAIL

- [ ] **Step 3: 実装**

```dart
// cache_retention_tile.dart
import 'package:eqmonitor/core/cache/model/cache_retention_strategy.dart';
import 'package:eqmonitor/core/cache/retention/cache_retention_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CacheRetentionTile extends ConsumerWidget {
  const CacheRetentionTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(cacheRetentionStrategyProvider);
    return ListTile(
      title: const Text('キャッシュ保持戦略'),
      subtitle: Text(current.label),
      onTap: () async {
        final selected = await showDialog<CacheRetentionStrategy>(
          context: context,
          builder: (context) => SimpleDialog(
            title: const Text('キャッシュ保持戦略'),
            children: [
              for (final s in CacheRetentionStrategy.values)
                SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, s),
                  child: Text(s.label),
                ),
            ],
          ),
        );
        if (selected != null) {
          await ref.read(cacheRetentionStrategyProvider.notifier).set(selected);
        }
      },
    );
  }
}
```

- [ ] **Step 4: debug_page に追加** — `DebugPage` の ListView に `const CacheRetentionTile()` を追記。

- [ ] **Step 5: 緑 + コミット** → PASS
```bash
git add app/lib/feature/settings/children/config/debug/cache_retention_tile.dart app/lib/feature/settings/children/config/debug/debug_page.dart app/test/feature/settings/cache_retention_tile_test.dart
git commit -m "feat(settings): add cache retention strategy toggle to debug page"
```

---

## Task 7: 設定画面「キャッシュ削除」+ DB サイズ

**Files:**
- Create: `app/lib/feature/settings/components/cache_management_tile.dart`
- Modify: `app/lib/feature/settings/settings_page.dart`
- Test: `app/test/feature/settings/cache_management_tile_test.dart`

**Interfaces:**
- Consumes: `cacheDatabaseProvider.clearAllCache()`, `httpCacheStore.clearAll()`。DB サイズは Drift DB ファイルパスの `File.length()`。
- Produces: `class CacheManagementTile extends ConsumerWidget` — サブタイトルに DB サイズ、タップで確認ダイアログ → 全消去。

- [ ] **Step 1: 失敗テスト (ウィジェット)** — Tile タップ → 確認 → `clearAllCache` + `httpCacheStore.clearAll` が呼ばれる。サイズ表示 (バイト→人間可読) のフォーマット。

- [ ] **Step 2: 失敗確認** → FAIL

- [ ] **Step 3: 実装**

```dart
// cache_management_tile.dart
import 'dart:io';
import 'package:eqmonitor/core/cache/drift/cache_database_provider.dart';
import 'package:eqmonitor/core/cache/http/http_cache_store.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class CacheManagementTile extends ConsumerWidget {
  const CacheManagementTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.delete_sweep_outlined),
      title: const Text('キャッシュを削除'),
      subtitle: FutureBuilder<int>(
        future: _cacheDbSizeBytes(),
        builder: (context, snapshot) => Text(
          snapshot.hasData ? 'DB サイズ: ${_humanReadable(snapshot.data!)}' : '…',
        ),
      ),
      onTap: () async {
        final ok = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('キャッシュを削除'),
            content: const Text('地震履歴のキャッシュをすべて削除します。よろしいですか？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('削除'),
              ),
            ],
          ),
        );
        if (ok ?? false) {
          await ref.read(cacheDatabaseProvider).clearAllCache();
          await ref.read(httpCacheStoreProvider).clearAll();
        }
      },
    );
  }
}

Future<int> _cacheDbSizeBytes() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/eqmonitor_cache.sqlite');
  return file.existsSync() ? file.length() : 0;
}

String _humanReadable(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
}
```

> Drift DB ファイル名/パスは計画D の `driftDatabase(name: 'eqmonitor_cache')` の実際の解決先を Read して合わせる (`drift_flutter` のデフォルトは application support / documents)。`httpCacheStoreProvider` 名は計画C を確認。`_humanReadable` は純関数なので Step 1 で単体テストも書く。

- [ ] **Step 4: settings_page に追加** — 「アプリの情報」セクション付近の ListView に `const CacheManagementTile()` を追記。

- [ ] **Step 5: 緑 + コミット** → PASS
```bash
git add app/lib/feature/settings/components/cache_management_tile.dart app/lib/feature/settings/settings_page.dart app/test/feature/settings/cache_management_tile_test.dart
git commit -m "feat(settings): add cache deletion tile with DB size"
```

---

## Task 8: PR 作成

- [ ] **Step 1: ブランチ確認・全テスト・analyze・format**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
git branch --show-current   # develop でないこと (例: feat/earthquake-swr-retention)
cd app && flutter test && dart analyze && dart format --set-exit-if-changed .
```
Expected: 全 PASS / No issues

- [ ] **Step 2: PR 作成**

```bash
gh pr create --repo YumNumm/EQMonitor --base develop \
  --title "feat(cache): retention strategy + ops UI for SWR cache (計画E)" \
  --body "計画E。保持戦略(すべて保持/TTL90日/なし)・キャッシュ削除UI・DBサイズ表示・cache overlay flag。依存: 計画C/計画D。設計: docs/superpowers/specs/2026-06-23-earthquake-swr-cache-design.md セクション5。"
```

---

## Self-Review

**1. Spec coverage:** §5 (保持戦略 3 種 + デフォルト ttl90 + 起動時クリア) → Task 1/2/3、保持基準 `last_reported_at` (domain age) → Task 3 (`deleteOlderThan` は計画D が last_reported_at 基準で実装)、cache overlay flag → Task 4/5、設定画面 削除 ListTile + DB サイズ → Task 7、デバッグ画面トグル → Task 6。自己修復ログ/typed talker は計画D。

**2. Placeholder scan:** Task 5 の件数表示・Task 7 の DB パス・起動結線は「計画D/C の実体を Read して合わせる」と指示。純関数 (`_humanReadable`/`ttl`/`pruneOnStartup`) は実コード済み。UI 結線はウィジェットテストで担保。

**3. Type consistency:** 契約書 §5 と一致 — `CacheRetentionStrategy { keepAll, ttl90Days, none }` / デフォルト `ttl90Days` / SP キー `cacheRetentionStrategy` / `isCacheOverlayEnabled`。計画D 消費は `CacheDatabase.deleteOlderThan/clearAllCache`・`cacheScopeOf`・`cacheRevalidationStateProvider`・`cacheDatabaseProvider`。計画C 消費は `httpCacheStore`/`clearAll`。

**4. 懸念点:**
- **`none` 戦略の書き込みスキップは計画D 側の結線が必要**: 本計画は `cacheRetentionStrategyProvider` を提供するのみ。計画D の SWR 書き込みパスが `if (strategy == none) skip` を持つ必要がある。両計画の結線点 (計画D Task 10) を実装時に確認し、不足なら計画D へ追補 PR。
- Drift DB ファイルパス (`eqmonitor_cache.sqlite`) は `drift_flutter` のデフォルト解決先依存。Task 7 で実パスを確認 (getApplicationSupportDirectory の可能性)。
- `SharedPreferencesKey` の getter 名 (`.key` か `.value` か) は実ファイル確認。
- 設定画面の挿入位置は既存 `SettingsSectionHeader` 構成に合わせ、デバッグ専用にするか常時表示かは UX 判断 (削除 Tile は常時、保持戦略トグルはデバッグ画面)。
