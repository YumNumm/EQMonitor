# CD の App Store Connect 通信を asc CLI へ移行する実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** CD の App Store Connect 通信（IPA アップロード / TestFlight 外部配布 / Background Assets アップロード）を自前実装から asc CLI に置き換える。

**Architecture:** TestFlight 配布は `asc publish testflight` を deploy-app.yaml から直接呼ぶ。Background Assets の多段フローは `.asc/workflow.json` に定義し `asc workflow run` で実行する。asc は mise の github バックエンド（`rename_exe = "asc"`）で導入する。

**Tech Stack:** asc CLI 3.5.x (rorkai/App-Store-Connect-CLI)、mise github バックエンド、GitHub Actions、bash + jq

**Spec:** `docs/superpowers/specs/2026-08-04-asc-cli-cd-migration-design.md`（未コミット。Task 1 でコミットする）

## Global Constraints

- PR は `--repo YumNumm/EQMonitor`、ベースブランチ `develop`（CLAUDE.md 厳守）
- pre-commit（hk）で gitleaks / zizmor / pinact / shellcheck が走る。シェルは shellcheck を通すこと
- 新規 worktree では最初のコミット前に `mise trust` を実行する（未 trust だと hk の postinstall が失敗する）
- GitHub Actions の変更は `mise exec -- actionlint` と `mise exec -- zizmor .github/workflows/<file>` を通すこと
- 認証情報は SOPS 暗号化済み `.env.json` から `mise env` で環境変数として供給される（`APP_STORE_CONNECT_API_KEY_ID` / `APP_STORE_CONNECT_API_ISSUER_ID` / `APP_STORE_CONNECT_API_KEY_BASE64`）。GitHub Actions secrets には存在しない
- App ID は `6447546703`、外部ベータグループ ID は `bd75f066-fd92-4175-b2d6-f34952737557`、Background Assets パック ID は `eqmonitor-assets`
- 生成コードのコメントは「なぜ」のみ（自明なコメント禁止）

---

### Task 1: mise.toml の asc エントリ修正とローカル検証

mise.toml には `"github:rorkai/App-Store-Connect-CLI" = "latest"` が既に追加済み（未コミット）だが、リリースアセットのバイナリ名が `asc_<version>_macOS_arm64` 形式のため、`rename_exe` なしでは `asc` コマンドとして解決されない（検証済みの事実）。

**Files:**
- Modify: `mise.toml:33`
- Commit: `docs/superpowers/specs/2026-08-04-asc-cli-cd-migration-design.md`（brainstorming の成果物）

**Interfaces:**
- Produces: 以降の全タスクが前提とする `asc` コマンド（mise 経由、リポジトリ内で `mise exec -- asc` または PATH 解決で実行可能）

- [ ] **Step 1: mise.toml を修正**

`mise.toml` の以下の行を:

```toml
"github:rorkai/App-Store-Connect-CLI" = "latest"
```

次に変更する:

```toml
# リリースアセットが asc_<version>_<os>_<arch> という素のバイナリ名のため rename が必要
"github:rorkai/App-Store-Connect-CLI" = { version = "latest", rename_exe = "asc" }
```

- [ ] **Step 2: 再インストールして検証**

rename_exe 追加前にインストール済みだと同バージョン扱いで再展開されないため、明示的に入れ直す:

```bash
mise uninstall "github:rorkai/App-Store-Connect-CLI" || true
GITHUB_TOKEN=$(gh auth token) mise install "github:rorkai/App-Store-Connect-CLI"
mise exec -- asc --version
```

Expected: `3.5.0 (commit: ...)` 形式のバージョン出力。

- [ ] **Step 3: mise.lock を確認**

```bash
git diff mise.lock | head -50
grep -A3 'App-Store-Connect-CLI"\."platforms\.macos-arm64' mise.lock
```

Expected: `platforms.macos-arm64` に url / checksum が記録されている（CI ランナーは macos-arm64。platform URL 欠落は過去に deploy-app を落とした実績があるため必ず確認する）。

