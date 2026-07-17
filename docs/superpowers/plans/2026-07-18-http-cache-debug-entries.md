# HTTPキャッシュ エントリ一覧デバッグ画面 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Debug 配下に HTTP キャッシュのエントリ一覧画面を追加し、各エントリのサイズ表示・インライン詳細展開・個別削除・全削除を可能にする。

**Architecture:** `packages/cache` に body 非読込の一覧 API（`HttpCacheEntrySummary` + `listSummaries`）を追加し、app 側は SharedPreferences デバッグと同型の Debug サブページ + Riverpod provider + Action で削除を扱う。サイズ表示は既存 `formatBytes` を `ByteSizeFormatter` に共通化する。

**Tech Stack:** Flutter, Riverpod (`@riverpod`), flutter_hooks, go_router_builder, Drift (`packages/cache`), Material 3

**Spec:** `docs/superpowers/specs/2026-07-18-http-cache-debug-entries-design.md`

## Global Constraints

- テストは追加しない（仕様で不要と明記）
- Flutter / Dart コマンドは常に `mise exec --` 経由
- コード生成: `mise exec -- dart run build_runner build --delete-conflicting-outputs`（該当パッケージ）または `mise exec -- melos run generate`
- top-level / プライベート関数禁止。ロジックはクラス、イベントは Action、単純変換はインライン変数
- Widget に関数・ゲッターを定義しない。`StatefulWidget` 禁止（`HookConsumerWidget`）
- `!` 禁止。`dynamic` / `Object` は `Map<String, dynamic>` 以外禁止
- Action: `ref` / `context` はコンストラクタに渡さずメソッド引数で受け取る
- コミットメッセージ: 英語1単語 prefix + 日本語1行
- body プレビュー・検索フィルタ・設定画面 UI 変更はスコープ外

---

## File Structure

新規:
- `packages/cache/lib/src/http/http_cache_entry_summary.dart` — 一覧用モデル（body なし）
- `app/lib/core/util/byte_size_formatter.dart` — B/KB/MB 整形
- `app/lib/feature/settings/children/config/debug/http_cache/http_cache_key_display.dart` — キーから URL 表示文字列を抽出
- `app/lib/feature/settings/children/config/debug/http_cache/debug_http_cache_entries_provider.dart` — 一覧 FutureProvider
- `app/lib/feature/settings/children/config/debug/http_cache/debug_http_cache_action.dart` — 個別/全削除
- `app/lib/feature/settings/children/config/debug/http_cache/debug_http_cache_page.dart` — 画面

変更:
- `packages/cache/lib/src/database/http_cache_database.dart` — `listEntrySummaries`
- `packages/cache/lib/src/http/http_cache_store.dart` — `listSummaries`
- `packages/cache/lib/cache.dart` — export 追加
- `app/lib/feature/settings/settings_page.dart` — `formatBytes` を `ByteSizeFormatter` に置換
- `app/lib/core/router/router.dart` — `DebugHttpCacheRoute`
- `app/lib/feature/settings/children/config/debug/debug_page.dart` — 導線 ListTile

生成（手編集禁止）:
- `debug_http_cache_entries_provider.g.dart`
- `debug_http_cache_action.g.dart`
- `router.g.dart`（必要に応じて）

---

### Task 1: packages/cache に一覧 API を追加

**Files:**
- Create: `packages/cache/lib/src/http/http_cache_entry_summary.dart`
- Modify: `packages/cache/lib/src/database/http_cache_database.dart`
- Modify: `packages/cache/lib/src/http/http_cache_store.dart`
- Modify: `packages/cache/lib/cache.dart`

**Interfaces:**
- Produces:
  ```dart
  class HttpCacheEntrySummary {
    const HttpCacheEntrySummary({
      required this.key,
      required this.statusCode,
      required this.eTag,
      required this.headers,
      required this.responseType,
      required this.updatedAtMs,
      required this.bodySizeBytes,
    });
    final String key;
    final int statusCode;
    final String? eTag;
    final Map<String, List<String>> headers;
    final String responseType;
    final int updatedAtMs;
    final int bodySizeBytes;
  }

  // CacheDatabase
  Future<List<({
    String key,
    int statusCode,
    String? eTag,
    String headers,
    String responseType,
    int updatedAtMs,
    int bodySizeBytes,
  })>> listEntrySummaries();

  // HttpCacheStore
  Future<List<HttpCacheEntrySummary>> listSummaries();
  ```
