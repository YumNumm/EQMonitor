# Deploy 配布ノート生成と IS_BETA_TESTING 制御

日付: 2026-08-14
参照: KEVi `deploy-app.yaml` / `scripts/build-testflight-changelog.sh`

## 背景

EQMonitor の `deploy-app.yaml` は現状:

- iOS / Android ビルドで常に `IS_BETA_TESTING=true` を渡している
- TestFlight 外部配布のみ簡易なタグ差分ノート（`testflight_test_notes.sh`）を使う
- Firebase / Google Play は直近タグ以降の git log を別々に組み立てている

KEVi と同様に「前回配信からの差分」を明記し、develop 連打と beta タグ配布で Beta フラグを分けたい。

## 要件

1. **配布ノート**: プラットフォーム別に生成する
   - iOS: TestFlight・Firebase App Distribution (iOS) で同一本文
   - Android: Google Play・Firebase App Distribution (Android) で同一本文
2. **起点**: 各プラットフォームの前回配信ノートに埋め込んだ `rev: <40桁 SHA>`（タグフォールバックなし）
3. **専用 Job**:
   - `generate-release-note-ios`
   - `generate-release-note-android`
4. **`IS_BETA_TESTING`**:
   - `push` develop → 立てない（false / 未指定）
   - `v*-beta.*` タグ（Release Please PR の `/beta` 経由）→ `true`
   - `workflow_dispatch` → 入力 `is_beta_testing`（既定 `false`）

## 非要件

- release-please / create-beta-release 本体のタグ作成ロジック変更はしない
- iOS と Android で本文を強制的に一致させない（前回配信 SHA が異なれば差分も異なる）

## アーキテクチャ

```text
define-matrix ──► build-ios / build-android
              ├─► generate-release-note-ios ──► release-notes-ios.txt
              └─► generate-release-note-android ──► release-notes-android.txt

generate-release-note-ios ──► deploy-ios / Firebase iOS
generate-release-note-android ──► Google Play / Firebase Android
```

### Job: `generate-release-note-ios`

- `define-matrix` の後、iOS deploy 系の前（ビルドと並列可）
- `deploy-ios == true` のときのみ実行
- checkout `fetch-depth: 0`
- mise で `asc` を入れる
- `scripts/ci/generate_release_note.sh` を `PLATFORM=ios` で実行
- artifact: `EQMonitor-release-notes-ios` / `release-notes-ios.txt`

### Job: `generate-release-note-android`

- `define-matrix` の後、Android deploy 系の前（ビルドと並列可）
- `deploy-android == true` のときのみ実行
- checkout `fetch-depth: 0`
- Google Play API（既存の `google-play-cli` + WIF）で対象トラックの前回リリースノートから `rev` を読む
- 同じ `scripts/ci/generate_release_note.sh` を `PLATFORM=android` で実行
- artifact: `EQMonitor-release-notes-android` / `release-notes-android.txt`

### Script: `scripts/ci/generate_release_note.sh`

KEVi の `build-testflight-changelog.sh` を移植し、プラットフォーム差は起点の取得だけに閉じる。

共通:

- `git log --first-parent BASE..HEAD` から PR（merge / squash）を列挙
- 本文末尾に `rev: <HEAD SHA>` を必ず付与
- `rev` が見つからない場合は差分一覧を省略し、その旨と今回の `rev` のみ書く
- `BASE_SHA` 環境変数で ASC / Play 問い合わせをスキップ可能（テスト用）

起点:

| PLATFORM | 起点の読み方 |
| --- | --- |
| ios | ASC TestFlight の直近ビルド test-notes（LOOKBACK 既定 5） |
| android | 今回配布する Google Play トラックの前回 release notes |

文字数上限（生成時）:

| PLATFORM | 上限 |
| --- | --- |
| ios | 4000（ASC whatsNew） |
| android | 生成は 4000。Google Play 利用時は約 500、Firebase 利用時は約 2000 で切り詰め |

### 利用側

| チャネル | ノート |
| --- | --- |
| TestFlight 外部 | iOS artifact を `--test-notes` に渡す |
| TestFlight 内部（develop） | `builds upload` 後、同じ iOS ノートを ASC に書き込み `rev` 連鎖を維持する |
| Firebase App Distribution (iOS) | iOS artifact（必要なら 2000 文字で切り詰め） |
| Firebase App Distribution (Android) | Android artifact（必要なら 2000 文字で切り詰め） |
| Google Play | Android artifact（約 500 文字で切り詰め。末尾の `rev:` は残す） |

内部 / 通常トラックでも `rev` を書かないと次回の起点が切れるため、ノート書き込みは必須。
Android は Google Play へ上げるノートに `rev:` を含める（切り詰め時も `rev:` 行を優先して残す）。

### `IS_BETA_TESTING`

`resolve_deploy_app_policy.sh` に出力を追加:

| 条件 | `is-beta-testing` |
| --- | --- |
| push develop | `false` |
| push tag `v*-beta.*` | `true` |
| workflow_dispatch | 入力 `is_beta_testing`（既定 false） |

`build-ios` / `build-android` は:

- `true` のときのみ `--dart-define IS_BETA_TESTING="true"` を付与
- `false` のときは当該 dart-define を渡さない（`bool.fromEnvironment` 既定 false）

`workflow_dispatch` に boolean 入力 `is_beta_testing`（default: false）を追加する。

## テスト

- `resolve_deploy_app_policy.sh` の既存テストに `is-beta-testing` 期待値を追加
- `generate_release_note.sh` は `BASE_SHA` 指定時の本文生成を検証（ASC / Play 無しでも動く経路）
- 既存のタグベース `testflight_test_notes.sh` は置き換え後に削除、または薄いラッパーに一本化

## リスクと注意

- 初回（`rev` 未埋め込み）は差分省略文になる。2 回目以降から差分が出る
- iOS Job には ASC 認証、Android Job には Google Play 認証が必要
- Google Play の 500 文字制限では PR 一覧が短くなるため、切り詰め時は `rev:` を必ず残す
- iOS と Android の前回配信タイミングがずれると、ノート本文もずれる（意図どおり）
