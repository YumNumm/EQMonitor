# Beta Release Deployment Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `/beta` が作成するbetaタグからiOS/Androidの外部テスト配布とGitHub Deployment記録を開始し、Release Notes内の変更タイトルにある `@` の誤メンションを防ぐ。

**Architecture:** beta tag pushを `Deploy App` の正式トリガーにし、イベントから配布matrixを決めるロジックをテスト可能なshell scriptへ分離する。GitHub生成Release NotesはPython sanitizerを通し、変更タイトルだけを無害化して正式な作者メンションを維持する。

**Tech Stack:** GitHub Actions YAML、Bash、Python 3標準ライブラリ、`unittest`、actionlint、mise

## Global Constraints

- beta tag patternは `v*-beta.*` とする。
- beta配布先はiOS App Store Connect/Firebase/TestFlight external、Android Firebase/Google Play `external` とする。
- `develop` pushと手動実行のAndroid trackは `internal` のまま維持する。
- PRタイトルまたはコミットメッセージ部分のすべての `@` を `&#64;` にする。
- `by @author` とNew Contributorsの正式な作者メンションは維持する。
- 外部配布失敗時に内部配布へフォールバックしない。
- Flutter/Dartコマンドとリポジトリtoolは `mise exec --` 経由で実行する。

---

### Task 1: Release Notes sanitizer

**Files:**
- Create: `scripts/release/sanitize_release_notes.py`
- Create: `scripts/release/test_sanitize_release_notes.py`

**Interfaces:**
- Consumes: UTF-8 Markdown from stdin.
- Produces: sanitized UTF-8 Markdown on stdout.
- Produces: `sanitize_release_notes(notes: str) -> str` for focused tests.

- [ ] **Step 1: Write failing tests for title-only escaping**

Add literal fixtures covering ordinary PR titles, `@Default(ja)`, multiple `@`, New Contributors, a direct-commit URL, and a second sanitizer pass:

```python
class SanitizeReleaseNotesTest(unittest.TestCase):
    def test_escapes_at_signs_only_in_change_title(self) -> None:
        notes = (
            "* fix: @Default(ja) and @example "
            "by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/1234\n"
        )
        self.assertEqual(
            sanitize_release_notes(notes),
            "* fix: &#64;Default(ja) and &#64;example "
            "by @YumNumm in https://github.com/YumNumm/EQMonitor/pull/1234\n",
        )

    def test_preserves_new_contributor_mentions(self) -> None:
        notes = (
            "## New Contributors\n"
            "* @cursor[bot] made their first contribution in "
            "https://github.com/YumNumm/EQMonitor/pull/1161\n"
        )
        self.assertEqual(sanitize_release_notes(notes), notes)

    def test_is_idempotent(self) -> None:
        notes = (
            "* fix: @Default(ja) by @YumNumm in "
            "https://github.com/YumNumm/EQMonitor/pull/1234\n"
        )
        once = sanitize_release_notes(notes)
        self.assertEqual(sanitize_release_notes(once), once)
```

- [ ] **Step 2: Run tests and verify RED**

Run:

```bash
mise exec -- python3 -m unittest scripts/release/test_sanitize_release_notes.py -v
```

Expected: FAIL because `sanitize_release_notes.py` does not exist.

- [ ] **Step 3: Implement the minimal line transformer and stdin/stdout CLI**

Use a compiled regex that recognizes only a generated change bullet ending in
` by @author in https://github.com/.../(pull|commit)/...`. Split the title and suffix,
replace raw `@` only in the title, and join lines with their original line endings.

```python
CHANGE_LINE_PATTERN = re.compile(
    r"^(?P<title>\* .+?)(?P<suffix> by @[A-Za-z0-9](?:[A-Za-z0-9-]*|\[bot\])"
    r" in https://github\.com/.+/(?:pull|commit)/[^\s]+)$"
)


def sanitize_release_notes(notes: str) -> str:
    lines = notes.splitlines(keepends=True)
    return "".join(_sanitize_line(line) for line in lines)
```

The CLI reads `sys.stdin.read()` and writes the return value with `sys.stdout.write()`.

- [ ] **Step 4: Run tests and verify GREEN**

Run the same unittest command. Expected: all sanitizer tests PASS.

- [ ] **Step 5: Commit and push**

```bash
git add scripts/release/sanitize_release_notes.py scripts/release/test_sanitize_release_notes.py
git commit -m "fix: Release Notesの誤メンションを防止"
git push
```

### Task 2: Deploy App policy resolver

**Files:**
- Create: `scripts/ci/resolve_deploy_app_policy.sh`
- Create: `scripts/ci/test_resolve_deploy_app_policy.sh`
- Modify: `.github/workflows/deploy-app.yaml`

