import assert from 'node:assert/strict';
import { createHash, generateKeyPairSync, sign } from 'node:crypto';
import test from 'node:test';

import { verifyR2Distribution } from './verify_r2_distribution.mjs';

function fixture() {
  const { privateKey, publicKey } = generateKeyPairSync('ed25519');
  const archive = Buffer.from('pack zip fixture');
  const archiveSha256 = createHash('sha256').update(archive).digest('hex');
  const manifest = Buffer.from(
    `${JSON.stringify({
      schema_version: 1,
      revision: 1,
      latest_version: '1.2.3',
      generated_at: '2026-08-16T00:00:00.000Z',
      packs: [
        {
          version: '1.2.3',
          published_at: '2026-08-16',
          minimum_app_version: '0.0.1',
          archive_path: 'packs/1.2.3/asset-pack-v1.2.3.zip',
          archive_size_bytes: archive.length,
          archive_sha256: archiveSha256,
          localizations: {
            ja: { sections: [{ title: '更新', items: ['更新内容'] }] },
            en: { sections: [{ title: 'Update', items: ['Changes'] }] },
          },
        },
      ],
    }, null, 2)}\n`,
  );
  const signature = sign(null, manifest, privateKey);
  const sidecar = Buffer.from(
    `${JSON.stringify({
      schema_version: 1,
      algorithm: 'Ed25519',
      key_id: 'test-key',
      content_sha256:
        'placeholder',
      signature_base64: signature.toString('base64'),
    })}\n`,
  );
  return { archive, archiveSha256, manifest, publicKey, sidecar };
}

test('accepts a signed manifest and matching immutable archive', () => {
  const value = fixture();
  const sidecar = JSON.parse(value.sidecar);
  sidecar.content_sha256 = createHash('sha256').update(value.manifest).digest('hex');

  assert.doesNotThrow(() =>
    verifyR2Distribution({
      manifestBytes: value.manifest,
      signatureBytes: Buffer.from(`${JSON.stringify(sidecar)}\n`),
      archiveBytes: value.archive,
      expectedVersion: '1.2.3',
      expectedArchiveSha256: value.archiveSha256,
      trustedPublicKeys: { 'test-key': value.publicKey },
    }),
  );
});

test('rejects a manifest whose signature was changed', () => {
  const value = fixture();
  const sidecar = JSON.parse(value.sidecar);
  sidecar.content_sha256 = createHash('sha256').update(value.manifest).digest('hex');
  sidecar.signature_base64 = Buffer.alloc(64).toString('base64');

  assert.throws(
    () =>
      verifyR2Distribution({
        manifestBytes: value.manifest,
        signatureBytes: Buffer.from(JSON.stringify(sidecar)),
        archiveBytes: value.archive,
        expectedVersion: '1.2.3',
        expectedArchiveSha256: value.archiveSha256,
        trustedPublicKeys: { 'test-key': value.publicKey },
      }),
    /signature/i,
  );
});

test('rejects a different archive than the signed manifest names', () => {
  const value = fixture();
  const sidecar = JSON.parse(value.sidecar);
  sidecar.content_sha256 = createHash('sha256').update(value.manifest).digest('hex');

  assert.throws(
    () =>
      verifyR2Distribution({
        manifestBytes: value.manifest,
        signatureBytes: Buffer.from(JSON.stringify(sidecar)),
        archiveBytes: Buffer.from('tampered archive'),
        expectedVersion: '1.2.3',
        expectedArchiveSha256: value.archiveSha256,
        trustedPublicKeys: { 'test-key': value.publicKey },
      }),
    /archive sha256/i,
  );
});
