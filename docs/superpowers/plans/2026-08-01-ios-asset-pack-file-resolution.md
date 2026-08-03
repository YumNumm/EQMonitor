# iOS Asset Pack File Resolution Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** iOS Asset Packのmanifestと各assetをBackground Assets APIで個別解決し、物理root推定による全6ファイルの誤検知と通常読込失敗を解消する。

**Architecture:** `assets_util` にrelative path単位の `resolvePackFile` APIを追加し、iOSは毎回 `AssetPackManager.url(for:)`を呼ぶ。App repositoryはrootではなくこのAPIに依存し、既存のsize・SHA-256検証を維持する。診断JSON v2に個別URLとnative errorを追加し、v1 decodeも維持する。

**Tech Stack:** Swift 6.2+, BackgroundAssets, Objective-C interop, ffigen, Dart 3, Flutter 3.44, Riverpod 3, flutter_test, Swift Testing

## Global Constraints

- iOSでmanifest URLの親をpack rootとしてasset読込に使わない。
- Android Play Asset DeliveryとmacOS bundle assetsの動作を維持する。
- `resolvePackRoot()` は互換性のため残す。
- bundled data、固定値、ランダム値へのフォールバックを追加しない。
- URLをプロセス寿命を超えて永続化しない。
- Flutter / Dartコマンドは `mise exec --` 経由で実行する。
- `backend` submoduleのユーザー差分はstageしない。

---

### Task 1: Swiftの個別ファイル解決と診断v2

**Files:**
- Modify: `packages/assets_util/ios/assets_util/Sources/assets_util/EQMAssetsUtil.swift`
- Modify: `packages/assets_util/ios/assets_util/Tests/assets_utilTests/EQMAssetPackDiagnosticsTests.swift`

**Interfaces:**
- Produces: `resolveAssetPackFile(relativePath: String, packIdentifier: String) -> String?`
- Produces: `AssetPackDiagnosticsInspector.inspect(manifestURL:resolveAssetURL:)`
- Produces: diagnostics schema v2 file fields `resolved_url` and `native_error`

- [ ] **Step 1: Write a failing Swift test for a non-sibling resolved asset**

Create separate `manifestRoot` and `assetRoot`. Pass a resolver closure that maps
`map/all.pmtiles` to `assetRoot/map/all.pmtiles`, then assert status `.ready`,
the resolved URL, and actual size. The old `packRoot.appendingPathComponent` implementation
must report `.assetMissing`, proving RED.

- [ ] **Step 2: Run the Swift test and verify RED**

Run:
`CLANG_MODULE_CACHE_PATH=/tmp/eqmonitor-clang-cache SWIFTPM_MODULECACHE_OVERRIDE=/tmp/eqmonitor-swiftpm-cache MISE_AUTO_INSTALL=0 mise exec -- swift test --disable-sandbox --package-path packages/assets_util/ios/assets_util`

Expected: the non-sibling test fails because the inspector cannot consume an individual resolver.

- [ ] **Step 3: Implement resolver-driven inspection**

Change the diagnostic model to preserve evidence:

```swift
struct AssetPackFileDiagnostic {
  let path: String
  let resolvedURL: URL?
  let status: AssetPackFileDiagnosticStatus
  let exists: Bool
  let expectedSizeBytes: Int?
  let actualSizeBytes: Int?
  let nativeError: AssetPackNativeError?
}
```

For every manifest entry call `resolveAssetURL(relativePath)`. Continue through all entries
after resolution errors. Encode `schema_version: 2`, `resolved_url`, and per-file
`native_error`. On iOS inject `AssetPackManager.shared.url(for: FilePath(relativePath))`.

- [ ] **Step 4: Add the Objective-C file resolver**

Implement `resolveAssetPackFile(relativePath:packIdentifier:)`. iOS calls `url(for:)` and
returns a path only when it is an existing regular file. macOS resolves under the bundled
platform directory. Unsupported platforms return `nil`; no fallback is added.

- [ ] **Step 5: Run Swift tests and verify GREEN**

Expected: invalid manifest, missing, mismatch, ready, stable keys, and non-sibling resolution
tests all pass.

### Task 2: Dart API・binding・diagnostics v2

**Files:**
- Modify: `packages/assets_util/lib/assets_util.dart`
- Modify: `packages/assets_util/lib/src/assets_util_ios.dart`
- Modify: `packages/assets_util/lib/src/asset_pack_diagnostics.dart`
- Modify generated: `packages/assets_util/lib/src/ios/eqm_assets_util.dart`
- Modify generated: `packages/assets_util/lib/src/ios/eqm_assets_util.dart.m`
- Modify: `packages/assets_util/test/asset_pack_diagnostics_test.dart`

**Interfaces:**
- Produces: `typedef ResolveAssetPackFile = Future<String> Function(String relativePath)`
- Produces: `AssetsUtil.resolvePackFile({required String relativePath})`
- Extends: `AssetPackFileDiagnostic.resolvedUrl` and `.nativeError`

- [ ] **Step 1: Write failing Dart tests**

Add literal schema-v2 JSON with `resolved_url` and per-file `native_error`; assert both decode.
Keep a schema-v1 fixture and assert the new fields are `null`. Add platform dispatch tests where
possible without invoking native code.

- [ ] **Step 2: Run package tests and verify RED**

Run: `MISE_AUTO_INSTALL=0 mise exec -- flutter test packages/assets_util/test/asset_pack_diagnostics_test.dart`

Expected: compile or assertion failure because v2 fields/API do not exist.

- [ ] **Step 3: Implement compatible decoding and public API**