**Interfaces:**
- Consumes env: `EVENT_NAME`, `REF_TYPE`, `REF_NAME`, `COMMITS_JSON`, `INPUT_IOS`, `INPUT_ANDROID`, `INPUT_EXTERNAL`.
- Produces to stdout: GitHub output lines `deploy-ios`, `deploy-android`, `deploy-ios-external`, `android-track`.
- `deploy-app.yaml` appends stdout to `$GITHUB_OUTPUT`.

- [ ] **Step 1: Write failing executable policy tests**

The test invokes the real resolver with controlled environment variables and compares exact output files. Cover:

```text
beta tag push:
deploy-ios=true
deploy-android=true
deploy-ios-external=true
android-track=external

develop push without [external]:
deploy-ios=true
deploy-android=true
deploy-ios-external=false
android-track=internal

workflow_dispatch ios=false android=true external=true:
deploy-android=true
deploy-ios-external=true
android-track=internal
```

Also assert that an unsupported push ref exits non-zero.

- [ ] **Step 2: Run tests and verify RED**

Run:

```bash
mise exec -- bash scripts/ci/test_resolve_deploy_app_policy.sh
```

Expected: FAIL because the resolver does not exist.

- [ ] **Step 3: Implement the minimal resolver**

Use `set -euo pipefail` and explicit branches:

```bash
if [[ "$EVENT_NAME" == "workflow_dispatch" ]]; then
  # preserve boolean inputs; android-track=internal
elif [[ "$EVENT_NAME" == "push" && "$REF_TYPE" == "tag" && "$REF_NAME" == v*-beta.* ]]; then
  # both platforms; external=true; android-track=external
elif [[ "$EVENT_NAME" == "push" && "$REF_TYPE" == "branch" && "$REF_NAME" == "develop" ]]; then
  # both platforms; existing [external] check; android-track=internal
else
  echo "Unsupported deployment event/ref" >&2
  exit 1
fi
```

Emit only enabled platform keys, always emit `deploy-ios-external` and `android-track`.

- [ ] **Step 4: Run policy tests and verify GREEN**

Run the same Bash test command. Expected: all cases PASS.

- [ ] **Step 5: Wire the resolver and beta trigger into Deploy App**

Modify `on.push`:

```yaml
push:
  branches:
    - develop
  tags:
    - "v*-beta.*"
```

Add `android-track` to `define-matrix.outputs`. Replace inline decision logic with the resolver, passing:

```yaml
env:
  EVENT_NAME: ${{ github.event_name }}
  REF_TYPE: ${{ github.ref_type }}
  REF_NAME: ${{ github.ref_name }}
  COMMITS_JSON: ${{ toJSON(github.event.commits) }}
  INPUT_IOS: ${{ inputs.ios || false }}
  INPUT_ANDROID: ${{ inputs.android || false }}
  INPUT_EXTERNAL: ${{ inputs.external || false }}
run: scripts/ci/resolve_deploy_app_policy.sh >> "$GITHUB_OUTPUT"
```

Set Google Play's track from the output:

```yaml
env:
  RELEASE_NAME: ${{ steps.output_release_version.outputs.release_version }}
  GOOGLE_PLAY_TRACK: ${{ needs.define-matrix.outputs.android-track }}
```

Add `define-matrix` to `deploy-android-google-play.needs`, then use
`--track "$GOOGLE_PLAY_TRACK"`.

`google-play-cli 1.0.1` はtrack作成を行わないため、PR前レビューで次の境界を追加する。

- `scripts/release/ensure_google_play_track.sh` はAndroid Publisher APIでeditを作り、
  `external` が無い場合だけ `CLOSED_TESTING` / `DEFAULT` trackを作成・commitする。
- `scripts/ci/test_ensure_google_play_track.sh` はfake curlで未作成時のcreate/commitと
  作成済み時の再作成抑止を検証する。
- Google認証actionは `token_format: access_token` を出力し、external公開時だけ
  ensure scriptへ渡す。

- [ ] **Step 6: Run focused tests and actionlint**

```bash
mise exec -- bash scripts/ci/test_resolve_deploy_app_policy.sh
mise exec -- actionlint .github/workflows/*.yaml
```

Expected: both commands exit 0 without warnings.

- [ ] **Step 7: Commit and push**

```bash
git add scripts/ci/resolve_deploy_app_policy.sh scripts/ci/test_resolve_deploy_app_policy.sh .github/workflows/deploy-app.yaml
git commit -m "fix: betaタグから外部テスト配布を起動"
git push
```

### Task 3: Beta release creation and existing release repair

