# iOS Managed Background Assets — Xcode / App Store Connect setup

This document describes what's already wired up by `packages/assets_util`
and `.github/workflows/upload-asset-pack.yaml`, and the **one-time manual
Xcode/App Store Connect setup that's still required** before iOS's
`AssetsUtil.resolvePackRoot()` actually works end-to-end on a real device.
See `docs/knowledge/20260727_background_assets_api_surface.md` for the full
API research this is based on (confirmed by compiling real Swift code
against the Xcode 27 / iOS 27 SDK's `BackgroundAssets.framework`, not
guessed from documentation that couldn't be fetched).

## Canonical identifiers (must stay consistent everywhere)

| Platform | Identifier | Where it's declared |
| --- | --- | --- |
| iOS (Background Assets) | `eqmonitor-assets` | `packages/assets_util/lib/assets_util.dart` (`_iosAssetPackIdentifier`), `IOS_BACKGROUND_ASSET_PACK_ID` in `.github/workflows/upload-asset-pack.yaml` (which CI writes into the `ba-package` manifest's `assetPackID`), and the Background Assets pack record in App Store Connect. |
| Android (Play Asset Delivery) | `eqmonitor_assets` | `packages/assets_util/lib/assets_util.dart` (`_androidAssetPackName`), `app/android/assetpacks/eqmonitor_assets/build.gradle.kts`'s `packName`, `assetPacks += setOf(":assetpacks:eqmonitor_assets")` in `app/android/app/build.gradle.kts`. |

**Nothing in the Xcode project declares the iOS identifier.** For an
Apple-hosted managed pack there is no per-pack `assetPackID` field in the
Background Assets capability, in `Runner.entitlements`, or in
`Runner/Info.plist` — the capability only contributes the `BAAppGroupID` /
`BAHasManagedAssetPacks` / `BAUsesAppleHosting` keys and the
`AssetDownloader` extension. The id is supplied at runtime by the Dart
constant above and matched against whatever CI uploaded, so drift between
the Dart constant and the workflow is invisible at build time. That's what
`tool/asset_pack/check_asset_pack_id.py` guards; `upload-asset-pack.yaml`
runs it before packaging, and
`tool/asset_pack/test_check_asset_pack_id.py` covers it locally.

The two platform strings are deliberately **different literals**: Android
Gradle module/pack names disallow hyphens, and App Store Connect rejects the
dots of a reverse-DNS id with ITMS-91133 (see
`docs/knowledge/20260728_asset_pack_id_charset.md`), so neither string can be
used on the other platform.

## Local iOS build: slim `jma_code_table.json`

AppIntent / Widget extensions bundle a slim `jma_code_table.json` (prefecture +
city only) — not the full Asset Pack JSON. The slim file is **committed** at
`app/assets/parameters/jma_code_table.json`, so a clean clone can build iOS
without `GH_TOKEN`.

CI still runs `stage_from_release.sh --target ios-native` in
`deploy-app.yaml`'s `build-ios` so Release 更新後の差分を拾える。ローカルで
最新に揃えるときも、次のように同じコマンドを使う。

```bash
GH_TOKEN=... tool/asset_pack/stage_from_release.sh --target ios-native
```

See `docs/knowledge/20260728_asset_pack_release_staging.md`.

## What `packages/assets_util` implements today

`AssetsUtil.resolvePackRoot()` on iOS:

1. Requires iOS 26.0+ (`AssetPackManager`'s own availability floor; this
   app's `IPHONEOS_DEPLOYMENT_TARGET` is already 26.0).
2. When iOS 26.4+ is available, first checks
   `AssetPackManager.shared.assetPackIsAvailableLocally(withID: "eqmonitor-assets")`.
3. Resolves `manifest.json`'s URL via `AssetPackManager.shared.url(for:)`
   (the pack layout — see
   `backend/docs/superpowers/specs/2026-07-18-asset-pack-design.md` —
   guarantees this file exists at the pack root) and verifies it actually
   exists on disk via `FileManager`.
4. Returns the parent directory of that URL as the "pack root", or throws
   `AssetPackNotReadyException` (no fallback, per this project's Global
   Constraints).

This is a deliberate workaround for a real API gap: `AssetPackManager` has
**no** "give me pack X's root directory" method — see Finding 2 in the
knowledge doc referenced above. It only exposes file-level access into a
namespace merged across *all* downloaded packs, and Apple's own docs warn
against fetching "the root" via `url(for:)`. Since this app manages exactly
one pack, resolving a known top-level file and taking its parent directory
is the correct, defensible adaptation.

## Xcode / App Store Connect — remaining manual steps

The `AssetDownloader` ExtensionKit target (`app/ios/AssetDownloader/`) and
`Runner/Info.plist` Background Assets keys (`BAAppGroupID`,
`BAHasManagedAssetPacks`, `BAUsesAppleHosting`) are in the repo. Before the
first real device / TestFlight run, still complete:

1. Enable the **Background Assets** capability for `net.yumnumm.eqmonitor` in
   the Apple Developer portal and refresh the provisioning profiles. The
   capability is per-app, not per-pack — there is no asset pack ID to enter
   here or in Xcode's Signing & Capabilities.
2. Create the Apple-hosted Background Assets pack in App Store Connect and
   upload an initial `.aar` once (see `docs/asset-pack-cd.md`).
   `upload-asset-pack.yaml` creates the pack record automatically when it's
   missing, so in practice this happens on the workflow's first successful run.

### `ba-package` / Xcode version

Confirmed locally on this machine (Xcode 27.0 beta, build 27A5194q):
`xcrun ba-package --help` works and exposes `convert`, `download-manifest`,
`evaluate`, `package` (default), `template` subcommands. `deploy-app.yaml`
currently pins Xcode `26.6`; `upload-asset-pack.yaml` pins its own
`IOS_ASSET_PACK_XCODE_VERSION` (currently `26.6` too, per
`docs/asset-pack-cd.md`) deliberately independently of the app-build pin.
If `ba-package` availability ever changes for the pinned CI Xcode version,
bump `IOS_ASSET_PACK_XCODE_VERSION`, not `deploy-app.yaml`'s.

## macOS: no Background Assets involvement at all

Runner's macOS `MACOSX_DEPLOYMENT_TARGET` is 15.6 — far below
`AssetPackManager`'s `macOS 26` floor — and per this project's Global
Constraints, macOS is explicitly out of scope for store-based Asset Pack
delivery. `AssetsUtil.resolvePackRoot()` on macOS instead resolves the
`platform` folder bundled directly into `Bundle.main` (registered as a
Bundle Resources **folder reference** — not individual file references — in
`app/macos/Runner.xcodeproj/project.pbxproj`, so the directory structure is
preserved at `Contents/Resources/platform/`). Those files are **not**
git-committed — `tool/asset_pack/stage_from_release.sh --target macos`
downloads and verifies them from the backend Release before the build, the
same way Android stages its Play Asset Delivery module (see
`docs/knowledge/20260728_asset_pack_release_staging.md`). No entitlements,
capabilities, or extensions are needed for this path.
