# Deploy Release Notes + Beta Flag Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** develop / beta / 手動配布で `IS_BETA_TESTING` を正しく分け、iOS・Android それぞれ前回配信 `rev` 起点の配布ノートを専用 Job で生成して全配布チャネルへ渡す。

**Architecture:** `resolve_deploy_app_policy.sh` が `is-beta-testing` を出し、`generate-release-note-ios` / `generate-release-note-android` が `scripts/ci/generate_release_note.sh` でノート artifact を作る。起点は iOS=ASC TestFlight test-notes、Android=Google Play 対象トラックの前回 release notes。deploy 各 Job は artifact を消費し、切り詰め時も `rev:` を残す。

**Tech Stack:** GitHub Actions、Bash、Python 3、`unittest`、asc CLI、Google Play Android Publisher API（curl）、mise

**Spec:** `docs/superpowers/specs/2026-08-14-deploy-release-notes-and-beta-flag-design.md`

## Global Constraints

- Job 名は `generate-release-note-ios` / `generate-release-note-android` とする（`build-release-notes` は使わない）。
- 起点は各プラットフォームの前回配信ノート内 `rev: <40桁 SHA>`。git タグへのフォールバックはしない。
- `push` develop → `IS_BETA_TESTING` を渡さない。`v*-beta.*` → `true`。`workflow_dispatch` → 入力 `is_beta_testing`（既定 false）。
- iOS と Android のノート本文は一致させない（前回 SHA が異なれば差分も異なる）。
- Flutter / Dart / リポジトリ tool は `mise exec --` 経由。
- コミットはユーザー指示があるまで作らない（各 Task の Commit ステップはスキップ可）。

## File Structure

| Path | Role |
| --- | --- |
| `scripts/ci/resolve_deploy_app_policy.sh` | `is-beta-testing` 出力を追加 |
| `scripts/ci/test_resolve_deploy_app_policy.sh` | 上記の期待値更新 |
| `scripts/ci/generate_release_note.sh` | 本文生成（PLATFORM=ios\|android） |
| `scripts/ci/truncate_release_note.py` | 上限切り詰め＋`rev:` 行保持 |
| `scripts/ci/test_generate_release_note.sh` | BASE_SHA 指定の本文生成テスト |
| `scripts/ci/test_truncate_release_note.py` | 切り詰めテスト |
| `scripts/ci/fetch_android_play_base_sha.sh` | Play トラックから前回 `rev` 取得 |
| `scripts/ci/testflight_test_notes.sh` | 削除（置き換え後） |
| `.github/workflows/deploy-app.yaml` | 入力・Job・ビルド dart-define・deploy 配線 |

---

### Task 1: `is-beta-testing` を deploy policy に追加

**Files:**

- Modify: `scripts/ci/resolve_deploy_app_policy.sh`
- Modify: `scripts/ci/test_resolve_deploy_app_policy.sh`
- Modify: `.github/workflows/deploy-app.yaml`（inputs + define-matrix の env のみ）

**Interfaces:**

- Consumes: `INPUT_IS_BETA_TESTING`（`true` / `false`）
- Produces: stdout に `is-beta-testing=true|false`
- Produces: `define-matrix.outputs.is-beta-testing`

- [ ] **Step 1: 失敗するテスト期待値を追加**

`test_resolve_deploy_app_policy.sh` の各 `assert_policy` 期待出力末尾に `is-beta-testing=...` を足す。

```bash
assert_policy \
  beta-tag \
  $'deploy-ios=true\ndeploy-android=true\ndeploy-ios-external=true\nandroid-track=external\nis-beta-testing=true\n' \
  EVENT_NAME=push \
  REF_TYPE=tag \
  REF_NAME=v3.0.0-beta.2 \
  COMMITS_JSON='[]' \
  INPUT_IOS=false \
  INPUT_ANDROID=false \
  INPUT_EXTERNAL=false \
  INPUT_IS_BETA_TESTING=false

assert_policy \
  develop \
  $'deploy-ios=true\ndeploy-android=true\ndeploy-ios-external=false\nandroid-track=internal\nis-beta-testing=false\n' \
  EVENT_NAME=push \
  REF_TYPE=branch \
  REF_NAME=develop \
  COMMITS_JSON='[{"message":"fix: ordinary push"}]' \
  INPUT_IOS=false \
  INPUT_ANDROID=false \
  INPUT_EXTERNAL=false \
  INPUT_IS_BETA_TESTING=false

assert_policy \
  workflow-dispatch-beta \
  $'deploy-ios=true\ndeploy-ios-external=false\nandroid-track=internal\nis-beta-testing=true\n' \
  EVENT_NAME=workflow_dispatch \
  REF_TYPE=branch \
  REF_NAME=develop \
  COMMITS_JSON='[]' \
  INPUT_IOS=true \
  INPUT_ANDROID=false \
  INPUT_EXTERNAL=false \
  INPUT_IS_BETA_TESTING=true
```

