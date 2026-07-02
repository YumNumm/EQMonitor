# HTTPキャッシュ管理 & SharedPreferences デバッグ機能 設計

作成日: 2026-07-03

## 概要

3つの独立した機能を追加する。

1. **設定画面**: HTTPキャッシュの容量表示と削除ボタン
2. **デバッグページ**: HTTPキャッシュ無効化トグル
3. **デバッグページ**: SharedPreferences の Key-Value 一覧・編集ページ

対象は `app/`（Flutter）と `packages/cache`。HTTPキャッシュは Drift(SQLite) の DB `eqmonitor_http_cache.db` に保存されている。

---

## 機能① 設定画面: HTTPキャッシュ容量表示 + 削除

### 仕様
- 「容量」= **DBファイルの実サイズ**（`File.stat().size`）。人間可読形式（例 `1.2 MB`）で表示。
- 削除ボタン押下で `HttpCacheStore.clearAll()` → **`VACUUM`** を実行し、ファイルを物理的に縮小する。その後、容量表示を再取得。
- 配置は `settings_page.dart` の下部、"Powered by Flutter" テキストの手前に「キャッシュ」セクションを新設。

### 実装
- `packages/cache`:
  - `open_http_cache_database.dart`: DBファイルパスを `Future<File> httpCacheDatabaseFile()` に単一化し、オープン処理と容量計測で共用。
  - `CacheDatabase.vacuum()` = `customStatement('VACUUM')`。
  - `HttpCacheStore.vacuum()` = `db.vacuum()`。
- `app/lib/core/api/http_cache_size_provider.dart`（新規, 公開Provider 1つ）:
  - autoDispose FutureProvider。`httpCacheDatabaseFile()` を stat し、バイト数を返す。ファイル未存在時は 0。
- `settings_page.dart`:
  - 「キャッシュ」`SettingsSectionHeader`。
  - 容量表示 `ListTile`（サイズをバイト→可読形式に整形して subtitle 等に表示）。
  - 「HTTPキャッシュを削除」`ListTile`（削除アイコン）。押下で store 取得 → `clearAll()` → `vacuum()` → size provider を invalidate → 完了 SnackBar。

---

## 機能② デバッグページ: HTTPキャッシュ無効化トグル

### 仕様
- 「無効化」= **キャッシュの読み書きを完全にバイパス**（`HttpCacheInterceptor` を dio に追加しない。304条件付きリクエストも200保存も行わない）。
- 状態は SharedPreferences に保存。
- **即時反映**: `dio` は `keepAlive` だが、無効化フラグの Provider を `watch` することでフラグ変更時に dio が再構築される。

### 実装
- `SharedPreferencesKey.httpCacheDisabled('http_cache_disabled')`（bool）を enum に追加。
- `app/lib/core/api/http_cache_disabled_provider.dart`（新規, 公開Provider 1つ）:
  - `@Riverpod(keepAlive: true) class HttpCacheDisabled` notifier。`build()` で bool 読み込み（既定 false）、`save({required bool isDisabled})` で保存。
- `dio_provider.dart`:
  - `final httpCacheDisabled = ref.watch(httpCacheDisabledProvider);`
  - `if (!httpCacheDisabled) { final httpCache = await ref.watch(httpCacheStoreProvider.future); dio.interceptors.add(HttpCacheInterceptor(httpCache)); }`
- `debug_page.dart`:
  - `AppSwitch` 付き `ListTile`（title「HTTPキャッシュを無効化」、subtitle「キャッシュの読み書きをスキップします」）。onChanged で notifier.save。

---

## 機能③ デバッグページ: SharedPreferences 一覧・編集ページ

### 仕様
- 新規サブページ `DebugSharedPreferencesPage`。`debug_page.dart` に導線、`router.dart` に `DebugSharedPreferencesRoute`（path `shared-preferences`）を追加。
- **TabBar 2タブ**: 「SharedPreferences」/「App Group」。App Group タブは **iOS のみ**表示（App Group ストアは iOS 専用）。
- **並び順**（通常ストア）: `SharedPreferencesKey` の既知キーに **含まれない** キーを先頭（key 昇順）→ 既知キー（key 昇順）。App Group はキー昇順。
- **表示**: 各行にキー名・型・値プレビュー。
- **編集（型対応）**: `bool`→スイッチ、`int`/`double`→数値入力、`String`→複数行テキスト（JSON も文字列編集）、`List<String>`→要素ごとテキスト。
- **新規追加**: キー名・型・値を指定して作成。
- **削除**: 各行から削除。
- **確認ダイアログなし・即時反映**。

### データアクセス（既存API利用、新ラッパーは作らない）
- 通常ストア: `sharedPreferences`(`Future<SharedPreferences>`) の `getKeys()`/`get()`/`set*`/`remove()`。
- App Group: `appGroupPreferences`(`SharedPreferencesAsync`) の `getAll()`/`set*`/`remove()`。iOS 専用。

### 実装（新規ファイル、`.../debug/shared_preferences/`）
- `debug_shared_preferences_entries_provider.dart`（通常ストアのエントリ一覧, 公開Provider 1つ）。
- `debug_app_group_preferences_entries_provider.dart`（App Group のエントリ一覧, 公開Provider 1つ）。
- `debug_shared_preferences_page.dart`（`DebugSharedPreferencesPage`）。

### 既知の制約
- raw な SharedPreferences へ直接書き込むため、編集してもアプリ側の Riverpod 状態は自動更新されない（反映に再起動が必要な場合がある）。デバッグ専用機能として許容する。

---

## 影響範囲まとめ

| 種別 | ファイル |
|------|----------|
| 変更 | `packages/cache/lib/src/database/open_http_cache_database.dart`, `.../http_cache_database.dart`, `.../http/http_cache_store.dart` |
| 変更 | `app/lib/core/provider/dio_provider.dart` |
| 変更 | `app/lib/core/data/preferences/shared/shared_preferences_key.dart` |
| 変更 | `app/lib/feature/settings/settings_page.dart` |
| 変更 | `app/lib/feature/settings/children/config/debug/debug_page.dart` |
| 変更 | `app/lib/core/router/router.dart` |
| 新規 | `app/lib/core/api/http_cache_size_provider.dart` |
| 新規 | `app/lib/core/api/http_cache_disabled_provider.dart` |
| 新規 | `app/lib/feature/settings/children/config/debug/shared_preferences/*.dart`（3ファイル） |

コード生成（`melos run generate`）と `dart analyze` / `dart format` を最後に一括実行する。

## テスト方針
- `packages/cache` の既存テスト（`http_cache_store_test.dart` 等）が壊れないことを確認。`vacuum()` の単純な呼び出しテストを追加してもよい。
- UI（設定/デバッグ）は手動確認。デバッグ専用機能のためユニットテストは必須としない。
