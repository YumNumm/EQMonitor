# TestFlight 外部グループ自動配布 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `develop` への push 等で iOS ビルドを TestFlight にアップロードする際、コミットメッセージに `[external]` が含まれる場合のみ、外部テストグループへ自動配布し、テスト内容（What to Test）をコミット件名から自動生成して設定する。

**Architecture:** ASC API 呼び出しロジックを単体テスト可能な Python スクリプト `scripts/testflight/distribute_external.py` に集約し、`.github/workflows/deploy-app.yaml` の `build-ios` ジョブに「altool アップロード後」の後続ステップとして組み込む（新ジョブは作らない=案A）。`[external]` 判定は `define-matrix` ジョブの output として算出する。

**Tech Stack:** GitHub Actions / bash / Python 3（uv 経由で `pyjwt[crypto]` を動的取得）/ App Store Connect REST API。

設計 spec: `docs/superpowers/specs/2026-06-16-testflight-external-auto-distribute-design.md`

---

## File Structure

- Create: `scripts/testflight/distribute_external.py` — ASC API オーケストレーター。純粋関数（`build_token` / `cap_text` / `build_whatsnew_from_git`）＋ HTTP クライアント＋メインフロー（処理完了ポーリング → What to Test 設定 → 外部グループ追加 → ベータ審査提出）。
- Create: `scripts/testflight/tests/distribute_external_test.py` — 純粋関数の単体テスト。
- Modify: `.github/workflows/deploy-app.yaml` — `define-matrix` に output `deploy-ios-external` を追加 / `workflow_dispatch` に input `external` 追加 / `build-ios` に配布ステップ追加・`timeout-minutes` 30→60・mise install_args に `uv` 追加。

各 ASC API エンドポイント（spec §2-4 参照）:
- `GET /v1/builds?filter[app]={app}&filter[version]={ver}&limit=1`
- `GET /v1/builds/{id}/betaBuildLocalizations`
- `POST /v1/betaBuildLocalizations` / `PATCH /v1/betaBuildLocalizations/{id}`
- `POST /v1/betaGroups/{groupId}/relationships/builds`
- `POST /v1/betaAppReviewSubmissions`

---

## Task 1: ASC オーケストレーター Python スクリプト

**Files:**
- Create: `scripts/testflight/distribute_external.py`
- Test: `scripts/testflight/tests/distribute_external_test.py`

- [ ] **Step 1: Write the failing test**

Create `scripts/testflight/tests/distribute_external_test.py`:

```python
"""Unit tests for distribute_external pure functions.

Run with: uv run --with 'pyjwt[crypto]' scripts/testflight/tests/distribute_external_test.py
"""
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

import jwt  # noqa: E402  (PyJWT, provided by uv --with 'pyjwt[crypto]')
from cryptography.hazmat.primitives import serialization  # noqa: E402
from cryptography.hazmat.primitives.asymmetric import ec  # noqa: E402

import distribute_external as d  # noqa: E402


def _gen_pem() -> str:
    key = ec.generate_private_key(ec.SECP256R1())
    return key.private_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PrivateFormat.PKCS8,
        encryption_algorithm=serialization.NoEncryption(),
    ).decode()


def test_build_token():
    token = d.build_token("KID123", "ISS456", _gen_pem())
    header = jwt.get_unverified_header(token)
    assert header["alg"] == "ES256", header
    assert header["kid"] == "KID123", header
    payload = jwt.decode(token, options={"verify_signature": False})
    assert payload["iss"] == "ISS456", payload
    assert payload["aud"] == "appstoreconnect-v1", payload
    assert 0 < payload["exp"] - payload["iat"] <= 20 * 60, payload


def test_cap_text():
    assert d.cap_text("abc", 10) == "abc"
    out = d.cap_text("x" * 5000)
    assert len(out) == 4000, len(out)
    assert out.endswith("..."), out


test_build_token()
test_cap_text()
print("distribute_external_test: PASS")
```

- [ ] **Step 2: Run test to verify it fails**