- Consumes: 既存 `CacheDatabase` / `HttpCacheStore` / `jsonDecode` パターン（`read` と同型の headers decode）

- [ ] **Step 1: `HttpCacheEntrySummary` を追加**

`packages/cache/lib/src/http/http_cache_entry_summary.dart`:

```dart
class HttpCacheEntrySummary {
  const HttpCacheEntrySummary({
    required this.key,
    required this.statusCode,
    required this.eTag,
    required this.headers,
    required this.responseType,
    required this.updatedAtMs,
    required this.bodySizeBytes,
  });

  final String key;
  final int statusCode;
  final String? eTag;
  final Map<String, List<String>> headers;
  final String responseType;
  final int updatedAtMs;
  final int bodySizeBytes;
}
```

- [ ] **Step 2: `CacheDatabase.listEntrySummaries` を追加**

`http_cache_database.dart` に追加（body BLOB を読まず `length(body)` でサイズ取得）:

```dart
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
```

- [ ] **Step 3: `HttpCacheStore.listSummaries` を追加**

`http_cache_store.dart` の import に `http_cache_entry_summary.dart` を追加し、メソッドを追加:

```dart
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
```

- [ ] **Step 4: barrel export を更新**

`packages/cache/lib/cache.dart` に追加:

```dart
export 'src/http/http_cache_entry_summary.dart';
```

- [ ] **Step 5: 解析確認**

Run:

```bash
cd packages/cache && mise exec -- dart analyze
```

Expected: 警告・エラーなし

- [ ] **Step 6: Commit**

```bash
git add packages/cache/lib/src/http/http_cache_entry_summary.dart \
  packages/cache/lib/src/database/http_cache_database.dart \
  packages/cache/lib/src/http/http_cache_store.dart \
  packages/cache/lib/cache.dart
git commit -m "$(cat <<'EOF'
feat: HTTPキャッシュのエントリ一覧APIを追加

EOF
)"
```

---

### Task 2: `ByteSizeFormatter` 共通化

**Files:**
- Create: `app/lib/core/util/byte_size_formatter.dart`
- Modify: `app/lib/feature/settings/settings_page.dart`

**Interfaces:**
- Produces:
  ```dart
  class ByteSizeFormatter {
    const ByteSizeFormatter();
    String format(int bytes);
  }
  ```
  - `< 1024` → `'$bytes B'`
  - `< 1024 * 1024` → `'${(bytes / 1024).toStringAsFixed(1)} KB'`
  - それ以外 → `'${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB'`
- Consumes: なし

- [ ] **Step 1: `ByteSizeFormatter` を作成**

`app/lib/core/util/byte_size_formatter.dart`:

```dart
class ByteSizeFormatter {
  const ByteSizeFormatter();

  String format(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
```

- [ ] **Step 2: `settings_page.dart` を置換**

1. import 追加: `package:eqmonitor/core/util/byte_size_formatter.dart`
2. 容量表示の `data: formatBytes` を `data: const ByteSizeFormatter().format` に変更
3. ファイル末尾の top-level `String formatBytes(int bytes) { ... }` を削除

- [ ] **Step 3: 解析確認**

Run:

```bash
cd app && mise exec -- dart analyze lib/feature/settings/settings_page.dart lib/core/util/byte_size_formatter.dart
```

Expected: 問題なし

- [ ] **Step 4: Commit**

```bash
git add app/lib/core/util/byte_size_formatter.dart \
  app/lib/feature/settings/settings_page.dart
git commit -m "$(cat <<'EOF'
refactor: formatBytes を ByteSizeFormatter に共通化

EOF
)"
```

---

### Task 3: Debug 用 provider / key 表示 / Action

**Files:**
- Create: `app/lib/feature/settings/children/config/debug/http_cache/http_cache_key_display.dart`
- Create: `app/lib/feature/settings/children/config/debug/http_cache/debug_http_cache_entries_provider.dart`
- Create: `app/lib/feature/settings/children/config/debug/http_cache/debug_http_cache_action.dart`
- Generate: 対応する `.g.dart`

