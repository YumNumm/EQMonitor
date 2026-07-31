# iOS Asset Pack Diagnostics Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** TestFlight端末でManaged Background Assetsの失敗段階を特定し、明示操作で更新確認を実行できるデバッグ画面を実装する。

**Architecture:** Swiftが端末状態をversion付きJSONへ変換し、ffigen生成bindingを介してassets_utilの型付きDartモデルへ渡す。Flutter側は専用repository/providerとRiverpod Mutationを使い、診断再読込と更新確認を独立して表示する。既存の通常読込APIは変更しない。

**Tech Stack:** Swift 6.2、BackgroundAssets、StoreKit、Dart Native Assets、ffigen、Flutter 3.44、Riverpod 3 Mutation、flutter_test

## Global Constraints

- iOS Managed Background Assetsのみを変更し、Android/macOSの挙動を変えない。
- iOS 26.0未満は `unsupportedOs` として診断する。
- `checkForUpdates()` のAPI応答と端末上の取得完了を区別する。
- pack削除、固定値、bundled asset fallbackは追加しない。
- Flutter/Dartコマンドは `mise exec --` 経由で実行する。
- `dynamic` と `Object` は `Map<String, dynamic>` 以外で追加しない。`!` を使わない。
- UI副作用はActionへ置き、Action以外へ `WidgetRef` / `BuildContext` を渡さない。
- 既存の `backend` submodule変更をstageしない。

---

### Task 1: Swiftの構造化診断と更新API

**Files:**
- Modify: `packages/assets_util/ios/assets_util/Sources/assets_util/EQMAssetsUtil.swift`
- Modify: `packages/assets_util/ios/assets_util/Package.swift`
- Create: `packages/assets_util/ios/assets_util/Tests/assets_utilTests/EQMAssetPackDiagnosticsTests.swift`

**Interfaces:**
- Produces: `diagnoseAssetPack(packIdentifier: String) -> String`
- Produces: `checkForAssetPackUpdates(packIdentifier: String, completion: @escaping (NSString) -> Void)`
- Produces JSON schema version 1 with `status`, `platform`, `os_version`, `pack_id`, `system_availability`, `manifest_url`, `pack_root`, `manifest`, `assets`, and optional `native_error`.

- [ ] Write Swift tests for invalid manifest, missing asset, size mismatch, all-valid assets, and stable JSON keys using fixture directories.
- [ ] Run `swift test --package-path packages/assets_util/ios/assets_util` and verify the new tests fail because the diagnostics builder does not exist.
- [ ] Add a platform-neutral manifest/file inspector and JSON encoder in `EQMAssetsUtil.swift`.
- [ ] Add the iOS-only `AssetPackManager` diagnostics, including the iOS 26.4 availability signal without early-returning before file inspection.
- [ ] Add the completion-handler bridge for `checkForUpdates()`; return sorted IDs and NSError domain/code/description in JSON.
- [ ] Run `swift test --package-path packages/assets_util/ios/assets_util` and verify all tests pass.

### Task 2: ffigen bindingとDartモデル

**Files:**
- Create: `packages/assets_util/lib/src/asset_pack_diagnostics.dart`
- Create: `packages/assets_util/test/asset_pack_diagnostics_test.dart`
- Modify generated: `packages/assets_util/lib/src/ios/eqm_assets_util.dart`
- Modify generated: `packages/assets_util/lib/src/ios/eqm_assets_util.dart.m`
- Modify: `packages/assets_util/lib/src/assets_util_ios.dart`
- Modify: `packages/assets_util/lib/assets_util.dart`

**Interfaces:**
- Produces: `enum AssetPackDiagnosticStatus`
- Produces: `enum AssetPackFileDiagnosticStatus`
- Produces: `final class AssetPackDiagnostics`
- Produces: `final class AssetPackUpdateResult`
- Produces: `AssetsUtil.diagnosePack()` and `AssetsUtil.checkForUpdates()`.

- [ ] Write Dart tests with literal schema-v1 JSON for every top-level status, per-file state, nullable paths, native errors, unknown schema, and update success/failure.
- [ ] Run `mise exec -- dart test packages/assets_util/test/asset_pack_diagnostics_test.dart` and verify failure because models are missing.
- [ ] Implement strict JSON decoding with descriptive `FormatException`; preserve all available diagnostic fields.
- [ ] Generate the Objective-C header and bindings through `packages/assets_util/hook/build.dart` or `tool/generate_ios_bindings.dart`; do not hand-edit generated selectors or blocks.
- [ ] Bridge the synchronous diagnostics NSString and asynchronous completion block to typed Dart results with `Completer`.
- [ ] Expose the methods only for iOS; other platforms throw `UnsupportedError` without changing `resolvePackRoot()`.
- [ ] Run package tests and `mise exec -- dart analyze packages/assets_util`.

