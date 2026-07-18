# SecureStorage デバッグ画面 & Preferences キー監査 設計

作成日: 2026-07-18

## 概要

デバッグ画面に SecureStorage の Key-Value 一覧・追加・編集・削除機能を追加する。あわせて、SecureStorage / App Group デバッグにおける enum 外キー参照を是正する。

SharedPreferences デバッグ画面と同型の専用ページを新設する（タブ統合はしない）。

## 決定事項

| 項目 | 内容 |
|------|------|
| 操作範囲 | 一覧・追加・編集・削除（SharedPreferences と同程度） |
| 値表示 | デフォルトはマスク、行単位でタップ/アイコンにより平文トグル |
| キー収集 | `readAll()` で実在する全キー（未知キー含む） |
| 値型 | SecureStorage は常に String。型選択 UI は不要 |
| 確認ダイアログ | なし・即時反映 |
| テスト | 不要（手動確認） |
| workflow 動的キー (`_wf:`) | スコープ外 |

## 機能① SecureStorage デバッグページ

### 仕様

- デバッグメニューに「SecureStorage」行を追加（SharedPreferences の近く）
- 新規 `DebugSecureStoragePage`
- ルート: `/settings/debug/secure-storage`（`DebugSecureStorageRoute`）
- **並び順**: `SecureStorageKey` に含まれないキーを先頭（key 昇順）→ 既知キー（key 昇順）
- **表示**: キー名 + マスクされた値プレビュー（文字数付き可）。monospace フォント
- **マスク解除**: 行タップまたは目アイコンでその行だけ平文トグル
- **編集**: ダイアログ内は平文の複数行テキスト。保存で `write`
- **新規追加**: キー名 + 文字列値。FAB から追加
- **削除**: 各行の削除ボタン。`delete`

### データアクセス

- 一覧: `FlutterSecureStorage.readAll()`（デバッグ例外）
- 書き込み/削除: raw `write` / `delete`（デバッグ例外）
- 本番コードは引き続き `SecurePreferencesDataSource` + `SecureStorageKey` のみ

### 実装（新規）

- `app/lib/feature/settings/children/config/debug/secure_storage/debug_secure_storage_page.dart`
- `app/lib/feature/settings/children/config/debug/secure_storage/debug_secure_storage_entries_provider.dart`

### 変更

- `debug_page.dart` … 導線追加
- `router.dart` … `DebugSecureStorageRoute` 追加

### 既知の制約

- raw 操作のため、編集してもアプリ側の Riverpod 状態は自動更新されない場合がある（再起動が必要な場合あり）。デバッグ専用として許容する。

## 機能② SecureStorage キー監査修正（本番）

### 現状の違反

| ファイル | 内容 |
|----------|------|
| `hinet_credentials_provider.dart` | `hinet_bosai_user_id` / `hinet_bosai_password` を const 直書き + `FlutterSecureStorage` 直接操作 |
| `knet_credentials_provider.dart` | `knet_bosai_user_id` / `knet_bosai_password` も同様 |

### 修正

- `SecureStorageKey` に以下を追加:
  - `hinetBosaiUserId('hinet_bosai_user_id')`
  - `hinetBosaiPassword('hinet_bosai_password')`
  - `knetBosaiUserId('knet_bosai_user_id')`
  - `knetBosaiPassword('knet_bosai_password')`
- Hi-net / Knet Notifier は `securePreferencesDataSourceProvider` 経由の `getString` / `setString` / `remove` に変更
- キー文字列の変更はしない（既存保存データとの互換を維持）

## 機能③ App Group デバッグのキー統一

### 現状の違反

| ファイル | 内容 |
|----------|------|
| `debug_app_group_action.dart` | `'apiServerUrl'` / `'debugMode'` を文字列直書き |
| `app_group_values_provider.dart` | 同上 |

### 修正

- いずれも `AppGroupKeys.apiServerUrl` / `AppGroupKeys.debugMode` を参照する

## スコープ外

- `shared_preferences_workflow_persistence.dart` の動的キー（`_wf:<instanceId>:...`）
- SharedPreferences デバッグ画面の raw キー操作（既存の明示例外）
- ユニットテスト / Widget テストの追加

## 例外の明文化

- **デバッグ画面**の raw SecureStorage / SharedPreferences / App Group 操作は例外（一覧・任意キー CRUD のため）
- **本番コード**では `SecureStorageKey` / `SharedPreferencesKey` / `AppGroupKeys` 外のキー文字列による読み書きを禁止
- アクセスは原則 DataSource（Secure / Shared）経由。デバッグ画面と DataSource 本体、初期化処理は例外

## 影響範囲まとめ

| 種別 | ファイル |
|------|----------|
| 新規 | `.../debug/secure_storage/debug_secure_storage_page.dart` |
| 新規 | `.../debug/secure_storage/debug_secure_storage_entries_provider.dart` |
| 変更 | `secure_storage_key.dart` |
| 変更 | `hinet_credentials_provider.dart` |
| 変更 | `knet_credentials_provider.dart` |
| 変更 | `debug_page.dart` |
| 変更 | `router.dart` |
| 変更 | `debug_app_group_action.dart` |
| 変更 | `app_group_values_provider.dart` |

コード生成（`build_runner`）と `dart analyze` / `dart format` を最後に実行する。

## 手動確認

- デバッグメニュー → SecureStorage で一覧表示・マスク/平文トグル・追加・編集・削除
- Hi-net / Knet 認証の保存・読み込み・クリアが従来どおり動作すること
- App Group デバッグ画面で API URL / debugMode の読み書きが動作すること
