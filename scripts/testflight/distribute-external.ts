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
