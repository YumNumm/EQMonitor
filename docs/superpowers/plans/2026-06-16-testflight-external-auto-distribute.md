# TestFlight 外部グループ自動配布 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `develop` への push 等で iOS ビルドを TestFlight にアップロードする際、コミットメッセージに `[external]` が含まれる場合のみ、外部テストグループへ自動配布し、テスト内容（What to Test）をコミット件名から自動生成して設定する。

**Architecture:** ASC API 呼び出しロジックを単体テスト可能な TypeScript スクリプト `scripts/testflight/distribute-external.ts` に集約し、`.github/workflows/deploy-app.yaml` の `build-ios` ジョブに「altool アップロード後」の後続ステップとして組み込む（新ジョブは作らない=案A）。`[external]` 判定は `define-matrix` ジョブの output として算出する。

**Tech Stack:** GitHub Actions / TypeScript / Node（mise `node lts`）/ pnpm / `tsx`（TS 直接実行）/ `jose`（ES256 JWT）/ `vitest`（テスト）/ App Store Connect REST API（Node 組み込み `fetch`）。

設計 spec: `docs/superpowers/specs/2026-06-16-testflight-external-auto-distribute-design.md`

---

## File Structure

`scripts/testflight/` を standalone な pnpm プロジェクトとして新設する（リポジトリ root に package.json は無いため独立構成）。

- Create: `scripts/testflight/package.json` — deps（`jose`）/ devDeps（`tsx` `typescript` `vitest` `@types/node`）/ scripts（`distribute` `test`）。
- Create: `scripts/testflight/tsconfig.json` — TS 設定（ESM, strict）。
- Create: `scripts/testflight/distribute-external.ts` — ASC API オーケストレーター。純粋関数（`buildToken` / `capText` / `buildWhatsNewFromGit`）＋ `AscClient` クラス＋メインフロー（処理完了ポーリング → What to Test 設定 → 外部グループ追加 → ベータ審査提出）。
- Create: `scripts/testflight/distribute-external.test.ts` — 純粋関数の vitest 単体テスト。
- Create: `scripts/testflight/pnpm-lock.yaml` — `pnpm install` 実行で自動生成（手書きしない）。
- Modify: `.github/workflows/deploy-app.yaml` — `define-matrix` に output `deploy-ios-external` を追加 / `workflow_dispatch` に input `external` 追加 / `build-ios` に配布ステップ追加・`timeout-minutes` 30→60・mise install_args に `node pnpm` 追加。

各 ASC API エンドポイント（spec §2-4 参照）:
- `GET /v1/builds?filter[app]={app}&filter[version]={ver}&limit=1`
- `GET /v1/builds/{id}/betaBuildLocalizations`
- `POST /v1/betaBuildLocalizations` / `PATCH /v1/betaBuildLocalizations/{id}`
- `POST /v1/betaGroups/{groupId}/relationships/builds`
- `POST /v1/betaAppReviewSubmissions`

---

## Task 1: pnpm プロジェクトの雛形作成

**Files:**
- Create: `scripts/testflight/package.json`
- Create: `scripts/testflight/tsconfig.json`

- [ ] **Step 1: package.json を作成**

Create `scripts/testflight/package.json`:

```json
{
  "name": "testflight-distribute",
  "version": "0.0.0",
  "private": true,
  "type": "module",
  "scripts": {
    "distribute": "tsx distribute-external.ts",
    "test": "vitest run"
  },
  "dependencies": {
    "jose": "^5.9.6"
  },
  "devDependencies": {
    "@types/node": "^22.10.2",
    "tsx": "^4.19.2",
    "typescript": "^5.7.2",
    "vitest": "^2.1.8"
  }
}
```

- [ ] **Step 2: tsconfig.json を作成**