Run: `uv run --with 'pyjwt[crypto]' scripts/testflight/tests/distribute_external_test.py`
Expected: FAIL with `ModuleNotFoundError: No module named 'distribute_external'`

- [ ] **Step 3: Write minimal implementation**

Create `scripts/testflight/distribute_external.py`:

```python
#!/usr/bin/env python3
"""Distribute the just-uploaded iOS build to a TestFlight external group.

Flow (App Store Connect API, raw REST):
  1. Poll for the build (by app + version) until processingState == VALID.
  2. Set "What to Test" (betaBuildLocalizations, locale=ja) from commit subjects.
  3. Add the build to the external beta group.
  4. Submit the build for beta app review.

Configuration via environment variables:
  ASC_KEY_ID        App Store Connect API Key ID (JWT kid)
  ASC_ISSUER_ID     Issuer ID (JWT iss)
  ASC_KEY_PATH      Path to the .p8 private key
  ASC_APP_ID        App Store Connect app id (e.g. 6447546703)
  ASC_BUILD_VERSION Build number to locate (CFBundleVersion, e.g. run_number)
  ASC_BETA_GROUP_ID External beta group id
  ASC_LOCALE        Locale for whatsNew (default: ja)

Run with: uv run --with 'pyjwt[crypto]' scripts/testflight/distribute_external.py
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
import time
import urllib.error
import urllib.request

import jwt  # PyJWT (provided via `uv run --with 'pyjwt[crypto]'`)

API_BASE = "https://api.appstoreconnect.apple.com"
WHATSNEW_MAX_LEN = 4000
POLL_INTERVAL_SEC = 30
POLL_TIMEOUT_SEC = 30 * 60


def build_token(key_id: str, issuer_id: str, private_key: str) -> str:
    now = int(time.time())
    payload = {
        "iss": issuer_id,
        "iat": now,
        "exp": now + 19 * 60,  # < 20 minutes (ASC hard limit)
        "aud": "appstoreconnect-v1",
    }
    headers = {"kid": key_id, "typ": "JWT"}
    return jwt.encode(payload, private_key, algorithm="ES256", headers=headers)


def cap_text(text: str, max_len: int = WHATSNEW_MAX_LEN) -> str:
    if len(text) > max_len:
        return text[: max_len - 3] + "..."
    return text


def build_whatsnew_from_git() -> str:
    last_tag = subprocess.run(
        ["git", "describe", "--tags", "--abbrev=0"],
        check=True, capture_output=True, text=True,
    ).stdout.strip()
    log = subprocess.run(
        ["git", "log", f"{last_tag}..HEAD", "--pretty=format:- %s"],
        check=True, capture_output=True, text=True,
    ).stdout.strip()
    return cap_text(log) if log else "- (no changes)"


class Asc:
    def __init__(self, key_id: str, issuer_id: str, key_path: str) -> None:
        self._key_id = key_id
        self._issuer_id = issuer_id
        with open(key_path, encoding="utf-8") as f:
            self._private_key = f.read()

    def _token(self) -> str:
        return build_token(self._key_id, self._issuer_id, self._private_key)

    def request(self, method: str, path: str, body: dict | None = None):
        url = path if path.startswith("http") else API_BASE + path
        data = json.dumps(body).encode() if body is not None else None
        req = urllib.request.Request(url, data=data, method=method)
        req.add_header("Authorization", f"Bearer {self._token()}")
        if data is not None:
            req.add_header("Content-Type", "application/json")
        try:
            with urllib.request.urlopen(req) as resp:
                raw = resp.read()
                return resp.status, (json.loads(raw) if raw else {})
        except urllib.error.HTTPError as e:
            raw = e.read().decode(errors="replace")
            try:
                return e.code, json.loads(raw)
            except json.JSONDecodeError:
                return e.code, {"raw": raw}

    def find_build(self, app_id: str, version: str):
        status, payload = self.request(
            "GET",
            f"/v1/builds?filter[app]={app_id}&filter[version]={version}&limit=1",
        )
        if status != 200:
            raise RuntimeError(f"find_build failed: {status} {payload}")
        data = payload.get("data") or []
        return data[0] if data else None

    def get_ja_localization_id(self, build_id: str, locale: str):
        status, payload = self.request(
            "GET", f"/v1/builds/{build_id}/betaBuildLocalizations"
        )
        if status != 200:
            raise RuntimeError(f"list localizations failed: {status} {payload}")
        for loc in payload.get("data") or []:
            if (loc.get("attributes") or {}).get("locale") == locale:
                return loc["id"]
        return None

    def set_whatsnew(self, build_id: str, locale: str, whats_new: str) -> None:
        loc_id = self.get_ja_localization_id(build_id, locale)
        if loc_id:
            status, payload = self.request(
                "PATCH",
                f"/v1/betaBuildLocalizations/{loc_id}",
                {
                    "data": {
                        "type": "betaBuildLocalizations",
                        "id": loc_id,
                        "attributes": {"whatsNew": whats_new},
                    }
                },
            )
        else:
            status, payload = self.request(
                "POST",
                "/v1/betaBuildLocalizations",
                {
                    "data": {
                        "type": "betaBuildLocalizations",
                        "attributes": {"whatsNew": whats_new, "locale": locale},
                        "relationships": {
                            "build": {"data": {"type": "builds", "id": build_id}}
                        },
                    }
                },
            )
        if status not in (200, 201):
            raise RuntimeError(f"set_whatsnew failed: {status} {payload}")

    def add_to_group(self, group_id: str, build_id: str) -> None:
        status, payload = self.request(
            "POST",
            f"/v1/betaGroups/{group_id}/relationships/builds",
            {"data": [{"type": "builds", "id": build_id}]},
        )
        if status not in (200, 204):
            raise RuntimeError(f"add_to_group failed: {status} {payload}")

    def submit_review(self, build_id: str) -> None:
        status, payload = self.request(
            "POST",
            "/v1/betaAppReviewSubmissions",
            {
                "data": {
                    "type": "betaAppReviewSubmissions",
                    "relationships": {
                        "build": {"data": {"type": "builds", "id": build_id}}
                    },
                }
            },
        )
        # 409 = already submitted/approved for this build -> non-fatal.
        if status not in (200, 201, 409):
            raise RuntimeError(f"submit_review failed: {status} {payload}")
        if status == 409:
            print("beta review already submitted/approved; skipping", flush=True)


def poll_build(asc: Asc, app_id: str, version: str):
    deadline = time.time() + POLL_TIMEOUT_SEC
    while True:
        build = asc.find_build(app_id, version)
        state = (build or {}).get("attributes", {}).get("processingState")
        print(f"build version={version} state={state}", flush=True)
        if build and state == "VALID":
            return build
        if state in ("INVALID", "FAILED"):
            raise RuntimeError(f"build processing failed: state={state}")
        if time.time() >= deadline:
            raise RuntimeError(f"timed out waiting for build (last state={state})")
        time.sleep(POLL_INTERVAL_SEC)


def main() -> int:
    key_id = os.environ["ASC_KEY_ID"]
    issuer_id = os.environ["ASC_ISSUER_ID"]
    key_path = os.environ["ASC_KEY_PATH"]
    app_id = os.environ["ASC_APP_ID"]
    version = os.environ["ASC_BUILD_VERSION"]
    group_id = os.environ["ASC_BETA_GROUP_ID"]
    locale = os.environ.get("ASC_LOCALE", "ja")

    asc = Asc(key_id, issuer_id, key_path)

    build = poll_build(asc, app_id, version)
    build_id = build["id"]
    print(f"resolved build id={build_id}", flush=True)

    whats_new = build_whatsnew_from_git()
    print(f"whatsNew ({len(whats_new)} chars):\n{whats_new}", flush=True)
    asc.set_whatsnew(build_id, locale, whats_new)
    print("whatsNew set", flush=True)

    asc.add_to_group(group_id, build_id)
    print(f"added build to external group {group_id}", flush=True)

    asc.submit_review(build_id)
    print("submitted for beta app review", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
```