- [ ] **Step 4: コミット**

```bash
mise trust  # worktree 初回のみ
git add mise.toml mise.lock docs/superpowers/specs/2026-08-04-asc-cli-cd-migration-design.md
git commit -m "chore: asc CLI を mise の github バックエンドで導入"
```

注意: worktree 内の mise.toml / mise.lock に他の未コミット変更（開発中の別件）が混ざっていないか `git diff --staged` で確認し、asc 関連の hunk のみコミットする。

---

### Task 2: What to Test 生成スクリプトの作成

`scripts/testflight/distribute-external.ts` の `buildWhatsNewFromGit` / `capText` を数行のシェルに移植する。挙動は同一: 直近タグ以降のコミット件名を `- <subject>` 形式で列挙、空なら `- (no changes)`、4000 文字（Unicode 文字数。バイトではない）超過時は末尾を `...` に置換。

**Files:**
- Create: `scripts/ci/testflight_test_notes.sh`

**Interfaces:**
- Produces: `scripts/ci/testflight_test_notes.sh` — 引数なし、stdout に What to Test 本文を出力（末尾改行なし）。Task 3 の deploy-app.yaml が呼ぶ。

- [ ] **Step 1: スクリプトを作成**

`scripts/ci/testflight_test_notes.sh`:

```bash
#!/usr/bin/env bash
# TestFlight の What to Test を直近タグ以降のコミット件名から生成する。
# 旧 scripts/testflight/distribute-external.ts の buildWhatsNewFromGit と同挙動:
# 空なら "- (no changes)"、4000 文字(Unicode 文字数)超過時は末尾を "..." にする。
set -euo pipefail

last_tag=$(git describe --tags --abbrev=0)
log=$(git log "${last_tag}..HEAD" --pretty=format:'- %s')
if [ -z "$log" ]; then
  log='- (no changes)'
fi

# ASC の whatsNew 上限は 4000 文字。コミット件名は日本語を含むため
# バイト数で切る head -c は使えない。
printf '%s' "$log" | python3 -c '
import sys

text = sys.stdin.read()
MAX_LEN = 4000
if len(text) > MAX_LEN:
    text = text[: MAX_LEN - 3] + "..."
print(text, end="")
'
```

```bash
chmod +x scripts/ci/testflight_test_notes.sh
```

- [ ] **Step 2: 動作確認**

```bash
scripts/ci/testflight_test_notes.sh | head -5
scripts/ci/testflight_test_notes.sh | wc -m   # 4000 以下であること
shellcheck scripts/ci/testflight_test_notes.sh
```

Expected: `- <コミット件名>` の列挙が出力され、shellcheck がエラーなし。

- [ ] **Step 3: 上限丸めの確認**

一時 git リポジトリで境界ケースを検証する:

```bash
tmp=$(mktemp -d) && cd "$tmp" && git init -q && git commit -q --allow-empty -m init && git tag v0
for i in $(seq 1 200); do git commit -q --allow-empty -m "とても長い日本語のコミットメッセージのサンプルです $i"; done
/Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/scripts/ci/testflight_test_notes.sh > /tmp/notes.txt || \
  <worktree の絶対パス>/scripts/ci/testflight_test_notes.sh > /tmp/notes.txt
wc -m /tmp/notes.txt   # ちょうど 4000
tail -c 16 /tmp/notes.txt  # 末尾が "..." で終わる
cd - && rm -rf "$tmp"
```

Expected: 文字数 4000、末尾 `...`。タグ直後（コミットなし）の場合に `- (no changes)` が出ることも `git tag vX && 実行` で確認する。

- [ ] **Step 4: コミット**

```bash
git add scripts/ci/testflight_test_notes.sh
git commit -m "feat: TestFlight What to Test 生成スクリプトを追加"
```

---

### Task 3: deploy-app.yaml の deploy-ios を asc publish testflight に置換

altool アップロードと TS 製外部配布スクリプトの 2 ステップを、`asc publish testflight` 1 ステップに統合する。外部配布時のみグループ追加・レビュー申請フラグを足す。

