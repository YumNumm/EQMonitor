# iOS native jma_code_table slim staging Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** AppIntent / Widget 用に `jma_code_table.json` の都道府県・市区町村だけを backend Release からビルド時抽出し、iOS CD の欠落エラーを解消する。

**Architecture:** 抽出ロジックはテスト可能な Python（`tool/asset_pack/extract_ios_native_jma_code_table.py`）に置き、`stage_from_release.sh --target ios-native` が Release DL 後にそれを呼ぶ。配置先は既存 pbxproj が指す `app/assets/parameters/jma_code_table.json`（gitignored）。`deploy-app` の Build iOS で `flutter build` 前に stage する。Swift / pbxproj は触らない。

**Tech Stack:** Bash、Python 3（stdlib + `unittest`）、`jq`（既存 stage 検証用）、GitHub Actions、mise

## Global Constraints

- 正規データ源は `YumNumm/eqmonitor-backend` の `asset-pack-v*` Release のみ。フル JSON を git に戻さない。
- slim JSON は `code_tables.area_information_prefecture_earthquake` と `code_tables.area_information_city` のみ。エントリ形状はフル JSON のまま。
- いずれかのテーブル欠落または空配列なら stage は非ゼロ終了。空 JSON を書いて成功扱いにしない。
- Flutter / Asset Pack 実行時パス、`JmaCodeTable.swift`、`project.pbxproj` は変更しない。
- Android / macOS の `stage_from_release.sh` 挙動は変えない。
- Flutter / Dart コマンドは `mise exec --` 経由。Python テストは `python3 -m unittest ...`。
- コミットメッセージは英語1単語 prefix + 日本語1行（`.cursor/rules/commit-rules.mdc`）。

## File map

| Path | Responsibility |
|------|----------------|
| `tool/asset_pack/extract_ios_native_jma_code_table.py` | フル JSON → slim JSON 抽出・検証（純粋ロジック） |
| `tool/asset_pack/test_extract_ios_native_jma_code_table.py` | 抽出の単体テスト |
| `tool/asset_pack/stage_from_release.sh` | `--target ios-native` 追加、抽出呼び出し |
| `.gitignore` | slim 成果物を無視 |
| `app/assets/parameters/.gitkeep` | ディレクトリ維持 |
| `app/assets/parameters/Untitled` | 削除（追跡中のゴミ） |
| `.github/workflows/deploy-app.yaml` | Build iOS で stage |
| `docs/asset-pack-cd.md` / `docs/knowledge/20260728_asset_pack_release_staging.md` | ローカル・CI 手順追記 |
| `docs/todo/850_ios_missing_jma_code_table_json_build_break.md` | 解決済みとして更新または削除 |

---

### Task 1: Slim extract helper (TDD)

**Files:**
- Create: `tool/asset_pack/extract_ios_native_jma_code_table.py`
- Create: `tool/asset_pack/test_extract_ios_native_jma_code_table.py`

**Interfaces:**
- Produces: `extract_slim_jma_code_table(*, source: Path, destination: Path) -> None`
  - Reads UTF-8 JSON from `source`
  - Writes slim JSON to `destination` (creates parent dirs)
  - Raises `ExtractError` (subclass of `Exception`) when required tables missing or empty
- Produces: CLI `python3 -m tool.asset_pack.extract_ios_native_jma_code_table --source PATH --destination PATH` (exit 0 / 1)

- [ ] **Step 1: Write failing tests**