### Task 3: App repositoryとRiverpod状態

**Files:**
- Create: `app/lib/feature/settings/children/config/debug/asset_pack/asset_pack_debug_repository.dart`
- Create generated: `app/lib/feature/settings/children/config/debug/asset_pack/asset_pack_debug_repository.g.dart`
- Modify: `app/lib/feature/settings/children/config/debug/asset_pack/asset_pack_debug_provider.dart`
- Create: `app/lib/feature/settings/children/config/debug/asset_pack/asset_pack_debug_action.dart`
- Create generated: `app/lib/feature/settings/children/config/debug/asset_pack/asset_pack_debug_action.g.dart`
- Create: `app/test/feature/settings/children/config/debug/asset_pack/asset_pack_debug_repository_test.dart`
- Create: `app/test/feature/settings/children/config/debug/asset_pack/asset_pack_debug_action_test.dart`
- Modify generated Riverpod files in the same directory using build_runner.

**Interfaces:**
- Produces: injectable `AssetPackDebugRepository` with `diagnose()` and `checkForUpdates()`.
- Produces: `AssetPackDebugInfo` containing native diagnostics and optional parsed `AssetPackManifest`.
- Produces: `AssetPackDebugAction.checkForUpdates(WidgetRef ref, BuildContext context)`.
- Produces: `AssetPackDebugAction.checkForUpdatesMutation`.

- [ ] Write repository tests proving partial diagnostics are returned when the pack is not ready and manifest metadata is parsed when present.
- [ ] Write Action tests proving only explicit execution calls update, success invalidates diagnostics, and failure preserves the prior diagnostics state.
- [ ] Run the two tests and verify they fail because repository/action types are missing.
- [ ] Implement repository/provider separation and the Mutation-backed Action.
- [ ] Run `mise exec -- dart run build_runner build --delete-conflicting-outputs` from `app/`.
- [ ] Run repository/action tests and verify they pass.

### Task 4: デバッグ画面

**Files:**
- Modify: `app/lib/feature/settings/children/config/debug/asset_pack/asset_pack_debug_page.dart`
- Create: `app/test/feature/settings/children/config/debug/asset_pack/asset_pack_debug_page_test.dart`

**Interfaces:**
- Consumes: `AssetPackDebugInfo`, `AssetPackDebugAction.checkForUpdatesMutation`.

- [ ] Write widget tests for unsupported OS, manifest missing, native error, partial file list, size mismatch, ready state, update progress/result/error, refresh-only behavior, and textScale 2.0 overflow.
- [ ] Run the widget test and verify failure against the old page.
- [ ] Replace the single `_NotReady` branch with a diagnostics summary that always renders available evidence.
- [ ] Add copyable OS/pack/path/error tiles and the explicit 「更新を確認」 button; disable it during Mutation pending.
- [ ] Preserve the right-top refresh action as provider invalidation only.
- [ ] Run the widget test and verify it passes.

### Task 5: 全体検証とドキュメント同期

**Files:**
- Modify: `docs/knowledge/20260731_ios_managed_asset_pack_testflight_diagnostics.md`
- Modify: `docs/superpowers/plans/2026-07-31-ios-asset-pack-diagnostics.md` (check completed steps)

- [ ] Run Swift tests.
- [ ] Run assets_util tests and analyze.
- [ ] Run targeted app tests.
- [ ] Run `mise exec -- dart format --output=none --set-exit-if-changed` for changed Dart files.
- [ ] Run `mise exec -- dart analyze` from `app/` and record any unrelated pre-existing failures separately.
- [ ] Add the final schema-v1 field list, `checkForUpdates()` completion semantics, and on-device reading procedure to the knowledge document.
- [ ] Inspect `git --no-pager diff --check`, generated binding diffs, and `git status`; confirm `backend` is excluded.
- [ ] Commit cohesive changes with the required English prefix and Japanese summary.
- [ ] Push `develop` to `origin` and verify local HEAD equals `origin/develop`.