既存の `develop-external` / `workflow-dispatch` ケースにも `is-beta-testing=false` を追加する。`INPUT_IS_BETA_TESTING` 未設定だと resolver が落ちる想定なので、全呼び出しに明示する。

- [ ] **Step 2: テストを RED で確認**

```bash
mise exec -- bash scripts/ci/test_resolve_deploy_app_policy.sh
```

Expected: FAIL（`is-beta-testing` 未出力 / `INPUT_IS_BETA_TESTING` 未定義）

- [ ] **Step 3: resolver を実装**

`resolve_deploy_app_policy.sh` 先頭の必須変数に `INPUT_IS_BETA_TESTING` を追加。分岐の末尾で:

```bash
is_beta_testing=false
if [[ "$EVENT_NAME" == "push" && "$REF_TYPE" == "tag" && "$REF_NAME" == v*-beta.* ]]; then
  is_beta_testing=true
elif [[ "$EVENT_NAME" == "workflow_dispatch" && "$INPUT_IS_BETA_TESTING" == "true" ]]; then
  is_beta_testing=true
fi
echo "is-beta-testing=$is_beta_testing"
```

develop push は常に `false`（`[external]` でも Beta フラグは立てない）。

- [ ] **Step 4: workflow 入力と define-matrix 配線**

`deploy-app.yaml` の `workflow_dispatch.inputs` に:

```yaml
is_beta_testing:
  description: "Set IS_BETA_TESTING dart-define"
  required: false
  default: false
  type: boolean
```

`define-matrix` の env に:

```yaml
INPUT_IS_BETA_TESTING: ${{ inputs.is_beta_testing || false }}
```

- [ ] **Step 5: テスト GREEN**

```bash
mise exec -- bash scripts/ci/test_resolve_deploy_app_policy.sh
```

Expected: PASS

---

### Task 2: ノート本文生成コア（BASE_SHA 指定）

**Files:**

- Create: `scripts/ci/generate_release_note.sh`
- Create: `scripts/ci/test_generate_release_note.sh`

**Interfaces:**

- Consumes env: `PLATFORM` (`ios`|`android`), `OUTPUT_PATH`, optional `BASE_SHA`, optional `MAX_LENGTH`（default 4000）, optional `REPO_ROOT`
- Produces: `$OUTPUT_PATH` に本文（末尾 `rev: <HEAD>`）。stderr に進捗。
- When `BASE_SHA` set: ASC / Play へ問い合わせない。

- [ ] **Step 1: 失敗するシェルテストを書く**

`test_generate_release_note.sh` で一時 git repo を作り、squash / merge / その他 commit を用意してスクリプトを呼ぶ。

```bash
#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
GEN="$SCRIPT_DIR/generate_release_note.sh"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

git -C "$TMP" init -q
git -C "$TMP" config user.email t@example.com
git -C "$TMP" config user.name t
git -C "$TMP" commit --allow-empty -m 'base' -q
BASE=$(git -C "$TMP" rev-parse HEAD)
git -C "$TMP" commit --allow-empty -m 'feat: hello (#42)' -q
git -C "$TMP" commit --allow-empty -m 'chore: direct' -q

OUT="$TMP/notes.txt"
REPO_ROOT="$TMP" PLATFORM=ios OUTPUT_PATH="$OUT" BASE_SHA="$BASE" \
  bash "$GEN"

grep -F '・#42 feat: hello' "$OUT"
grep -E 'その他 1 件' "$OUT"
grep -E "^rev: $(git -C "$TMP" rev-parse HEAD)$" "$OUT"
```

追加ケース: `BASE_SHA` 空相当（未解決）→ 「前回の配信ビルドを特定できなかった」系メッセージ + `rev:` のみ。`BASE_SHA==HEAD` → 「変更はありません」+ `rev:`。

- [ ] **Step 2: RED 確認**

