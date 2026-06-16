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