**Interfaces:**
- Produces:
  ```dart
  class HttpCacheKeyDisplay {
    const HttpCacheKeyDisplay();
    String urlLabel({required String key});
  }

  // @riverpod
  Future<List<HttpCacheEntrySummary>> debugHttpCacheEntries(Ref ref);

  // @riverpod
  DebugHttpCacheAction debugHttpCacheAction(Ref ref);

  class DebugHttpCacheAction {
    Future<void> deleteEntry(
      WidgetRef ref,
      BuildContext context, {
      required String key,
    });
    Future<void> clearAll(WidgetRef ref, BuildContext context);
  }
  ```
- Consumes: `httpCacheStoreProvider`, `httpCacheSizeProvider`, `HttpCacheStore.listSummaries` / `evict` / `clearAll` / `vacuum`

- [ ] **Step 1: `HttpCacheKeyDisplay` を作成**

キー形式は `v{schema}:{appBuild}:{url}`（`appBuild` に `:` は含まれない）。先頭2セグメントを除いた残りを URL として返す。パース不能ならキー全文。

```dart
class HttpCacheKeyDisplay {
  const HttpCacheKeyDisplay();

  String urlLabel({required String key}) {
    final first = key.indexOf(':');
    if (first < 0) {
      return key;
    }
    final second = key.indexOf(':', first + 1);
    if (second < 0) {
      return key;
    }
    final url = key.substring(second + 1);
    return url.isEmpty ? key : url;
  }
}
```

- [ ] **Step 2: entries provider を作成**

`debug_http_cache_entries_provider.dart`:

```dart
import 'package:cache/cache.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_http_cache_entries_provider.g.dart';

@riverpod
Future<List<HttpCacheEntrySummary>> debugHttpCacheEntries(Ref ref) async {
  final store = await ref.watch(httpCacheStoreProvider.future);
  return store.listSummaries();
}
```

- [ ] **Step 3: Action を作成**

`debug_http_cache_action.dart`（`DebugAppGroupAction` と同型）:

```dart
import 'package:eqmonitor/core/api/http_cache_size_provider.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/http_cache/debug_http_cache_entries_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_http_cache_action.g.dart';

@riverpod
DebugHttpCacheAction debugHttpCacheAction(Ref ref) => DebugHttpCacheAction();

class DebugHttpCacheAction {
  Future<void> deleteEntry(
    WidgetRef ref,
    BuildContext context, {
    required String key,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('エントリを削除'),
        content: const Text('このキャッシュエントリを削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      return;
    }
    try {
      final store = await ref.read(httpCacheStoreProvider.future);
      await store.evict(key);
      ref
        ..invalidate(debugHttpCacheEntriesProvider)
        ..invalidate(httpCacheSizeProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('エントリを削除しました')),
        );
      }
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('削除に失敗しました: $e')),
        );
      }
    }
  }

  Future<void> clearAll(WidgetRef ref, BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('すべて削除'),
        content: const Text('HTTPキャッシュをすべて削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      return;
    }
    try {
      final store = await ref.read(httpCacheStoreProvider.future);
      await store.clearAll();
      await store.vacuum();
      ref
        ..invalidate(debugHttpCacheEntriesProvider)
        ..invalidate(httpCacheSizeProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('HTTPキャッシュを削除しました')),
        );
      }
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('削除に失敗しました: $e')),
        );
      }
    }
  }
}
```

- [ ] **Step 4: コード生成**

Run:

```bash
cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: `debug_http_cache_entries_provider.g.dart` と `debug_http_cache_action.g.dart` が生成される

- [ ] **Step 5: 解析確認**

Run:

```bash
cd app && mise exec -- dart analyze \
  lib/feature/settings/children/config/debug/http_cache/
```

Expected: 問題なし

- [ ] **Step 6: Commit**

```bash
git add app/lib/feature/settings/children/config/debug/http_cache/
git commit -m "$(cat <<'EOF'
feat: HTTPキャッシュデバッグ用の provider と Action を追加