Create `scripts/testflight/tsconfig.json`:

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "lib": ["ES2022"],
    "types": ["node"],
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["*.ts"]
}
```

- [ ] **Step 3: 依存をインストール（lockfile 生成）**

Run: `pnpm -C scripts/testflight install`
Expected: 正常終了し `scripts/testflight/pnpm-lock.yaml` と `node_modules` が生成される。

- [ ] **Step 4: node_modules を git 管理外にする**

`scripts/testflight/.gitignore` を作成:

```gitignore
node_modules/
```

- [ ] **Step 5: Commit**

```bash
git add scripts/testflight/package.json scripts/testflight/tsconfig.json scripts/testflight/pnpm-lock.yaml scripts/testflight/.gitignore
git commit -m "chore(ci): TestFlight配布スクリプト用pnpmプロジェクト追加"
```

---

## Task 2: ASC オーケストレーター（TypeScript）

**Files:**
- Create: `scripts/testflight/distribute-external.ts`
- Test: `scripts/testflight/distribute-external.test.ts`

- [ ] **Step 1: Write the failing test**

Create `scripts/testflight/distribute-external.test.ts`:

```ts
import { describe, expect, it } from 'vitest'
import { generateKeyPair, exportPKCS8, decodeJwt, decodeProtectedHeader } from 'jose'
import { buildToken, capText } from './distribute-external.ts'

describe('buildToken', () => {
  it('creates an ES256 JWT with the expected header and claims', async () => {
    const { privateKey } = await generateKeyPair('ES256', { extractable: true })
    const pem = await exportPKCS8(privateKey)
    const token = await buildToken('KID123', 'ISS456', pem)

    const header = decodeProtectedHeader(token)
    expect(header.alg).toBe('ES256')
    expect(header.kid).toBe('KID123')

    const payload = decodeJwt(token)
    expect(payload.iss).toBe('ISS456')
    expect(payload.aud).toBe('appstoreconnect-v1')
    expect(payload.exp! - payload.iat!).toBeGreaterThan(0)
    expect(payload.exp! - payload.iat!).toBeLessThanOrEqual(20 * 60)
  })
})

describe('capText', () => {
  it('returns text unchanged when within the limit', () => {
    expect(capText('abc', 10)).toBe('abc')
  })

  it('truncates and appends an ellipsis when over the limit', () => {
    const out = capText('x'.repeat(5000))
    expect(out.length).toBe(4000)
    expect(out.endsWith('...')).toBe(true)
  })
})
```

- [ ] **Step 2: Run test to verify it fails**

Run: `pnpm -C scripts/testflight test`
Expected: FAIL（`distribute-external.ts` から `buildToken`/`capText` を解決できずエラー）

- [ ] **Step 3: Write minimal implementation**

Create `scripts/testflight/distribute-external.ts`:

```ts
/**
 * Distribute the just-uploaded iOS build to a TestFlight external group.
 *
 * Flow (App Store Connect API, raw REST):
 *   1. Poll for the build (by app + version) until processingState === 'VALID'.
 *   2. Set "What to Test" (betaBuildLocalizations, locale=ja) from commit subjects.
 *   3. Add the build to the external beta group.
 *   4. Submit the build for beta app review.
 *
 * Configuration via environment variables:
 *   ASC_KEY_ID        App Store Connect API Key ID (JWT kid)
 *   ASC_ISSUER_ID     Issuer ID (JWT iss)
 *   ASC_KEY_PATH      Path to the .p8 private key
 *   ASC_APP_ID        App Store Connect app id (e.g. 6447546703)
 *   ASC_BUILD_VERSION Build number to locate (CFBundleVersion, e.g. run_number)
 *   ASC_BETA_GROUP_ID External beta group id
 *   ASC_LOCALE        Locale for whatsNew (default: ja)
 *
 * Run with: pnpm -C scripts/testflight run distribute
 */
import { readFileSync } from 'node:fs'
import { execFileSync } from 'node:child_process'
import { importPKCS8, SignJWT } from 'jose'