**Files:**
- Modify: `.github/workflows/deploy-app.yaml:292-383`（deploy-ios ジョブ）
- Delete: `scripts/testflight/` ディレクトリ一式

**Interfaces:**
- Consumes: `scripts/ci/testflight_test_notes.sh`（Task 2）、mise の asc ツール（Task 1）、既存の `needs.define-matrix.outputs.deploy-ios-external`（'true' / 'false' 文字列）

- [ ] **Step 1: deploy-ios ジョブのステップを置換**

以下のステップを **削除** する:

- `- uses: maxim-lobanov/setup-xcode@...`（deploy-ios 内のもの。build-ios のものは残す）
- `- name: Show Xcode version`
- `- name: Extract App Store Connect API Key`
- `- name: Upload Ipa to App Store Connect`（altool）
- `- name: Distribute to TestFlight external group`（pnpm / unzip / PlistBuddy のブロック全体）

`Install Mise dependencies` ステップを次に変更する（node / pnpm / xcbeautify は altool・TS スクリプト用だったので除去。mise の github バックエンドが GitHub API を叩くため token を渡す）:

```yaml
      # https://github.com/jdx/mise-action
      - name: Install Mise dependencies
        uses: jdx/mise-action@9e7f7633ff6f6d6048a9418a68d48f288f50eb14 # v4.2.3
        env:
          GITHUB_TOKEN: ${{ github.token }}
        with:
          cache: false
          install_args: '"github:rorkai/App-Store-Connect-CLI"'
```

`Set environment variables` ステップの後に、削除した 2 ステップの代わりとして追加する:

```yaml
      - name: Publish to TestFlight
        env:
          ASC_APP_ID: "6447546703"
          ASC_BETA_GROUP_ID: bd75f066-fd92-4175-b2d6-f34952737557
          ASC_BYPASS_KEYCHAIN: "1"
          DEPLOY_IOS_EXTERNAL: ${{ needs.define-matrix.outputs.deploy-ios-external }}
        run: |
          export ASC_KEY_ID="$APP_STORE_CONNECT_API_KEY_ID"
          export ASC_ISSUER_ID="$APP_STORE_CONNECT_API_ISSUER_ID"
          export ASC_PRIVATE_KEY_B64="$APP_STORE_CONNECT_API_KEY_BASE64"
          # ビルド番号は asc が IPA の Info.plist から自動抽出するため、
          # 旧実装のような unzip / PlistBuddy での照会は不要。
          args=(--app "$ASC_APP_ID" --ipa build/EQMonitor.ipa --output json)
          if [ "$DEPLOY_IOS_EXTERNAL" = "true" ]; then
            TEST_NOTES="$(scripts/ci/testflight_test_notes.sh)"
            args+=(
              --group "$ASC_BETA_GROUP_ID"
              --test-notes "$TEST_NOTES"
              --locale ja
              --wait
              --submit --confirm
              --timeout 30m
            )
          fi
          asc publish testflight "${args[@]}"
```

補足:

- 通常時（develop push）はアップロードのみで終わる（旧 altool と同等。内部グループは自動配布）。
- `--timeout 30m` は旧 TS 実装のポーリング上限 30 分の踏襲。
- checkout の `fetch-depth: 0` は `git describe` に必要なので残す。
- `Extract SOPS Age Key File` / `Copy mise.local.toml` / `Set environment variables` / `Download ipa` は変更しない。

- [ ] **Step 2: scripts/testflight を削除**

```bash
git rm -r scripts/testflight
```

- [ ] **Step 3: 残参照がないことを確認**

```bash
grep -rn "scripts/testflight" --exclude-dir=node_modules --exclude-dir=docs .
grep -rn "altool" .github/workflows/
```

Expected: `.github/` や設定ファイルにヒットなし（docs/ 配下の過去の plan / spec は履歴なので残してよい）。`altool` は docs のフォールバック記述以外に残らない。

