#!/usr/bin/env node

import { createHash, createPublicKey, verify } from 'node:crypto';
import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';

const semVerPattern = /^\d+\.\d+\.\d+$/;
const sha256Pattern = /^[0-9a-f]{64}$/;
const keyIdPattern = /^[a-z0-9][a-z0-9-]{0,63}$/;

function fail(message) {
  throw new Error(`R2 distribution verification failed: ${message}`);
}

function parseObject(bytes, label) {
  let value;
  try {
    value = JSON.parse(bytes.toString('utf8'));
  } catch {
    fail(`${label} is not valid JSON`);
  }
  if (value === null || Array.isArray(value) || typeof value !== 'object') {
    fail(`${label} must be an object`);
  }
  return value;
}

export function verifyR2Distribution({
  manifestBytes,
  signatureBytes,
  archiveBytes,
  expectedVersion,
  expectedArchiveSha256,
  trustedPublicKeys,
}) {
  if (!semVerPattern.test(expectedVersion)) fail('version is not SemVer');
  if (!sha256Pattern.test(expectedArchiveSha256)) {
    fail('expected archive sha256 is invalid');
  }

  const sidecar = parseObject(signatureBytes, 'manifest.sig');
  if (
    sidecar.schema_version !== 1 ||
    sidecar.algorithm !== 'Ed25519' ||
    typeof sidecar.key_id !== 'string' ||
    !keyIdPattern.test(sidecar.key_id) ||
    typeof sidecar.content_sha256 !== 'string' ||
    !sha256Pattern.test(sidecar.content_sha256) ||
    typeof sidecar.signature_base64 !== 'string'
  ) {
    fail('signature sidecar schema is invalid');
  }
  const contentSha256 = createHash('sha256').update(manifestBytes).digest('hex');
  if (contentSha256 !== sidecar.content_sha256) {
    fail('manifest content sha256 does not match signature sidecar');
  }
  const publicKey = trustedPublicKeys[sidecar.key_id];
  if (publicKey === undefined) fail(`signature key is not trusted: ${sidecar.key_id}`);
  const signature = Buffer.from(sidecar.signature_base64, 'base64');
  if (signature.length !== 64 || !verify(null, manifestBytes, publicKey, signature)) {
    fail('manifest signature is invalid');
  }

  const manifest = parseObject(manifestBytes, 'manifest.json');
  if (
    manifest.schema_version !== 1 ||
    !Number.isInteger(manifest.revision) ||
    manifest.revision < 1 ||
    !Array.isArray(manifest.packs) ||
    manifest.packs.length < 1
  ) {
    fail('distribution manifest schema is invalid');
  }
  const entry = manifest.packs.find((candidate) => candidate?.version === expectedVersion);
  if (entry === undefined) fail(`version ${expectedVersion} is absent from manifest`);
  const expectedPath = `packs/${expectedVersion}/asset-pack-v${expectedVersion}.zip`;
  if (
    entry.archive_path !== expectedPath ||
    entry.archive_sha256 !== expectedArchiveSha256 ||
    !Number.isInteger(entry.archive_size_bytes) ||
    entry.archive_size_bytes < 1
  ) {
    fail(`signed archive metadata is invalid for ${expectedVersion}`);
  }
  const actualArchiveSha256 = createHash('sha256').update(archiveBytes).digest('hex');
  if (actualArchiveSha256 !== entry.archive_sha256) {
    fail('archive sha256 does not match signed manifest');
  }
  if (archiveBytes.length !== entry.archive_size_bytes) {
    fail('archive size does not match signed manifest');
  }
  return entry;
}

function parseArguments(args) {
  const values = new Map();
  for (let index = 0; index < args.length; index += 2) {
    const name = args[index];
    const value = args[index + 1];
    if (name === undefined || value === undefined || !name.startsWith('--')) {
      fail('arguments must be --name value pairs');
    }
    values.set(name, value);
  }
  const required = ['--manifest', '--signature', '--archive', '--version', '--sha256', '--public-key'];
  for (const name of required) {
    if (!values.has(name)) fail(`missing ${name}`);
  }
  return values;
}

function runCli() {
  const args = parseArguments(process.argv.slice(2));
  const keySpec = args.get('--public-key');
  const separator = keySpec.indexOf('=');
  if (separator < 1) fail('--public-key must be key-id=PEM-path');
  const keyId = keySpec.slice(0, separator);
  const keyPath = keySpec.slice(separator + 1);
  verifyR2Distribution({
    manifestBytes: readFileSync(args.get('--manifest')),
    signatureBytes: readFileSync(args.get('--signature')),
    archiveBytes: readFileSync(args.get('--archive')),
    expectedVersion: args.get('--version'),
    expectedArchiveSha256: args.get('--sha256'),
    trustedPublicKeys: { [keyId]: createPublicKey(readFileSync(keyPath)) },
  });
  process.stdout.write(`verify_r2_distribution: OK (version=${args.get('--version')})\n`);
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  try {
    runCli();
  } catch (error) {
    process.stderr.write(`${error instanceof Error ? error.message : String(error)}\n`);
    process.exitCode = 1;
  }
}