const API_BASE = 'https://api.appstoreconnect.apple.com'
const WHATSNEW_MAX_LEN = 4000
const POLL_INTERVAL_MS = 30_000
const POLL_TIMEOUT_MS = 30 * 60_000

export async function buildToken(
  keyId: string,
  issuerId: string,
  privateKeyPem: string,
): Promise<string> {
  const key = await importPKCS8(privateKeyPem, 'ES256')
  const now = Math.floor(Date.now() / 1000)
  return await new SignJWT({})
    .setProtectedHeader({ alg: 'ES256', kid: keyId, typ: 'JWT' })
    .setIssuer(issuerId)
    .setIssuedAt(now)
    .setExpirationTime(now + 19 * 60) // < 20 minutes (ASC hard limit)
    .setAudience('appstoreconnect-v1')
    .sign(key)
}

export function capText(text: string, maxLen = WHATSNEW_MAX_LEN): string {
  if (text.length > maxLen) {
    return text.slice(0, maxLen - 3) + '...'
  }
  return text
}

export function buildWhatsNewFromGit(): string {
  const lastTag = execFileSync('git', ['describe', '--tags', '--abbrev=0'], {
    encoding: 'utf8',
  }).trim()
  const log = execFileSync(
    'git',
    ['log', `${lastTag}..HEAD`, '--pretty=format:- %s'],
    { encoding: 'utf8' },
  ).trim()
  return log ? capText(log) : '- (no changes)'
}

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms))

interface AscResponse {
  status: number
  body: any
}

class AscClient {
  private readonly keyId: string
  private readonly issuerId: string
  private readonly privateKeyPem: string

  constructor(keyId: string, issuerId: string, keyPath: string) {
    this.keyId = keyId
    this.issuerId = issuerId
    this.privateKeyPem = readFileSync(keyPath, 'utf8')
  }

  private async request(
    method: string,
    path: string,
    body?: unknown,
  ): Promise<AscResponse> {
    const url = path.startsWith('http') ? path : API_BASE + path
    const token = await buildToken(this.keyId, this.issuerId, this.privateKeyPem)
    const headers: Record<string, string> = {
      Authorization: `Bearer ${token}`,
    }
    if (body !== undefined) {
      headers['Content-Type'] = 'application/json'
    }
    const res = await fetch(url, {
      method,
      headers,
      body: body !== undefined ? JSON.stringify(body) : undefined,
    })
    const text = await res.text()
    let parsed: any = {}
    if (text) {
      try {
        parsed = JSON.parse(text)
      } catch {
        parsed = { raw: text }
      }
    }
    return { status: res.status, body: parsed }
  }

  async findBuild(appId: string, version: string): Promise<any | null> {
    const { status, body } = await this.request(
      'GET',
      `/v1/builds?filter[app]=${appId}&filter[version]=${version}&limit=1`,
    )
    if (status !== 200) {
      throw new Error(`findBuild failed: ${status} ${JSON.stringify(body)}`)
    }
    const data = body.data ?? []
    return data.length > 0 ? data[0] : null
  }

  async getJaLocalizationId(
    buildId: string,
    locale: string,
  ): Promise<string | null> {
    const { status, body } = await this.request(
      'GET',
      `/v1/builds/${buildId}/betaBuildLocalizations`,
    )
    if (status !== 200) {
      throw new Error(
        `list localizations failed: ${status} ${JSON.stringify(body)}`,
      )
    }
    for (const loc of body.data ?? []) {
      if (loc.attributes?.locale === locale) {
        return loc.id
      }
    }
    return null
  }