**Files:**
- Modify: `.github/workflows/create-beta-release.yaml`
- Create: `scripts/ci/test_create_beta_release_workflow.sh`

**Interfaces:**
- Consumes workflow input: `version: string`, `repair_existing_release: boolean`.
- Consumes: `scripts/release/sanitize_release_notes.py` from Task 1.
- Produces: new sanitized prerelease in normal mode, edited release body in repair mode.

- [ ] **Step 1: Write a failing workflow contract test**

Use `mise exec -- yq` to parse the workflow as data. Assert observable wiring contracts:

- `workflow_dispatch.inputs.repair_existing_release.type == "boolean"`.
- normal create-tag and create-release steps have conditions excluding repair mode.
- repair step condition requires repair mode.
- create and repair commands both pipe notes through `sanitize_release_notes.py`.
- release creation uses `--notes-file`, not `--generate-notes`.

- [ ] **Step 2: Run contract test and verify RED**

```bash
mise exec -- bash scripts/ci/test_create_beta_release_workflow.sh
```

Expected: FAIL because `repair_existing_release` and sanitizer wiring are absent.

- [ ] **Step 3: Add repair input and conditional steps**

Add:

```yaml
repair_existing_release:
  description: "Sanitize an existing beta release instead of creating one"
  required: false
  default: false
  type: boolean
```

Normal mode:

1. Generate notes with `gh api --method POST repos/${{ github.repository }}/releases/generate-notes` using `tag_name` and `target_commitish=develop`.
2. Pipe the body through `mise exec -- python3 scripts/release/sanitize_release_notes.py`.
3. Create prerelease with `gh release create --notes-file`.

Repair mode:

1. Require non-empty `inputs.version`.
2. Fetch body using `gh release view "$BETA_VERSION" --json body --jq .body`.
3. Sanitize and edit with `gh release edit "$BETA_VERSION" --notes-file`.
4. Skip tag creation and new release creation.

Install Python through the existing mise configuration before invoking the sanitizer if the ubuntu-slim runner does not expose it through mise.

- [ ] **Step 4: Run contract test, sanitizer tests, and actionlint**

```bash
mise exec -- bash scripts/ci/test_create_beta_release_workflow.sh
mise exec -- python3 -m unittest scripts/release/test_sanitize_release_notes.py -v
mise exec -- actionlint .github/workflows/*.yaml
```

Expected: all commands exit 0.

- [ ] **Step 5: Commit and push**

```bash
git add .github/workflows/create-beta-release.yaml scripts/ci/test_create_beta_release_workflow.sh
git commit -m "fix: betaリリース生成と既存本文修復を安全化"
git push
```

### Task 4: Operational knowledge and final verification

**Files:**
- Create: `docs/knowledge/20260725_beta_release_deployment.md`

**Interfaces:**
- Documents exact commands and expected GitHub Deployment/store states.

- [ ] **Step 1: Record the durable release workflow knowledge**

Document:

- `/beta` → GitHub App tag push → `Deploy App` sequence.
- beta store destinations and the `external` Android track.
- GitHub Deployments REST checks filtered by beta tag.
- how to dispatch repair mode for `v3.0.0-beta.1`.
- why title/message `@` is escaped while author `@` remains.
- no fixed-value or internal-track fallback on external publication failure.

- [ ] **Step 2: Run the complete verification suite**

```bash
mise exec -- python3 -m unittest scripts/release/test_sanitize_release_notes.py -v
mise exec -- bash scripts/ci/test_resolve_deploy_app_policy.sh
mise exec -- bash scripts/ci/test_create_beta_release_workflow.sh
mise exec -- actionlint .github/workflows/*.yaml
git --no-pager diff --check
```

Expected: all commands exit 0; no warnings or whitespace errors.

- [ ] **Step 3: Commit and push knowledge**

```bash
git add docs/knowledge/20260725_beta_release_deployment.md
git commit -m "docs: beta外部配布の運用手順を記録"
git push
```

- [ ] **Step 4: Review final branch scope**

```bash
git --no-pager status --short --branch
git --no-pager diff origin/develop...HEAD --stat
git --no-pager log --oneline origin/develop..HEAD
```

Expected: clean branch containing only the design, plan, sanitizer, focused tests, two workflows, policy resolver, and knowledge document.

- [ ] **Step 5: Create the pull request after all implementation is verified**

Open a draft PR from `fix/beta-release-deployment` to `develop`. Include root cause, beta distribution destinations, Release Notes sanitization boundary, repair instructions, and exact verification commands/results. Do not claim that the live stores or current Release were updated until the merged workflow is dispatched and GitHub Deployments/store results are verified.