```python
import json
import tempfile
import unittest
from pathlib import Path

from tool.asset_pack.extract_ios_native_jma_code_table import (
    ExtractError,
    extract_slim_jma_code_table,
)


def _full_fixture() -> dict:
    return {
        "metadata": {"type": "jma_code_table", "schema_version": "1"},
        "code_tables": {
            "area_information_prefecture_earthquake": [
                {"code": "13", "name": {"ja": "東京都"}},
            ],
            "area_information_city": [
                {"code": "1310100", "name": {"ja": "千代田区"}},
            ],
            "area_epicenter": [{"code": "999", "name": {"ja": "不要"}}],
        },
    }


class ExtractSlimJmaCodeTableTest(unittest.TestCase):
    def setUp(self) -> None:
        self.tmp = tempfile.TemporaryDirectory()
        self.root = Path(self.tmp.name)

    def tearDown(self) -> None:
        self.tmp.cleanup()

    def test_keeps_only_prefecture_and_city_tables(self) -> None:
        source = self.root / "full.json"
        dest = self.root / "out" / "jma_code_table.json"
        source.write_text(json.dumps(_full_fixture()), encoding="utf-8")

        extract_slim_jma_code_table(source=source, destination=dest)

        slim = json.loads(dest.read_text(encoding="utf-8"))
        self.assertEqual(
            set(slim.keys()),
            {"code_tables"},
        )
        self.assertEqual(
            set(slim["code_tables"].keys()),
            {
                "area_information_prefecture_earthquake",
                "area_information_city",
            },
        )
        self.assertEqual(
            slim["code_tables"]["area_information_prefecture_earthquake"][0]["name"]["ja"],
            "東京都",
        )
        self.assertNotIn("area_epicenter", slim["code_tables"])
        self.assertNotIn("metadata", slim)

    def test_rejects_empty_prefecture_table(self) -> None:
        fixture = _full_fixture()
        fixture["code_tables"]["area_information_prefecture_earthquake"] = []
        source = self.root / "full.json"
        source.write_text(json.dumps(fixture), encoding="utf-8")

        with self.assertRaises(ExtractError):
            extract_slim_jma_code_table(
                source=source,
                destination=self.root / "out.json",
            )

    def test_rejects_missing_city_table(self) -> None:
        fixture = _full_fixture()
        del fixture["code_tables"]["area_information_city"]
        source = self.root / "full.json"
        source.write_text(json.dumps(fixture), encoding="utf-8")

        with self.assertRaises(ExtractError):
            extract_slim_jma_code_table(
                source=source,
                destination=self.root / "out.json",
            )


if __name__ == "__main__":
    unittest.main()
```

- [ ] **Step 2: Run tests and verify RED**

```bash
python3 -m unittest tool.asset_pack.test_extract_ios_native_jma_code_table -v
```

Expected: FAIL（モジュール未作成 / import error）

- [ ] **Step 3: Implement extractor**

`tool/asset_pack/extract_ios_native_jma_code_table.py`:

```python
#!/usr/bin/env python3
"""Extract AppIntent-only tables from a full jma_code_table.json."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import Any

PREFECTURE_KEY = "area_information_prefecture_earthquake"
CITY_KEY = "area_information_city"


class ExtractError(Exception):
    """Required tables are missing, empty, or the source is unreadable."""


def _require_non_empty_list(code_tables: dict[str, Any], key: str) -> list[Any]:
    value = code_tables.get(key)
    if not isinstance(value, list) or len(value) == 0:
        raise ExtractError(f"code_tables.{key} must be a non-empty array")
    return value


def extract_slim_jma_code_table(*, source: Path, destination: Path) -> None:
    try:
        raw = json.loads(source.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as err:
        raise ExtractError(f"cannot read source JSON {source}: {err}") from err

    if not isinstance(raw, dict):
        raise ExtractError("root must be a JSON object")
    code_tables = raw.get("code_tables")
    if not isinstance(code_tables, dict):
        raise ExtractError("code_tables must be an object")

    slim = {
        "code_tables": {
            PREFECTURE_KEY: _require_non_empty_list(code_tables, PREFECTURE_KEY),
            CITY_KEY: _require_non_empty_list(code_tables, CITY_KEY),
        }
    }

    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(
        json.dumps(slim, ensure_ascii=False, separators=(",", ":")) + "\n",
        encoding="utf-8",
    )


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", required=True, type=Path)
    parser.add_argument("--destination", required=True, type=Path)
    args = parser.parse_args(argv)
    try:
        extract_slim_jma_code_table(source=args.source, destination=args.destination)
    except ExtractError as err:
        print(f"::error::{err}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
```

- [ ] **Step 4: Run tests and verify GREEN**

```bash
python3 -m unittest tool.asset_pack.test_extract_ios_native_jma_code_table -v
```

Expected: `Ran 3 tests ... OK`

- [ ] **Step 5: Commit**

```bash
git add tool/asset_pack/extract_ios_native_jma_code_table.py \
  tool/asset_pack/test_extract_ios_native_jma_code_table.py
git commit -m "$(cat <<'EOF'
feat: AppIntent用 jma_code_table slim抽出ヘルパーを追加

EOF
)"
```

---

### Task 2: `stage_from_release.sh --target ios-native` + gitignore

**Files:**
- Modify: `tool/asset_pack/stage_from_release.sh`
- Modify: `.gitignore`
- Create: `app/assets/parameters/.gitkeep`
- Delete: `app/assets/parameters/Untitled`