  async setWhatsNew(
    buildId: string,
    locale: string,
    whatsNew: string,
  ): Promise<void> {
    const locId = await this.getJaLocalizationId(buildId, locale)
    const res = locId
      ? await this.request('PATCH', `/v1/betaBuildLocalizations/${locId}`, {
          data: {
            type: 'betaBuildLocalizations',
            id: locId,
            attributes: { whatsNew },
          },
        })
      : await this.request('POST', '/v1/betaBuildLocalizations', {
          data: {
            type: 'betaBuildLocalizations',
            attributes: { whatsNew, locale },
            relationships: {
              build: { data: { type: 'builds', id: buildId } },
            },
          },
        })
    if (res.status !== 200 && res.status !== 201) {
      throw new Error(
        `setWhatsNew failed: ${res.status} ${JSON.stringify(res.body)}`,
      )
    }
  }

  async addToGroup(groupId: string, buildId: string): Promise<void> {
    const { status, body } = await this.request(
      'POST',
      `/v1/betaGroups/${groupId}/relationships/builds`,
      { data: [{ type: 'builds', id: buildId }] },
    )
    if (status !== 200 && status !== 204) {
      throw new Error(`addToGroup failed: ${status} ${JSON.stringify(body)}`)
    }
  }

  async submitReview(buildId: string): Promise<void> {
    const { status, body } = await this.request(
      'POST',
      '/v1/betaAppReviewSubmissions',
      {
        data: {
          type: 'betaAppReviewSubmissions',
          relationships: {
            build: { data: { type: 'builds', id: buildId } },
          },
        },
      },
    )
    // 409 = already submitted/approved for this build -> non-fatal.
    if (status !== 200 && status !== 201 && status !== 409) {
      throw new Error(`submitReview failed: ${status} ${JSON.stringify(body)}`)
    }
    if (status === 409) {
      console.log('beta review already submitted/approved; skipping')
    }
  }
}

async function pollBuild(
  asc: AscClient,
  appId: string,
  version: string,
): Promise<any> {
  const deadline = Date.now() + POLL_TIMEOUT_MS
  for (;;) {
    const build = await asc.findBuild(appId, version)
    const state = build?.attributes?.processingState
    console.log(`build version=${version} state=${state}`)
    if (build && state === 'VALID') {
      return build
    }
    if (state === 'INVALID' || state === 'FAILED') {
      throw new Error(`build processing failed: state=${state}`)
    }
    if (Date.now() >= deadline) {
      throw new Error(`timed out waiting for build (last state=${state})`)
    }
    await sleep(POLL_INTERVAL_MS)
  }
}

function requireEnv(name: string): string {
  const v = process.env[name]
  if (!v) {
    throw new Error(`missing required env: ${name}`)
  }
  return v
}

async function main(): Promise<void> {
  const keyId = requireEnv('ASC_KEY_ID')
  const issuerId = requireEnv('ASC_ISSUER_ID')
  const keyPath = requireEnv('ASC_KEY_PATH')
  const appId = requireEnv('ASC_APP_ID')
  const version = requireEnv('ASC_BUILD_VERSION')
  const groupId = requireEnv('ASC_BETA_GROUP_ID')
  const locale = process.env.ASC_LOCALE ?? 'ja'

  const asc = new AscClient(keyId, issuerId, keyPath)

  const build = await pollBuild(asc, appId, version)
  const buildId = build.id as string
  console.log(`resolved build id=${buildId}`)

  const whatsNew = buildWhatsNewFromGit()
  console.log(`whatsNew (${whatsNew.length} chars):\n${whatsNew}`)
  await asc.setWhatsNew(buildId, locale, whatsNew)
  console.log('whatsNew set')

  await asc.addToGroup(groupId, buildId)
  console.log(`added build to external group ${groupId}`)

  await asc.submitReview(buildId)
  console.log('submitted for beta app review')
}