- [ ] **Step 4: lint**

```bash
mise exec -- actionlint
mise exec -- zizmor .github/workflows/deploy-app.yaml
```

Expected: エラーなし（zizmor の既存警告レベルは現状を悪化させないこと）。

- [ ] **Step 5: コミット**

```bash
git add .github/workflows/deploy-app.yaml
git commit -m "ci: iOS の ASC アップロードと TestFlight 外部配布を asc publish testflight に置換"
```

---

### Task 4: Background Assets 用ヘルパースクリプトと .asc/workflow.json

Python 製 REST クライアントの ensure-exists / upload / poll を、asc コマンド + 小さなシェルヘルパー + `asc workflow` 定義に移植する。

**Files:**
- Create: `scripts/ci/asset_pack_ensure.sh`
- Create: `scripts/ci/asset_pack_wait_version.sh`
- Create: `.asc/workflow.json`

**Interfaces:**
- Consumes: `asc background-assets list/create/versions create/upload-files create/versions view`（asc 3.5.0 で存在確認済み）
- Produces:
  - `scripts/ci/asset_pack_ensure.sh <app_id> <asset_pack_id>` — stdout に `{"assetId":"<id>"}` を出力（asc workflow の outputs 用。ログは stderr）
  - `scripts/ci/asset_pack_wait_version.sh <version_id>` — 成功 state で exit 0、失敗 state / タイムアウトで exit 1
  - asc workflow `asset_pack_ensure` / `asset_pack_upload`（引数: `APP_ID:` `ASSET_PACK_ID:` `ARCHIVE_PATH:`）。Task 5 の upload-asset-pack.yaml が呼ぶ。

- [ ] **Step 1: ensure スクリプトを作成**

`scripts/ci/asset_pack_ensure.sh`:

```bash
#!/usr/bin/env bash
# App Store Connect に Managed Background Assets のレコードが存在することを
# 保証し、asc workflow の outputs 用に {"assetId":"..."} を stdout へ出力する。
# 旧 tool/asset_pack/upload_ios_background_assets.py の ensure-exists 相当。
set -euo pipefail

app_id="$1"
asset_pack_id="$2"

id=$(asc background-assets list --app "$app_id" --paginate --output json \
  | jq -r --arg pack "$asset_pack_id" \
      '[.data[]? | select(.attributes.assetPackIdentifier == $pack)][0].id // empty')
if [ -z "$id" ]; then
  id=$(asc background-assets create --app "$app_id" \
        --asset-pack-identifier "$asset_pack_id" --output json \
    | jq -r '.data.id')
  echo "created background asset ${id}" >&2
else
  echo "found background asset ${id}" >&2
fi
printf '{"assetId":"%s"}' "$id"
```

- [ ] **Step 2: poll スクリプトを作成**

`scripts/ci/asset_pack_wait_version.sh`:

```bash
#!/usr/bin/env bash
# backgroundAssetVersion が既知の終端 state に到達するまでポーリングする。
# state 集合と「不明な state のままの期限切れは失敗扱い」という方針は
# 旧 tool/asset_pack/asc_client.py の poll_background_asset_version_state を踏襲
# (終端 state 名は Apple のドキュメントで未確認のため、寛容に成功扱いしない)。
set -euo pipefail

version_id="$1"
deadline=$(( $(date +%s) + 20 * 60 ))

while :; do
  state=$(asc background-assets versions view --version-id "$version_id" --output json \
    | jq -r '.data.attributes.state // .data.attributes.assetPackState // "UNKNOWN"')
  echo "backgroundAssetVersion ${version_id} state=${state}" >&2
  case "$state" in
    COMPLETE|READY_FOR_TESTING|PROCESSING_COMPLETE)
      exit 0 ;;
    FAILED_PROCESSING|REJECTED|INVALID)
      echo "::error::backgroundAssetVersion ${version_id} failed: state=${state}" >&2
      exit 1 ;;
  esac
  if [ "$(date +%s)" -ge "$deadline" ]; then
    echo "::error::timed out waiting for backgroundAssetVersion ${version_id} (last state=${state})" >&2
    exit 1
  fi
  sleep 30
done
```

