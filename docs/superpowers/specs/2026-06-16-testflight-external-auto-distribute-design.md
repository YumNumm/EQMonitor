# TestFlight 外部グループ自動配布 設計

## 目的

`develop` への push（または `workflow_dispatch`）で iOS アプリを TestFlight にアップロードする際、コミットメッセージに `[external]` が含まれる場合に限り、ビルドを **外部テストグループ** へ自動配布する。あわせて TestFlight の「テスト内容（What to Test）」をコミット履歴から自動生成して設定する。

- 対象アプリ: App Store Connect App ID `6447546703`
- 対象外部グループ: betaGroup ID `bd75f066-fd92-4175-b2d6-f34952737557`
- 対象ワークフロー: `.github/workflows/deploy-app.yaml`

## 現状

- `build-ios` ジョブが `xcrun altool --upload-app` で IPA を App Store Connect にアップロードするのみ（`deploy-app.yaml` L259-266）。外部グループ配布・テスト内容設定は未実装。
- ビルド番号は `${{ github.run_number }}` を使用（L129）。
- ASC API 認証情報（`APP_STORE_CONNECT_API_KEY_ID` / `APP_STORE_CONNECT_API_ISSUER_ID` / `APP_STORE_CONNECT_API_KEY_BASE64`）は mise env 経由で取得済み。`.p8` 鍵は `$HOME/.private_keys/AuthKey_<id>.p8` に展開済み（L253-257）。
- changelog の git log 自動生成は Android 側（Firebase / Google Play）のみ存在。iOS にはない。
- `build-ios` は `fetch-depth: 0` で checkout 済み（L77）→ タグ・全履歴を取得可能。

## 方式

ジョブは新設せず、**`build-ios` ジョブ内に後続ステップ群を追加**する（案A）。altool アップロードは現状どおり残し、その後に外部配布処理を続ける。

### 1. トリガー判定（`[external]` ゲート）

`define-matrix` ジョブに output `deploy-ios-external` を追加する。

- **push 時**: `github.event.commits`（push に含まれる全コミット）の各 `message` を走査し、いずれかに `[external]` が含まれれば `true`。
- **workflow_dispatch 時**: 新規入力 `external`（boolean, default `false`）の値を使う。
- **セキュリティ**: コミットメッセージは `toJSON(github.event.commits)` を**環境変数経由**で run に渡し、`jq -r '.[].message' | grep -qF '[external]'` で判定する。run 内へ `${{ }}` を直接展開しない（スクリプトインジェクション回避 / zizmor 対応）。

`build-ios` の外部配布ステップ群は `if: needs.define-matrix.outputs.deploy-ios-external == 'true'` でガードする。`[external]` が無い通常 push では従来どおりアップロードのみで終了する。

### 2. ビルド処理完了待ち

- **ビルド特定**: ビルド番号 = `github.run_number`。`GET /v1/builds?filter[app]=6447546703&filter[version]=<run_number>&limit=1` で `data[0].id` と `attributes.processingState` を取得。
- **JWT 生成**: `.p8` 鍵から ES256 署名で JWT を生成。header `{alg:ES256, kid:<KEY_ID>, typ:JWT}`、payload `{iss:<ISSUER_ID>, iat, exp(<=20分), aud:"appstoreconnect-v1"}`。処理完了待ちが 20 分を超え得るため、**各 API リクエスト直前に都度生成**する。
- **言語/実行**: TypeScript（Node, mise の `node lts`）。`jose` ライブラリで ES256 署名（DER→JOSE 変換を自前実装しないため）。`tsx` で TS を直接実行。HTTP は Node 組み込み `fetch`。依存は pnpm で管理。
- **ポーリング**: `processingState` が `VALID` になるまで 30 秒間隔でポーリング（最大 ~30 分）。`INVALID` / `FAILED` は失敗終了、`PROCESSING` は待機継続。

### 3. テスト内容（What to Test）の自動生成と設定

- **生成**: `LAST_TAG=$(git describe --tags --abbrev=0)` として `git log "${LAST_TAG}..HEAD" --pretty=format:"- %s"`（コミット件名のみの箇条書き）。Apple の whatsNew 上限 4000 文字を超えないよう cap する。
- **設定**: locale `ja` の `betaBuildLocalizations` を upsert する。
  - `GET /v1/builds/{id}/betaBuildLocalizations` で既存 `ja` を確認 → あれば `PATCH /v1/betaBuildLocalizations/{locId}`、無ければ `POST /v1/betaBuildLocalizations`（relationship に build を紐付け）。

### 4. 外部グループ追加とベータ審査提出

1. What to Test 設定（上記 3）。
2. **外部グループへ追加**: `POST /v1/betaGroups/bd75f066-fd92-4175-b2d6-f34952737557/relationships/builds`（body: `{data:[{type:"builds", id:<buildId>}]}`）。
3. **ベータ審査提出**: `POST /v1/betaAppReviewSubmissions`（relationship に build）。既提出 / 承認済みによる 409 等は非致命として扱う。

注:
- ベータ審査の**承認は Apple 側で非同期**（数分〜数時間）。CI の責務は「審査提出まで」とし、承認待ちはしない。実際の外部テスター配信は承認後。
- エンドポイントの正確な順序（グループ追加と審査提出の前後）は実装時に現行 ASC API 仕様で最終検証する。

### 5. ランナー・タイムアウト・依存

- `build-ios` の `timeout-minutes` を **30 → 60** に引き上げる（処理完了待ちのため）。
- mise `install_args`（build-ios）に `node pnpm` を追加（mise.toml に `node lts`/`pnpm` 宣言済み）。
- 配布スクリプトは `scripts/testflight/`（standalone な pnpm プロジェクト）に置き、CI では `pnpm install --frozen-lockfile` → `tsx` 実行。
- ASC API 認証情報・`.p8` は既存ステップで取得済みのものを再利用。

## スコープ外

- ベータ審査の承認待ち / 承認結果のハンドリング。
- Android 側の TestFlight 相当処理（対象外）。
- 内部テストグループの扱い変更（現状維持）。

## 成功基準

- コミットメッセージに `[external]` を含む push で、TestFlight 上の該当ビルドが外部グループに追加され、What to Test がコミット件名一覧で埋まり、ベータ審査が提出された状態になる。
- `[external]` を含まない push では従来どおりアップロードのみで完了し、追加 API 呼び出しが発生しない。