```bash
mise exec -- bash scripts/ci/test_generate_release_note.sh
```

Expected: FAIL（スクリプト未作成）

- [ ] **Step 3: KEVi 移植の最小実装**

`generate_release_note.sh` に次を入れる（KEVi `build-testflight-changelog.sh` 準拠）:

- `merge_re='^Merge pull request #([0-9]+) from '`
- `squash_re='^(.+) \(#([0-9]+)\)$'`
- first-parent log で PR 行 `・#N title` を組み立て
- 非 PR は `OTHER_COUNT`
- 本文 + 空行 + `rev: $HEAD_SHA`
- `PLATFORM` 未設定や不正値は `die`
- `BASE_SHA` 未設定時はプレースホルダ関数 `resolve_base_sha_for_platform` を呼び、Task 3/4 で中身を埋める。今は `BASE_SHA` 必須扱いで、未設定なら空のまま「特定できず」文面でもよい（後続 Task で接続）

この Task では `BASE_SHA` が空なら「特定できなかった」本文だけ出せばよい。

- [ ] **Step 4: GREEN 確認**

```bash
mise exec -- bash scripts/ci/test_generate_release_note.sh
```

Expected: PASS

---

### Task 3: iOS 起点（ASC test-notes の `rev`）

**Files:**

- Modify: `scripts/ci/generate_release_note.sh`（`PLATFORM=ios` の resolve）
- Modify: `scripts/ci/test_generate_release_note.sh`（fake `asc`）

**Interfaces:**

- Consumes: `ASC_APP_ID`（EQMonitor: `6447546703`）、`ASC_*` 認証、`TESTFLIGHT_LOCALE` default `ja`、`LOOKBACK` default `5`、`ASC_BIN` optional
- Produces: 見つかった `BASE_SHA`、または空

- [ ] **Step 1: fake asc で失敗テスト追加**

`PATH` 先頭に fake `asc` を置き、`builds list` / `builds test-notes list` に JSON を返す。notes に `rev: <known_sha>` を含め、スクリプトがそれを BASE にするケースと、手元に無い SHA を読み飛ばすケースを書く。

- [ ] **Step 2: RED → iOS resolve 実装 → GREEN**

実装要点（KEVi と同じ）:

```bash
"$ASC" builds list --app "$APP_ID" --platform IOS --sort -uploadedDate --limit "$LOOKBACK" --output json
"$ASC" builds test-notes list --app "$APP_ID" --build-number "$n" --platform IOS --locale "$LOCALE" --output json
# grep -Eo 'rev: [0-9a-f]{40}'
# git cat-file -e "$candidate^{commit}"
```

`APP_ID` は `ASC_APP_ID`（workflow では既存どおり `6447546703`）。

---

### Task 4: Android 起点（Google Play トラック notes の `rev`）

**Files:**

- Create: `scripts/ci/fetch_android_play_base_sha.sh`
- Create: `scripts/ci/test_fetch_android_play_base_sha.sh`
- Modify: `scripts/ci/generate_release_note.sh`（android 分岐から呼び出す）

**Interfaces:**

- Consumes: `GOOGLE_PLAY_ACCESS_TOKEN`, `PACKAGE_NAME`（`net.yumnumm.eqmonitor`）, `TRACK_NAME`（`internal`|`external`）
- Produces: stdout に 40 桁 SHA または空行。exit 0（見つからなくても 0）

- [ ] **Step 1: fake curl fixture で RED テスト**

`ensure_google_play_track.sh` と同様、edit 作成 → `GET .../tracks/$TRACK_NAME` の JSON に `releaseNotes[].text` を含め、`rev:` を抽出する。

```json
{
  "track": "internal",
  "releases": [
    {
      "status": "completed",
      "releaseNotes": [{ "language": "ja-JP", "text": "変更点\n\nrev: abcdef..." }]
    }
  ]
}
```

複数 release がある場合は配列先頭（API が新しい順で返す想定）から探し、`rev` が無いリリースは読み飛ばす。

- [ ] **Step 2: 実装**

`scripts/release/ensure_google_play_track.sh` と同じ edits ライフサイクル（作成 → GET track → DELETE edit）。`jq` で `ja-JP` 優先、無ければ先頭 language の text から `rev: [0-9a-f]{40}` を取る。

- [ ] **Step 3: `generate_release_note.sh` の android 分岐**