```bash
chmod +x scripts/ci/asset_pack_ensure.sh scripts/ci/asset_pack_wait_version.sh
shellcheck scripts/ci/asset_pack_ensure.sh scripts/ci/asset_pack_wait_version.sh
```

- [ ] **Step 3: .asc/workflow.json を作成**

`.asc/workflow.json`:

```json
{
  "env": {
    "ASC_BYPASS_KEYCHAIN": "1",
    "APP_ID": "",
    "ASSET_PACK_ID": "",
    "ARCHIVE_PATH": ""
  },
  "workflows": {
    "asset_pack_ensure": {
      "description": "Ensure the Managed Background Assets pack record exists in App Store Connect.",
      "steps": [
        {
          "name": "ensure_asset",
          "run": "scripts/ci/asset_pack_ensure.sh \"$APP_ID\" \"$ASSET_PACK_ID\"",
          "outputs": {
            "ASSET_ID": "$.assetId"
          }
        }
      ]
    },
    "asset_pack_upload": {
      "description": "Create a background asset version, upload the archive, and wait for processing.",
      "steps": [
        {
          "name": "resolve_asset",
          "run": "scripts/ci/asset_pack_ensure.sh \"$APP_ID\" \"$ASSET_PACK_ID\"",
          "outputs": {
            "ASSET_ID": "$.assetId"
          }
        },
        {
          "name": "create_version",
          "run": "asc background-assets versions create --background-asset-id ${steps.resolve_asset.ASSET_ID} --output json",
          "outputs": {
            "VERSION_ID": "$.data.id"
          }
        },
        {
          "name": "upload_archive",
          "run": "asc background-assets upload-files create --version-id ${steps.create_version.VERSION_ID} --file \"$ARCHIVE_PATH\" --asset-type ASSET --checksum --output json"
        },
        {
          "name": "wait_processing",
          "run": "scripts/ci/asset_pack_wait_version.sh ${steps.create_version.VERSION_ID}"
        }
      ]
    }
  }
}
```

- [ ] **Step 4: バリデーションと読み取り系の実 API 検証**

```bash
asc workflow validate
asc workflow run --dry-run asset_pack_ensure APP_ID:6447546703 ASSET_PACK_ID:eqmonitor-assets
```

Expected: validate / dry-run ともエラーなし。

続いて **読み取り専用** の実 API でレスポンス形状を確認する（ローカルの keychain 認証を使用。書き込みはしない）:

```bash
asc background-assets list --app 6447546703 --output json | jq '{ids: [.data[].id], packs: [.data[].attributes.assetPackIdentifier]}'
scripts/ci/asset_pack_ensure.sh 6447546703 eqmonitor-assets
```

Expected: `eqmonitor-assets` の既存レコードが見つかり、ensure スクリプトが `{"assetId":"..."}` を出力する（既存なので create 分岐には入らない）。

`versions create` のレスポンスが `$.data.id` で引けるかは書き込みを伴うためここでは実行しない。`asc schema --method POST backgroundAssetVersions` でレスポンス型が標準の single-resource 形式（`data.id`）であることを確認する。ズレがあれば workflow.json の JSONPath を修正する。

- [ ] **Step 5: コミット**

```bash
git add scripts/ci/asset_pack_ensure.sh scripts/ci/asset_pack_wait_version.sh .asc/workflow.json
git commit -m "feat: Background Assets アップロード用の asc workflow を追加"
```

---

### Task 5: upload-asset-pack.yaml の置換と Python クライアント削除

**Files:**
- Modify: `.github/workflows/upload-asset-pack.yaml`（iOS アップロードジョブ: mise-action、`Extract App Store Connect API Key`、`Ensure ... exists`、`Upload to App Store Connect ...`、`Remove ... private key` の各ステップ）
- Delete: `tool/asset_pack/upload_ios_background_assets.py`
- Delete: `tool/asset_pack/asc_client.py`
- Delete: `tool/asset_pack/test_asc_client.py`
- Modify: `docs/asset-pack-cd.md`、`docs/knowledge/20260728_ba_package_cli.md`（削除ファイルへの言及を更新）