EOF
)"
```

---

### Task 4: `DebugHttpCachePage` UI

**Files:**
- Create: `app/lib/feature/settings/children/config/debug/http_cache/debug_http_cache_page.dart`

**Interfaces:**
- Produces: `class DebugHttpCachePage extends HookConsumerWidget`
- Consumes: `debugHttpCacheEntriesProvider`, `httpCacheSizeProvider`, `debugHttpCacheActionProvider`, `ByteSizeFormatter`, `HttpCacheKeyDisplay`

- [ ] **Step 1: ページを実装**

要件:
- `HookConsumerWidget`
- AppBar: タイトル「HTTPキャッシュ」、再取得 IconButton、全削除 IconButton（`Icons.delete_sweep`）
- 再取得: `debugHttpCacheEntriesProvider` と `httpCacheSizeProvider` を invalidate
- 全削除: `ref.read(debugHttpCacheActionProvider).clearAll(ref, context)`
- ヘッダ（`ListView` 先頭の固定ブロックではなく、`CustomScrollView` + slivers、または `Column` + `Expanded(ListView)`）:
  - 総容量: `httpCacheSizeProvider` → `ByteSizeFormatter().format`
  - 件数: entries.length
- body: `AsyncValue` 分岐
  - loading: `CircularProgressIndicator` 中央
  - error: エラー文言 + 「再試行」ボタン（invalidate）
  - data empty: 「キャッシュエントリはありません」
  - data: `ListView.builder`
- 各行は private Widget `_HttpCacheEntryTile`
  - 折りたたみ: title = `HttpCacheKeyDisplay().urlLabel(key: entry.key)`、subtitle = `HTTP ${entry.statusCode} · ${formatter.format(entry.bodySizeBytes)}`
  - `useState<Set<String>>` で展開キーを管理（ページ側で1つ持つか、tile 内で `useState<bool>`）
  - 展開時に表示:
    - キー全文
    - 更新: `DateTime.fromMillisecondsSinceEpoch(entry.updatedAtMs).toLocal()` を `toString()`
    - statusCode / responseType
    - eTag（null なら「なし」）
    - Content-Type: `entry.headers['content-type']?.join(', ') ?? entry.headers['Content-Type']?.join(', ') ?? 'なし'`
    - 「このエントリを削除」ボタン → Action.deleteEntry
- Widget にメソッドを定義しない。展開 UI は private class に分割してよい
- `ListView.builder` を使う（`SingleChildScrollView` 禁止）

実装の骨格:

```dart
class DebugHttpCachePage extends HookConsumerWidget {
  const DebugHttpCachePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(debugHttpCacheEntriesProvider);
    final sizeAsync = ref.watch(httpCacheSizeProvider);
    const formatter = ByteSizeFormatter();
    const keyDisplay = HttpCacheKeyDisplay();

    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTPキャッシュ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '再取得',
            onPressed: () {
              ref
                ..invalidate(debugHttpCacheEntriesProvider)
                ..invalidate(httpCacheSizeProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'すべて削除',
            onPressed: () async {
              await ref
                  .read(debugHttpCacheActionProvider)
                  .clearAll(ref, context);
            },
          ),
        ],
      ),
      body: entriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('取得に失敗しました: $error'),
              TextButton(
                onPressed: () =>
                    ref.invalidate(debugHttpCacheEntriesProvider),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
        data: (entries) {
          // ヘッダ + ListView.builder（空表示含む）
          // ...
        },
      ),
    );
  }
}
```

`_HttpCacheEntryTile` は `HookConsumerWidget` または `HookWidget` で、タップで展開トグル、展開時に詳細 + 削除ボタン。

- [ ] **Step 2: 解析確認**

Run:

```bash
cd app && mise exec -- dart analyze \
  lib/feature/settings/children/config/debug/http_cache/debug_http_cache_page.dart
```

Expected: 問題なし

- [ ] **Step 3: Commit**

```bash
git add app/lib/feature/settings/children/config/debug/http_cache/debug_http_cache_page.dart
git commit -m "$(cat <<'EOF'
feat: HTTPキャッシュエントリ一覧デバッグ画面を追加

