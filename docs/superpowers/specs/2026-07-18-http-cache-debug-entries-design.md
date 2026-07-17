# HTTPキャッシュ エントリ一覧デバッグ画面 設計

作成日: 2026-07-18

## 概要

Debug 配下に HTTP キャッシュのエントリ一覧画面を追加する。各エントリのサイズ（B / KB / MB）を表示し、個別削除と全削除を可能にする。

関連: `2026-07-03-http-cache-and-shared-preferences-debug-design.md`（容量表示・全削除・無効化トグルまでは実装済み。エントリ一覧は本設計で追加）。

対象: `packages/cache` と `app/`（Flutter）。

---

## 要件

- キャッシュエントリを一覧表示する
- 各エントリの body サイズを `formatBytes` 相当（B / KB / MB）で表示する
- 行タップでインライン展開し、詳細メタデータを表示する
- 個別削除 + 全削除（確認ダイアログ付き）を画面内で行う
- テストは不要

---

## 配置・ルーティング

### 導線

- `debug_page.dart` に「HTTPキャッシュ」ListTile を追加（無効化トグルの近く）
- ルート: `/settings/debug/http-cache`

### ディレクトリ

```
app/lib/feature/settings/children/config/debug/http_cache/
  debug_http_cache_page.dart
  debug_http_cache_entries_provider.dart
```

### ルーティング

- `router.dart` の `DebugRoute` 配下に `TypedGoRoute<DebugHttpCacheRoute>(path: 'http-cache')` を追加
- `DebugHttpCacheRoute` → `DebugHttpCachePage`

---

## packages/cache の拡張

### 一覧用モデル

body BLOB を含めないメタデータ専用型を追加する（例: `HttpCacheEntrySummary`）。

フィールド:

| フィールド | 内容 |
|---|---|
| `key` | キャッシュキー全文（`v{schema}:{build}:{url}`） |
| `statusCode` | HTTP ステータス |
| `eTag` | ETag（nullable） |
| `headers` | ヘッダ Map（Content-Type 抽出用） |
| `responseType` | Dio ResponseType 文字列 |
| `updatedAtMs` | 更新時刻（ms） |
| `bodySizeBytes` | body BLOB のバイト長 |

### API

- `CacheDatabase.listEntrySummaries()`: body 列を読まず `length(body)` 相当でサイズを取得し、全行を返す
- `HttpCacheStore.listSummaries()`: 上記を呼び、ヘッダ JSON を decode して `HttpCacheEntrySummary` のリストを返す
- 削除は既存の `evict` / `clearAll` / `vacuum` を再利用（新規削除 API は作らない）

並び順: `updatedAtMs` 降順（新しい順）。

---

## UI

### AppBar

- タイトル: 「HTTPキャッシュ」
- 再取得（一覧・総容量を invalidate）
- 全削除（確認ダイアログ → `clearAll` + `vacuum` → invalidate）

### ヘッダ

- 総容量: 既存 `httpCacheSizeProvider` + 既存 `formatBytes`（設定画面と同ロジック）
- 件数: エントリ数

### リスト

- `ListView.builder`
- 空なら Empty 表示
- 折りたたみ時:
  - 主: URL（キーから `v{schema}:{build}:` プレフィックスを除いた表示。パース不能ならキー全文）
  - 副: statusCode・サイズ（`formatBytes`）
- タップでインライン展開:
  - キャッシュキー全文
  - `updatedAt`（ローカル時刻）
  - `statusCode` / `responseType`
  - `eTag`（あれば）
  - `Content-Type`（headers から）
  - 個別削除ボタン（確認後 `evict` → 一覧・総容量を invalidate）

### サイズ表示

既存の `formatBytes`（`settings_page.dart`）を共通化して利用する。

- `< 1024` → `N B`
- `< 1 MiB` → `N.N KB`
- それ以上 → `N.N MB`

---

## データフロー（app）

- `debugHttpCacheEntriesProvider`: `HttpCacheStore.listSummaries()` を返す FutureProvider
- 削除・全削除後: `debugHttpCacheEntriesProvider` と `httpCacheSizeProvider` を invalidate
- Action クラス: 削除・全削除の確認ダイアログ + store 呼び出しを `DebugHttpCacheAction` に切り出し、Riverpod で DI（プロジェクト規約に従う）

---

## エラーハンドリング

- 一覧取得失敗: 画面中央にエラー表示 + 再試行
- 削除失敗: SnackBar で通知（一覧は維持）

---

## スコープ外

- テスト
- body 内容のプレビュー / 編集
- 設定画面のキャッシュ UI 変更（容量・全削除は現状のまま）
- 検索・フィルタ・ソート UI（必要になったら後続）

---

## 実装チェックリスト

1. `packages/cache`: `HttpCacheEntrySummary` + `listEntrySummaries` / `listSummaries`
2. `formatBytes` を共通ユーティリティへ移動（設定画面から参照維持）
3. `debug_http_cache_entries_provider.dart` / `debug_http_cache_page.dart` / Action
4. `router.dart` + `debug_page.dart` 導線
5. `melos run generate`（router / riverpod）