**Interfaces:**
- Consumes: Task 4 の asc workflow `asset_pack_ensure` / `asset_pack_upload`、Task 1 の mise asc ツール

- [ ] **Step 1: mise-action を asc インストールに変更**

現在 `install: false`（`mise env` のみ利用）のステップを次に変更する:

```yaml
      # https://github.com/jdx/mise-action
      - name: Install Mise
        uses: jdx/mise-action@9e7f7633ff6f6d6048a9418a68d48f288f50eb14 # v4.2.3
        env:
          GITHUB_TOKEN: ${{ github.token }}
        with:
          cache: false
          # `mise env` での .env.json 復号に加え、ASC 通信用の asc CLI を入れる。
          # flutter 等のフルツールチェーンは不要。
          install_args: '"github:rorkai/App-Store-Connect-CLI"'
```

- [ ] **Step 2: .p8 書き出しステップを資格情報チェックに置換**

`Extract App Store Connect API Key` ステップを次に変更する（fail-fast のチェックは残し、鍵ファイルの書き出しをやめる）:

```yaml
      - name: Verify App Store Connect credentials
        run: |
          set -euo pipefail
          if [ -z "${APP_STORE_CONNECT_API_KEY_BASE64:-}" ] || [ -z "${APP_STORE_CONNECT_API_KEY_ID:-}" ]; then
            echo "::error::APP_STORE_CONNECT_API_KEY_BASE64 / APP_STORE_CONNECT_API_KEY_ID missing after mise env decrypt. Check .env.json + secrets.AGE_KEY."
            exit 1
          fi
```

末尾の `Remove App Store Connect API private key` ステップは削除する（.p8 を書かなくなるため）。

- [ ] **Step 3: ensure / upload ステップを asc workflow 呼び出しに置換**

`Ensure App Store Connect asset pack exists` ステップを:

```yaml
      - name: Ensure App Store Connect asset pack exists
        env:
          ASC_BYPASS_KEYCHAIN: "1"
        run: |
          set -euo pipefail
          export ASC_KEY_ID="$APP_STORE_CONNECT_API_KEY_ID"
          export ASC_ISSUER_ID="$APP_STORE_CONNECT_API_ISSUER_ID"
          export ASC_PRIVATE_KEY_B64="$APP_STORE_CONNECT_API_KEY_BASE64"
          asc workflow validate
          asc workflow run asset_pack_ensure \
            APP_ID:"$ASC_APP_ID" \
            ASSET_PACK_ID:"$IOS_BACKGROUND_ASSET_PACK_ID"
```

`Upload to App Store Connect (Managed Background Assets)` ステップを:

```yaml
      - name: Upload to App Store Connect (Managed Background Assets)
        env:
          ASC_BYPASS_KEYCHAIN: "1"
        run: |
          set -euo pipefail
          export ASC_KEY_ID="$APP_STORE_CONNECT_API_KEY_ID"
          export ASC_ISSUER_ID="$APP_STORE_CONNECT_API_ISSUER_ID"
          export ASC_PRIVATE_KEY_B64="$APP_STORE_CONNECT_API_KEY_BASE64"
          asc workflow run asset_pack_upload \
            APP_ID:"$ASC_APP_ID" \
            ASSET_PACK_ID:"$IOS_BACKGROUND_ASSET_PACK_ID" \
            ARCHIVE_PATH:"$archive_path"
```

（`$archive_path` は既存の `Package archive with ba-package` ステップが `GITHUB_ENV` 経由で設定済み。）

- [ ] **Step 4: Python クライアントを削除**

```bash
git rm tool/asset_pack/upload_ios_background_assets.py tool/asset_pack/asc_client.py tool/asset_pack/test_asc_client.py
```