**Interfaces:**
- Consumes: `extract_slim_jma_code_table` CLI from Task 1
- Produces: `--target ios-native` writes `$IOS_NATIVE_JMA_CODE_TABLE`（default `app/assets/parameters/jma_code_table.json`）
- Produces: after write, removes other files under `app/assets/parameters/` except `.gitkeep` and the slim JSON（フル pack は置かない）

- [ ] **Step 1: Extend usage / env defaults**

Near the top of `stage_from_release.sh`, add:

```bash
IOS_NATIVE_JMA_CODE_TABLE="${IOS_NATIVE_JMA_CODE_TABLE:-app/assets/parameters/jma_code_table.json}"
```

Update the header comment usage line to:

```bash
#   GH_TOKEN=... stage_from_release.sh [--version X.Y.Z] --target android|macos|both|ios-native
```

- [ ] **Step 2: Accept `ios-native` in target validation**

Change the `case "$target"` validation to:

```bash
case "$target" in
  android|macos|both|ios-native) ;;
  *)
    echo "stage_from_release.sh: invalid --target '$target'" >&2
    exit 2
    ;;
esac
```

And the required-arg error message to include `ios-native`.

- [ ] **Step 3: Add staging branch after pack validation**

Replace the final `case "$target"` that only calls `stage_into` with:

```bash
stage_ios_native() {
  local source="$workdir/extracted/parameters/jma_code_table.json"
  local dest="$IOS_NATIVE_JMA_CODE_TABLE"
  local dest_dir
  dest_dir=$(dirname "$dest")

  echo "==> Extracting slim jma_code_table for iOS native extensions -> $dest"
  mkdir -p "$dest_dir"
  # Drop junk / previous artifacts; keep .gitkeep only.
  find "$dest_dir" -mindepth 1 -maxdepth 1 ! -name '.gitkeep' -exec rm -rf {} +

  python3 -m tool.asset_pack.extract_ios_native_jma_code_table \
    --source "$source" \
    --destination "$dest"

  test -s "$dest"
}

case "$target" in
  android)
    stage_into "$ANDROID_DIR"
    ;;
  macos)
    stage_into "$MACOS_DIR"
    ;;
  both)
    stage_into "$ANDROID_DIR"
    stage_into "$MACOS_DIR"
    ;;
  ios-native)
    stage_ios_native
    ;;
esac
```

Keep the existing required-file list and `pack_version` check for `ios-native` as well（フル pack 検証は通すが、コピーはしない）.

- [ ] **Step 4: gitignore + directory hygiene**

Append to `.gitignore`（Android/macOS stage ブロック付近）:

```gitignore
# iOS AppIntent/Widget slim jma_code_table (staged from backend Release)
app/assets/parameters/jma_code_table.json
```

```bash
printf '' > app/assets/parameters/.gitkeep
git rm -f app/assets/parameters/Untitled
```

- [ ] **Step 5: Smoke-test extract wiring without network（optional local）**

If a full fixture is available locally under a temp dir:

```bash
python3 -m tool.asset_pack.extract_ios_native_jma_code_table \
  --source /path/to/full.json \
  --destination /tmp/jma_code_table.json
jq '.code_tables | keys' /tmp/jma_code_table.json
```

Expected keys: only the two table names.

Do **not** require live `gh release download` in this task if token/network is unavailable; CI covers that in Task 3.

- [ ] **Step 6: Commit**

```bash
git add tool/asset_pack/stage_from_release.sh .gitignore \
  app/assets/parameters/.gitkeep
git add -u app/assets/parameters/Untitled
git commit -m "$(cat <<'EOF'
feat: stage_from_release に ios-native slim抽出を追加

EOF
)"
```

---

### Task 3: Wire Build iOS in `deploy-app.yaml`

**Files:**
- Modify: `.github/workflows/deploy-app.yaml`（`build-ios` job）

**Interfaces:**
- Consumes: `stage_from_release.sh --target ios-native` from Task 2
- Produces: Build iOS runs stage **before** `flutter build ios --config-only` / archive

- [ ] **Step 1: Insert GitHub App token + stage steps before Configure iOS**

In `build-ios`, after `Resolve dependencies` and **before** `Extract environment variables` / `Configure iOS`, add the same pattern as `build-android`（SHA ピンは Android ステップと同一）:

```yaml
      # AppIntent/Widget Bundle Resources need a slim jma_code_table.json.
      # Full parameters stay on Managed Background Assets at runtime.
      - name: Generate GitHub App token (eqmonitor-backend contents:read)
        id: asset-pack-token
        uses: actions/create-github-app-token@bcd2ba49218906704ab6c1aa796996da409d3eb1 # v3.2.0
        with:
          app-id: ${{ vars.EQMONITOR_GITHUB_APP_ID }}
          private-key: ${{ secrets.EQMONITOR_GITHUB_APP_PRIVATE_KEY }}
          owner: YumNumm
          repositories: |
            eqmonitor-backend
          permission-contents: read

      - name: Stage iOS native jma_code_table from backend Release
        env:
          GH_TOKEN: ${{ steps.asset-pack-token.outputs.token }}
        run: tool/asset_pack/stage_from_release.sh --target ios-native
```

Confirm `gh` is available on `macos-26` runners（通常プリインストール）。無い場合は既存 Android job がどうしているか合わせる — Android は `gh` を明示インストールしていないので、そのままとする。

- [ ] **Step 2: Lint the workflow**

```bash
mise exec -- actionlint .github/workflows/deploy-app.yaml
# and/or
mise exec -- zizmor .github/workflows/deploy-app.yaml
```

Expected: no new findings on the added steps.

- [ ] **Step 3: Commit**

```bash
git add .github/workflows/deploy-app.yaml
git commit -m "$(cat <<'EOF'
ci: Build iOS 前に jma_code_table slim を stage する

EOF
)"
```

---

### Task 4: Docs + close TODO 850

**Files:**
- Modify: `docs/asset-pack-cd.md`
- Modify: `docs/knowledge/20260728_asset_pack_release_staging.md`
- Modify or Delete: `docs/todo/850_ios_missing_jma_code_table_json_build_break.md`
- Optional one-liner: `docs/ios-background-assets.md`（ローカル iOS ビルド前の stage を記載）

- [ ] **Step 1: Document `ios-native` target**

In `docs/knowledge/20260728_asset_pack_release_staging.md` の表に行を追加:

| iOS AppIntent/Widget | `deploy-app.yaml` の `build-ios` が `stage_from_release.sh --target ios-native` で prefecture/city のみ抽出して `app/assets/parameters/jma_code_table.json` に配置（gitignored）。ランタイムの Flutter は Background Assets のフル JSON を読む |

Usage 例:

```bash
GH_TOKEN=... tool/asset_pack/stage_from_release.sh --target ios-native
```

In `docs/asset-pack-cd.md` のプラットフォーム表にも同様の1行を追加。

- [ ] **Step 2: Resolve TODO 850**

ファイル先頭に解決メモを追記して残すか、削除する。残す場合:

```markdown
## 解決 (2026-07-28)

Approach B: `stage_from_release.sh --target ios-native` が slim JSON を
ビルド時配置。詳細は
`docs/superpowers/specs/2026-07-28-ios-native-jma-code-table-staging-design.md`。
```

- [ ] **Step 3: Commit + push**

```bash
git add docs/asset-pack-cd.md \
  docs/knowledge/20260728_asset_pack_release_staging.md \
  docs/todo/850_ios_missing_jma_code_table_json_build_break.md \
  docs/ios-background-assets.md
git commit -m "$(cat <<'EOF'
docs: ios-native jma_code_table stage 手順を追記

EOF
)"
git push origin HEAD
```

- [ ] **Step 4: Verify CI（手動確認）**

`develop` 上の最新 `Deploy App` run で:

- Build iOS の `Stage iOS native jma_code_table from backend Release` が success
- その後の archive が `jma_code_table.json` 欠落で落ちない

```bash
gh run list --workflow=deploy-app.yaml --branch=develop --limit 3
```

---

## Spec coverage self-review

| Spec requirement | Task |
|------------------|------|
| slim extract (prefecture + city only) | Task 1 |
| empty/missing → non-zero | Task 1 |
| `--target ios-native` + no full pack copy | Task 2 |
| default path + `IOS_NATIVE_JMA_CODE_TABLE` | Task 2 |
| gitignore + drop Untitled junk | Task 2 |
| deploy-app Build iOS before flutter build | Task 3 |
| GH_TOKEN aligned with Android | Task 3 |
| docs / local command | Task 4 |
| close TODO 850 | Task 4 |
| do not change Swift / pbxproj | all（触れない） |

## Placeholder scan

None intentional. Live `gh release download` smoke is deferred to CI when local token is absent（Task 2 Step 5 explicitly optional）.