- [ ] **Step 4: Run test to verify it passes**

Run: `uv run --with 'pyjwt[crypto]' scripts/testflight/tests/distribute_external_test.py`
Expected: `distribute_external_test: PASS`

- [ ] **Step 5: Verify git-driven whatsNew generation against the real repo**

Run:
```bash
uv run --with 'pyjwt[crypto]' python -c "import sys; sys.path.insert(0,'scripts/testflight'); import distribute_external as d; t=d.build_whatsnew_from_git(); assert t and len(t)<=4000, len(t); print('whatsnew ok, len=', len(t))"
```
Expected: `whatsnew ok, len= <N>`（N は 1〜4000、空でないこと）

- [ ] **Step 6: Syntax-check the module**

Run: `python3 -m py_compile scripts/testflight/distribute_external.py && echo OK`
Expected: `OK`

- [ ] **Step 7: Commit**

```bash
git add scripts/testflight/distribute_external.py scripts/testflight/tests/distribute_external_test.py
git commit -m "feat(ci): TestFlight外部配布のASC APIオーケストレーター追加"
```

---

## Task 2: deploy-app.yaml への組み込み

**Files:**
- Modify: `.github/workflows/deploy-app.yaml`

- [ ] **Step 1: `workflow_dispatch` に `external` input を追加**