EOF
)"
```

---

### Task 5: ルーティングと Debug 導線

**Files:**
- Modify: `app/lib/core/router/router.dart`
- Modify: `app/lib/feature/settings/children/config/debug/debug_page.dart`
- Generate: `router.g.dart`（build_runner）

**Interfaces:**
- Produces: `DebugHttpCacheRoute`（path `http-cache`）→ `DebugHttpCachePage`
- Consumes: `DebugHttpCachePage`

- [ ] **Step 1: import と TypedGoRoute を追加**

`router.dart`:

1. import 追加:
```dart
import 'package:eqmonitor/feature/settings/children/config/debug/http_cache/debug_http_cache_page.dart';
```

2. `DebugRoute` の `routes` 内、`DebugSharedPreferencesRoute` の直後あたりに追加:
```dart
TypedGoRoute<DebugHttpCacheRoute>(path: 'http-cache'),
```

3. `DebugSharedPreferencesRoute` クラス定義の近くに追加:
```dart
class DebugHttpCacheRoute extends GoRouteData with $DebugHttpCacheRoute {
  const DebugHttpCacheRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugHttpCachePage();
  }
}
```

- [ ] **Step 2: `debug_page.dart` に導線を追加**

HTTPキャッシュ無効化トグルの直後（または直前）に:

```dart
ListTile(
  title: const Text('HTTPキャッシュ'),
  subtitle: const Text('キャッシュエントリの一覧・削除'),
  leading: const Icon(Icons.storage_outlined),
  onTap: () async =>
      const DebugHttpCacheRoute().push<void>(context),
),
```

必要な import:
```dart
import 'package:eqmonitor/core/router/router.dart'; // 既存なら追加不要。DebugHttpCacheRoute は router 経由
```

`DebugHttpCacheRoute` が `router.dart` で export されている既存パターンに合わせる（他の Debug*Route と同じ import）。

- [ ] **Step 3: コード生成**

Run:

```bash
cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: `$DebugHttpCacheRoute` が生成され、analyze が通る

- [ ] **Step 4: 解析確認**

Run:

```bash
cd app && mise exec -- dart analyze \
  lib/core/router/router.dart \
  lib/feature/settings/children/config/debug/debug_page.dart \
  lib/feature/settings/children/config/debug/http_cache/
```

Expected: 問題なし

- [ ] **Step 5: Commit & Push**

```bash
git add app/lib/core/router/router.dart \
  app/lib/core/router/router.g.dart \
  app/lib/feature/settings/children/config/debug/debug_page.dart
git commit -m "$(cat <<'EOF'
feat: HTTPキャッシュデバッグ画面への導線とルートを追加

EOF
)"
git push
```

---

### Task 6: 手動確認（チェックリスト）

テストコードは作らない。実機またはシミュレータで確認する。

- [ ] **Step 1: アプリ起動 → 設定 → デバッグメニュー →「HTTPキャッシュ」**

Expected: 画面が開き、総容量・件数が表示される

- [ ] **Step 2: 一覧表示**

Expected: 各行に URL・ステータス・サイズ（B/KB/MB）が出る。タップでキー全文・更新日時・ETag・Content-Type が展開される

- [ ] **Step 3: 個別削除**

Expected: 確認ダイアログ → 削除 → 一覧から消え SnackBar。総容量が更新される

- [ ] **Step 4: 全削除**

Expected: 確認ダイアログ → 空一覧。設定画面のキャッシュ容量も小さくなる（vacuum 済み）

- [ ] **Step 5: 問題があれば修正してコミット**

---

## Spec coverage (self-review)

| Spec 要件 | Task |
|---|---|
| エントリ一覧 | Task 1 + 3 + 4 |
| body 非読込のサイズ | Task 1 (`length(body)`) |
| formatBytes B/KB/MB | Task 2 + 4 |
| インライン展開（キー/日時/status/ETag/Content-Type） | Task 4 |
| 個別削除 + 全削除（確認付き） | Task 3 + 4 |
| Debug 導線 `/settings/debug/http-cache` | Task 5 |
| エラー表示 + 再試行 | Task 4 |
| テスト不要 | 全 Task（テストステップなし） |
| 設定画面キャッシュ UI 据え置き | Task 2 は format 共通化のみ |

## Placeholder / type consistency

- `listSummaries` / `HttpCacheEntrySummary` / `debugHttpCacheEntriesProvider` / `DebugHttpCacheAction` の名前は全 Task で一致
- `formatBytes` → `ByteSizeFormatter.format` に統一