`check_asset_pack_id.py` / `verify_zip.sh` / `stage_from_release.sh` / `extract_ios_native_jma_code_table.py` とそのテストは ASC 通信ではないため**残す**。

- [ ] **Step 5: 残参照の確認とドキュメント更新**

```bash
grep -rn "upload_ios_background_assets\|asc_client" --exclude-dir=node_modules --exclude-dir=.git . | grep -v docs/superpowers
```

ヒットした `docs/asset-pack-cd.md` と `docs/knowledge/20260728_ba_package_cli.md` の該当箇所を更新する: Python スクリプトへの言及を `.asc/workflow.json`（`asset_pack_ensure` / `asset_pack_upload`）と `scripts/ci/asset_pack_wait_version.sh` への言及に置き換える。手動フォールバック（Transporter / `altool --upload-asset-pack`）の記述は有効なので残す。ポーリングの state 集合の出典が `asc_client.py` になっている箇所は `asset_pack_wait_version.sh` に差し替える。

- [ ] **Step 6: lint**

```bash
mise exec -- actionlint
mise exec -- zizmor .github/workflows/upload-asset-pack.yaml
```

Expected: エラーなし。

- [ ] **Step 7: コミット**

```bash
git add .github/workflows/upload-asset-pack.yaml docs/asset-pack-cd.md docs/knowledge/20260728_ba_package_cli.md
git commit -m "ci: Background Assets アップロードを asc workflow に置換"
```

---

### Task 6: 最終検証と PR 作成

**Files:**
- Create: PR（`--repo YumNumm/EQMonitor` / base `develop`）

- [ ] **Step 1: 全体の残参照スキャン**

```bash
grep -rn "distribute-external\|scripts/testflight\|upload_ios_background_assets\|asc_client\|altool" \
  --exclude-dir=node_modules --exclude-dir=.git --exclude-dir=docs . 
```

Expected: ヒットなし（docs/ 除外時）。

- [ ] **Step 2: lint 一式**

```bash
mise exec -- actionlint
shellcheck scripts/ci/testflight_test_notes.sh scripts/ci/asset_pack_ensure.sh scripts/ci/asset_pack_wait_version.sh
python3 -m json.tool .asc/workflow.json > /dev/null
asc workflow validate
```

Expected: すべてエラーなし。

- [ ] **Step 3: 実装計画のコミットと PR 作成**

```bash
git add docs/superpowers/plans/2026-08-04-asc-cli-cd-migration.md
git commit -m "docs: asc CLI 移行の実装計画を追加"
git push -u origin HEAD
gh pr create --repo YumNumm/EQMonitor --base develop \
  --title "ci: App Store Connect 通信を asc CLI へ移行" \
  --body "<変更点・検証内容・実走確認の残タスクを記載>"
```

PR 本文には以下を明記する:

- マージ後の実走確認が必要なこと:
  1. workflow_dispatch（ios のみ、external=false）で通常アップロードを確認
  2. workflow_dispatch（external=true）で外部配布（What to Test / グループ追加 / Beta レビュー申請）を確認
  3. upload-asset-pack.yaml の workflow_dispatch で Background Assets アップロードを確認
- `asc publish testflight` の Beta レビュー申請が「申請済み（旧実装では 409 を非致命扱い）」のケースでどう振る舞うかは実走で確認し、問題があれば低レベルコマンド（`asc builds` 系）への分解で対応すること

---

## Self-Review 結果

- スペック網羅: §1 導入=Task 1、§2 deploy-ios=Task 2+3、§3 Background Assets=Task 4+5、§4 認証=Task 3/5 に内包、テスト・検証=各タスク+Task 6。ギャップなし。
- 実走確認（workflow_dispatch）はマージ後にしかできないため、PR 本文への明記として Task 6 に落とした。
- 型整合: `asset_pack_ensure.sh` の出力 `{"assetId":...}` と workflow.json の `$.assetId`、`ASSET_ID` / `VERSION_ID` の参照名は一致。