`BASE_SHA` 未指定かつ `PLATFORM=android` のとき `fetch_android_play_base_sha.sh` の出力を使う。返ってきた SHA は `git cat-file -e` で実在確認。

- [ ] **Step 4: GREEN**

```bash
mise exec -- bash scripts/ci/test_fetch_android_play_base_sha.sh
mise exec -- bash scripts/ci/test_generate_release_note.sh
```

---

### Task 5: `rev` 保持つき切り詰め

**Files:**

- Create: `scripts/ci/truncate_release_note.py`
- Create: `scripts/ci/test_truncate_release_note.py`

**Interfaces:**

- CLI: `python3 scripts/ci/truncate_release_note.py --max-chars N < input > output`
- Function: `truncate_release_note(text: str, max_chars: int) -> str`
- 末尾の `rev: <40hex>` 行は必ず残す。本文側を先に削る。

- [ ] **Step 1: unittest を書く（RED）**

```python
def test_keeps_rev_when_truncating(self) -> None:
    body = "あ" * 480 + "\n\nrev: " + "a" * 40 + "\n"
    out = truncate_release_note(body, 500)
    self.assertTrue(out.endswith("rev: " + "a" * 40 + "\n") or "rev: " + "a" * 40 in out)
    self.assertLessEqual(len(out), 500)

def test_short_text_unchanged(self) -> None:
    text = "変更点\n・#1 x\n\nrev: " + "b" * 40 + "\n"
    self.assertEqual(truncate_release_note(text, 500), text)
```

- [ ] **Step 2: 実装して GREEN**

```bash
mise exec -- python3 -m unittest scripts/ci/test_truncate_release_note.py -v
```

Firebase 用 2000・Play 用 500 は呼び出し側で `--max-chars` を渡す。

---

### Task 6: workflow に generate Job を追加し deploy へ配線

**Files:**

- Modify: `.github/workflows/deploy-app.yaml`
- Delete or stop using: `scripts/ci/testflight_test_notes.sh`

**Interfaces:**

- Artifacts: `EQMonitor-release-notes-ios` → `release-notes-ios.txt`
- Artifacts: `EQMonitor-release-notes-android` → `release-notes-android.txt`

- [ ] **Step 1: `generate-release-note-ios` Job**

```yaml
generate-release-note-ios:
  name: Generate Release Note (iOS)
  needs: define-matrix
  if: ${{ needs.define-matrix.outputs.deploy-ios }}
  runs-on: macos-26   # または ubuntu-24.04（asc が動けば可）。既存 deploy-ios と同じ認証取り出しなら macos / ubuntu どちらでもよいが、asc 利用の最短は deploy-ios と同じ runner + mise install_args
  permissions:
    contents: read
  environment:
    name: EQMonitor-iOS
  steps:
    - checkout fetch-depth: 0
    - AGE / mise.local.toml / mise-action（asc）
    - mise env → GITHUB_ENV
    - run: PLATFORM=ios OUTPUT_PATH=release-notes-ios.txt ASC_APP_ID=6447546703 scripts/ci/generate_release_note.sh
    - upload-artifact name: EQMonitor-release-notes-ios path: release-notes-ios.txt
```

- [ ] **Step 2: `generate-release-note-android` Job**

```yaml
generate-release-note-android:
  name: Generate Release Note (Android)
  needs: define-matrix
  if: ${{ needs.define-matrix.outputs.deploy-android }}
  runs-on: ubuntu-24.04
  permissions:
    contents: read
    id-token: write
  environment:
    name: EQMonitor-Android
  steps:
    - checkout fetch-depth: 0
    - AGE / mise / WIF auth（deploy-android-google-play と同様）
    - PLATFORM=android TRACK_NAME=${{ needs.define-matrix.outputs.android-track }} PACKAGE_NAME=net.yumnumm.eqmonitor OUTPUT_PATH=release-notes-android.txt scripts/ci/generate_release_note.sh
    - upload-artifact EQMonitor-release-notes-android
```

- [ ] **Step 3: deploy-ios が artifact を使う**

`needs` に `generate-release-note-ios` を追加。download artifact。

- external: `asc publish testflight --test-notes "$(cat release-notes-ios.txt)" ...`（現行の `testflight_test_notes.sh` 呼び出しを削除）
- internal: `asc builds upload` のあと、アップロードしたビルドに対して:

```bash
asc builds test-notes create \
  --app "$ASC_APP_ID" \
  --latest \
  --platform IOS \
  --locale ja \
  --whats-new "$(cat release-notes-ios.txt)"
```

（create が既存で失敗する場合は `update` にフォールバック。実装時に asc の挙動に合わせる）

- [ ] **Step 4: Firebase iOS / Android / Google Play**

各 Job の `needs` に対応する generate Job を追加し、artifact を download。

```bash
# Firebase iOS
mise exec -- python3 scripts/ci/truncate_release_note.py --max-chars 2000 \
  < release-notes-ios.txt > changelog.txt

# Firebase Android
mise exec -- python3 scripts/ci/truncate_release_note.py --max-chars 2000 \
  < release-notes-android.txt > changelog.txt

# Google Play
mise exec -- python3 scripts/ci/truncate_release_note.py --max-chars 500 \
  < release-notes-android.txt > changelog.txt
jq -Rs '[{language: "ja-JP", text: .}]' changelog.txt > release-notes.json
```

既存の `Output release version` / `Output git log` ステップは削除し、バージョン表示が必要なら別途 1 行ヘッダを足す程度にする（`rev` 連鎖を壊さない範囲で）。

- [ ] **Step 5: `testflight_test_notes.sh` を削除**

参照が workflow から消えたことを `rg testflight_test_notes` で確認してから削除。

---

### Task 7: ビルドに `IS_BETA_TESTING` を条件付き適用

**Files:**

- Modify: `.github/workflows/deploy-app.yaml`（`build-ios` / `build-android`）

**Interfaces:**

- Consumes: `needs.define-matrix.outputs.is-beta-testing`
- Produces: `true` のときだけ `--dart-define IS_BETA_TESTING="true"`

- [ ] **Step 1: build ステップを条件付きに変更**

両方の flutter build で固定の `--dart-define IS_BETA_TESTING="true"` をやめ、例:

```bash
BETA_ARGS=()
if [ "${{ needs.define-matrix.outputs.is-beta-testing }}" = "true" ]; then
  BETA_ARGS+=(--dart-define IS_BETA_TESTING="true")
fi
flutter build ios --config-only ... "${BETA_ARGS[@]}"
```

`build-ios` / `build-android` の `needs` は既に `define-matrix` のみでよい。

- [ ] **Step 2: actionlint（可能なら）**

```bash
mise exec -- actionlint .github/workflows/deploy-app.yaml
```

Expected: 新規 Job / needs 周りのエラーなし

---

### Task 8: 知見ドキュメント更新

**Files:**

- Modify: `docs/beta/ios-testflight-checklist.md`（`IS_BETA_TESTING` の説明を develop / beta で分ける）
- Create: `docs/knowledge/20260814_deploy_release_notes_and_beta_flag.md`

- [ ] **Step 1: knowledge に運用ルールを書く**

含める内容:

- develop push は Beta フラグなし
- `/beta` → `v*-beta.*` は Beta フラグあり
- 配布ノートは `generate-release-note-ios|android`
- `rev:` が次回差分の起点。内部 TestFlight / Play にも必ず書く

- [ ] **Step 2: checklist の「通常ビルドは IS_BETA_TESTING=true」記述を修正**

---

## Spec Coverage Checklist

| Spec 要件 | Task |
| --- | --- |
| generate-release-note-ios / android | 6 |
| iOS ASC `rev` 起点 | 3, 6 |
| Android Play `rev` 起点 | 4, 6 |
| 全チャネルが各 artifact を利用 | 6 |
| 内部経路でも `rev` 書き込み | 6 |
| develop で Beta フラグなし | 1, 7 |
| beta タグで Beta フラグあり | 1, 7 |
| workflow_dispatch 既定 false | 1, 7 |
| 切り詰めで `rev` 保持 | 5, 6 |
| policy / generate テスト | 1–5 |

## Self-Review Notes

- Android の前回 notes 取得は `google-play-cli` に read API が無いため、既存の edits + curl パターンで実装する（Task 4）。
- internal TestFlight の notes 書き込みは `asc builds test-notes create|update`（Task 6）。`publish testflight` は external のみ。
- コミットステップはユーザー方針により省略可。

---

Plan complete. 実装に進む場合の選択肢:

**1. Subagent-Driven（推奨）** — Task ごとにサブエージェントを起動し、間でレビュー
**2. Inline Execution** — このセッションで順に実装

どちらにしますか？