Accept diagnostics schema versions 1 and 2 only. For v1 set `resolvedUrl` and per-file
`nativeError` to `null`; for v2 strictly validate their nullable types. Implement
`AssetsUtil.resolvePackFile` so iOS/macOS use the Apple bridge and Android combines the verified
pack root with the relative path and verifies a regular file exists.

- [ ] **Step 4: Regenerate bindings from the Swift header**

Use `packages/assets_util/tool/generate_ios_bindings.dart` or the native hook. Confirm the
generated selector is `resolveAssetPackFileWithRelativePath:packIdentifier:`; do not hand-edit
the selector or Objective-C block glue.

- [ ] **Step 5: Run package tests and targeted analysis**

Run the diagnostics test and:
`MISE_AUTO_INSTALL=0 mise exec -- dart analyze packages/assets_util/lib packages/assets_util/test packages/assets_util/hook/build.dart packages/assets_util/tool/generate_ios_bindings.dart`

Expected: tests pass and analysis reports no issues.

### Task 3: App repositoryをroot依存から個別resolverへ移行

**Files:**
- Modify: `app/lib/feature/asset_pack/data/repository/asset_pack_repository.dart`
- Modify: `app/test/feature/asset_pack/asset_pack_repository_test.dart`
- Modify: `app/test/feature/asset_pack/asset_pack_manifest_provider_test.dart`
- Modify: `app/test/feature/map/base_map_pmtiles_repository_test.dart`
- Modify: `app/test/feature/parameter/parameter_repository_test.dart`

**Interfaces:**
- Consumes: `AssetsUtil.resolvePackFile({required String relativePath})`
- Produces constructor: `AssetPackRepository({ResolveAssetPackFile? resolvePackFile})`

- [ ] **Step 1: Write the non-sibling repository regression test**

Store `manifest.json` and `parameters/jma_code_table.json` in different temporary directories.
Inject a resolver that returns the corresponding file for each relative path. Assert
`readManifest()` and `resolveAsset(jmaCodeTable)` succeed and integrity checks still run.

- [ ] **Step 2: Run the repository test and verify RED**

Run from `app/`:
`MISE_AUTO_INSTALL=0 mise exec -- flutter test test/feature/asset_pack/asset_pack_repository_test.dart`

Expected: compile failure because the repository only accepts `resolvePackRoot`.

- [ ] **Step 3: Implement the resolver-based repository**

Replace the root dependency with `ResolveAssetPackFile`. Resolve `manifest.json` independently
for every manifest read and resolve `item.path` independently for every asset access. Preserve
missing/empty/size/SHA-256 error messages and once-per-session hash caching.

- [ ] **Step 4: Migrate existing tests without weakening assertions**

Replace temp-root injections with a test resolver that maps relative paths under the same temp
directory. Keep every existing malformed manifest, missing file, size, SHA-256, and provider
test. Do not replace integrity assertions with mocks.

- [ ] **Step 5: Run affected app tests and targeted analysis**

Run repository, manifest provider, base map, parameter, and Asset Pack debug tests. Then run
`MISE_AUTO_INSTALL=0 mise exec -- dart analyze lib/feature/asset_pack lib/feature/map/data/repository/base_map_pmtiles_repository.dart lib/feature/parameter test/feature/asset_pack test/feature/map/base_map_pmtiles_repository_test.dart test/feature/parameter/parameter_repository_test.dart`.

Expected: all tests pass and analysis reports no issues.

### Task 4: デバッグ画面に個別URLとerrorを表示

**Files:**
- Modify: `app/lib/feature/settings/children/config/debug/asset_pack/asset_pack_debug_page.dart`
- Modify: `app/test/feature/settings/children/config/debug/asset_pack/asset_pack_debug_page_test.dart`

**Interfaces:**
- Consumes: `AssetPackFileDiagnostic.resolvedUrl` and `.nativeError`

- [ ] **Step 1: Write failing widget tests**

Provide schema-v2 diagnostics with one resolved asset and one resolution error. Assert the
individual URL, error domain/code/description, and existing size evidence render and remain
copyable at text scale 2.

- [ ] **Step 2: Run widget tests and verify RED**

Expected: assertions fail because the page does not render the new evidence.

- [ ] **Step 3: Render the v2 evidence**

Extend each asset tile with optional resolved URL and native error text. Keep the list flexible;
do not assign fixed text heights. Preserve the explicit update button and refresh-only behavior.

- [ ] **Step 4: Run widget tests and verify GREEN**

Expected: existing and v2 tests pass without overflow.

### Task 5: 知見更新・最終検証・develop push

**Files:**
- Modify: `docs/knowledge/20260731_ios_managed_asset_pack_testflight_diagnostics.md`
- Modify: `docs/superpowers/plans/2026-08-01-ios-asset-pack-file-resolution.md`

- [ ] **Step 1: Document the corrected platform rule**

Record that a URL resolved for one item does not establish a reusable physical root. Include
the per-file `url(for:)` rule, schema-v2 fields, and the TestFlight evidence from pack v0.0.2.

- [ ] **Step 2: Run fresh verification**

Run Swift tests, assets_util tests/analyze, affected app tests/analyze, formatting checks, and
`git --no-pager diff --check`. Confirm generated selectors and that only intended files changed.

- [ ] **Step 3: Commit cohesive changes**

Create separate native/package, app, and documentation commits using the required English
one-word prefix plus concise Japanese description. Stage explicit paths; exclude `backend`.

- [ ] **Step 4: Push and verify**

Fetch `origin/develop`, confirm it has not advanced unexpectedly, push `develop`, and verify
`git rev-parse HEAD` equals `git rev-parse origin/develop`. Final status may contain only the
pre-existing user-owned `backend` modification.