// Only run main when executed directly (not when imported by tests).
if (process.argv[1] && process.argv[1].endsWith('distribute-external.ts')) {
  main().catch((err) => {
    console.error(err)
    process.exit(1)
  })
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `pnpm -C scripts/testflight test`
Expected: PASS（`buildToken` 1件 + `capText` 2件）

- [ ] **Step 5: 型チェック**

Run: `pnpm -C scripts/testflight exec tsc --noEmit`
Expected: 出力なしで終了（型エラーなし）。

- [ ] **Step 6: git 連携の whatsNew 生成を実リポジトリで確認**

Run:
```bash
pnpm -C scripts/testflight exec tsx -e "import('./distribute-external.ts').then(m => { const t = m.buildWhatsNewFromGit(); if (!t || t.length > 4000) throw new Error('bad len ' + t.length); console.log('whatsnew ok, len=', t.length) })"
```
Expected: `whatsnew ok, len= <N>`（N は 1〜4000、空でないこと）

- [ ] **Step 7: Commit**

```bash
git add scripts/testflight/distribute-external.ts scripts/testflight/distribute-external.test.ts
git commit -m "feat(ci): TestFlight外部配布のASC APIオーケストレーター追加"
```

---

## Task 3: deploy-app.yaml への組み込み

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

- [ ] **Step 4: `build-ios` の `timeout-minutes` を 60 に、mise に `node pnpm` を追加**

`build-ios` の `timeout-minutes: 30`（現状 L71）を変更:

```yaml
    timeout-minutes: 60
```

`build-ios` の mise install ステップ（現状 L89-92）の install_args に `node pnpm` を追加:

```yaml
      - name: Install Mise dependencies
        uses: jdx/mise-action@dba19683ed58901619b14f395a24841710cb4925 # v4.1.0
        with:
          install_args: "flutter xcbeautify node pnpm"
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
          pnpm -C scripts/testflight install --frozen-lockfile
          pnpm -C scripts/testflight run distribute
```

注: `APP_STORE_CONNECT_API_KEY_ID` / `_ISSUER_ID` は mise env 経由で `$GITHUB_ENV` に展開済み（`Set environment variables` ステップ）。`.p8` は `Extract App Store Connect API Key` ステップで `$HOME/.private_keys/` に展開済み。`build-ios` は `fetch-depth: 0` で checkout 済みのため `git describe`/`git log` が機能する。

- [ ] **Step 6: actionlint で検証**

Run: `mise exec -- actionlint .github/workflows/deploy-app.yaml && echo OK`
Expected: 出力なしで終了し `OK`。エラーがあれば該当箇所を修正して再実行。

- [ ] **Step 7: Commit**

```bash
git add .github/workflows/deploy-app.yaml
git commit -m "feat(ci): [external]コミットでTestFlight外部グループ自動配布"
```

---

## Task 4: 統合動作確認（実 CI）

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

- spec §1（`[external]` ゲート）→ Task 3 Step 1-3。
- spec §2（処理完了待ち・JWT・Node/jose/tsx）→ Task 1（雛形）＋ Task 2（`buildToken` / `pollBuild`）。
- spec §3（What to Test 生成・設定）→ Task 2（`buildWhatsNewFromGit` / `setWhatsNew`）。
- spec §4（外部グループ追加・審査提出）→ Task 2（`addToGroup` / `submitReview`）。
- spec §5（ランナー・タイムアウト・node/pnpm・frozen-lockfile）→ Task 1 Step 3/5 ＋ Task 3 Step 4-5。
- 型/名称整合: `buildToken` / `capText` / `buildWhatsNewFromGit` / `AscClient`（`findBuild`/`getJaLocalizationId`/`setWhatsNew`/`addToGroup`/`submitReview`）はテスト・本体・呼び出し（main）で一致。

## 実装後の補足（重要）

Task 3 の実装時に判明: アップロード（`xcrun altool`）と ASC キー展開は `build-ios` ではなく **`deploy-ios` ジョブ**にあった。したがって本プランの Task 3 Step 4-5 で `build-ios` と記した編集対象はすべて **`deploy-ios` ジョブ**に適用した（timeout 10→60、`install_args` への `node pnpm` 追加、`needs` への `define-matrix` 追加、Distribute ステップ配置）。`build-ios` は変更していない。`deploy-ios` は元から `fetch-depth: 0`。