`.github/workflows/deploy-app.yaml` の `on.workflow_dispatch.inputs`（`android` input の直後、現状 L14-18）に追記:

```yaml
      android:
        description: "Build Android app"
        required: false
        default: true
        type: boolean
      external:
        description: "Distribute iOS build to TestFlight external group"
        required: false
        default: false
        type: boolean
```

- [ ] **Step 2: `define-matrix` に output `deploy-ios-external` を追加**

`define-matrix.outputs`（現状 L35-37）に追記:

```yaml
    outputs:
      deploy-ios: ${{ steps.define-environment-matrix.outputs.deploy-ios }}
      deploy-android: ${{ steps.define-environment-matrix.outputs.deploy-android }}
      deploy-ios-external: ${{ steps.define-environment-matrix.outputs.deploy-ios-external }}
```

- [ ] **Step 3: `define-environment-matrix` ステップで `[external]` を判定して出力**

`Decide which app to deploy` ステップ（現状 L39-62）を以下に置き換える。コミットメッセージはインジェクション回避のため `env` 経由で渡す:

```yaml
      - name: Decide which app to deploy
        id: define-environment-matrix
        env:
          COMMITS_JSON: ${{ toJSON(github.event.commits) }}
        run: |
          platforms=()
          external="false"
          if [ "${{ github.event_name }}" = "workflow_dispatch" ]; then
            if [ "${{ inputs.ios }}" = "true" ]; then
              platforms+=("ios")
            fi
            if [ "${{ inputs.android }}" = "true" ]; then
              platforms+=("android")
            fi
            if [ "${{ inputs.external }}" = "true" ]; then
              external="true"
            fi
          elif [ "${{ github.event_name }}" = "push" ]; then
              # [release only] タグがない場合は全プラットフォームをデプロイ
              echo "commit message does not contain [release only platform], deploy all platforms"
              platforms+=("ios" "android")
              # push に含まれる全コミットのメッセージに [external] があれば外部配布
              if printf '%s' "$COMMITS_JSON" | grep -qF '[external]'; then
                external="true"
              fi
          else
            echo "Unknown event name: ${{ github.event_name }}"
            exit 1
          fi

          echo "デプロイするプラットフォーム: ${platforms[*]}"
          for platform in "${platforms[@]}"; do
            echo "deploy-${platform}=true" >> "$GITHUB_OUTPUT"
          done
          echo "外部配布(external): ${external}"
          echo "deploy-ios-external=${external}" >> "$GITHUB_OUTPUT"
```

- [ ] **Step 4: `build-ios` の `timeout-minutes` を 60 に、mise に `uv` を追加**

`build-ios` の `timeout-minutes: 30`（現状 L71）を変更:

```yaml
    timeout-minutes: 60
```

`build-ios` の mise install ステップ（現状 L89-92）の install_args に `uv` を追加:

```yaml
      - name: Install Mise dependencies
        uses: jdx/mise-action@dba19683ed58901619b14f395a24841710cb4925 # v4.1.0
        with:
          install_args: "flutter xcbeautify uv"
```

- [ ] **Step 5: 外部配布ステップを追加**

`build-ios` ジョブの末尾、`Upload Ipa to App Store Connect` ステップ（現状 L259-266）の**直後**に追加:

```yaml
      - name: Distribute to TestFlight external group
        if: ${{ needs.define-matrix.outputs.deploy-ios-external == 'true' }}
        run: |
          export ASC_KEY_ID="$APP_STORE_CONNECT_API_KEY_ID"
          export ASC_ISSUER_ID="$APP_STORE_CONNECT_API_ISSUER_ID"
          export ASC_KEY_PATH="$HOME/.private_keys/AuthKey_${APP_STORE_CONNECT_API_KEY_ID}.p8"
          export ASC_APP_ID="6447546703"
          export ASC_BUILD_VERSION="${{ github.run_number }}"
          export ASC_BETA_GROUP_ID="bd75f066-fd92-4175-b2d6-f34952737557"
          export ASC_LOCALE="ja"
          uv run --with 'pyjwt[crypto]' scripts/testflight/distribute_external.py
```

注: `APP_STORE_CONNECT_API_KEY_ID` / `_ISSUER_ID` は mise env 経由で `$GITHUB_ENV` に展開済み（`Set environment variables` ステップ）。`.p8` は `Extract App Store Connect API Key` ステップで `$HOME/.private_keys/` に展開済み。`build-ios` は `fetch-depth: 0` で checkout 済みのため `git describe`/`git log` が機能する。

- [ ] **Step 6: actionlint で検証**

Run: `mise exec -- actionlint .github/workflows/deploy-app.yaml && echo OK`
（`actionlint` が mise 管理外の場合は `actionlint .github/workflows/deploy-app.yaml`）
Expected: 出力なしで終了し `OK`。エラーがあれば該当箇所を修正して再実行。

- [ ] **Step 7: Commit**

```bash
git add .github/workflows/deploy-app.yaml
git commit -m "feat(ci): [external]コミットでTestFlight外部グループ自動配布"
```

---

## Task 3: 統合動作確認（実 CI）

ASC API へのリアル通信を伴うため、ローカル単体テストでは検証不能。マージ後に実 CI で確認する。

- [ ] **Step 1: `[external]` 無し push の回帰確認**

`develop` への通常 push（コミットメッセージに `[external]` を含まない）で `Deploy App` を実行し、`Distribute to TestFlight external group` ステップが **skipped** になることを確認する。

- [ ] **Step 2: `[external]` 有り push の確認**

コミットメッセージに `[external]` を含む push（または `workflow_dispatch` で `external=true`）を実行し、以下を確認する:
- `Distribute to TestFlight external group` ステップが実行される
- ステップログに `state=VALID` → `whatsNew set` → `added build to external group` → `submitted for beta app review` が出る
- App Store Connect 上で、該当ビルドが外部グループ `bd75f066-...` に追加され、What to Test がコミット件名一覧で埋まっていること

- [ ] **Step 3: タイムアウト/異常系の確認**

処理完了に時間がかかった場合でも `timeout-minutes: 60` 内に収まること、処理失敗時に `build processing failed` で fail することを（ログで）確認する。

---

## Self-Review メモ

- spec §1（`[external]` ゲート）→ Task 2 Step 1-3。
- spec §2（処理完了待ち・JWT）→ Task 1（`build_token` / `poll_build`）。
- spec §3（What to Test 生成・設定）→ Task 1（`build_whatsnew_from_git` / `set_whatsnew`）。
- spec §4（外部グループ追加・審査提出）→ Task 1（`add_to_group` / `submit_review`）。
- spec §5（ランナー・タイムアウト・uv）→ Task 2 Step 4。
- 型/名称整合: `build_token` / `cap_text` / `Asc` のメソッド名はテスト・本体・呼び出し（main）で一致。
