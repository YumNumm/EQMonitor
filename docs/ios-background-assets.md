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
|---|---|---|
| iOS (Background Assets) | `net.yumnumm.eqmonitor.assets` | `packages/assets_util/lib/assets_util.dart` (`_iosAssetPackIdentifier`), `IOS_BACKGROUND_ASSET_PACK_ID` in `.github/workflows/upload-asset-pack.yaml`, App Store Connect's Background Assets pack, and (once created) the Xcode Background Assets capability's `assetPackID`. |
| Android (Play Asset Delivery) | `eqmonitor_assets` | `packages/assets_util/lib/assets_util.dart` (`_androidAssetPackName`), `app/android/assetpacks/eqmonitor_assets/build.gradle.kts`'s `packName`, `assetPacks += setOf(":assetpacks:eqmonitor_assets")` in `app/android/app/build.gradle.kts`. |

These are deliberately **different literal strings** — Android Gradle
module/pack names disallow dots, iOS asset pack IDs are conventionally
reverse-DNS — and were already chosen and documented by Task 7's
`docs/asset-pack-cd.md` before this task; this document doesn't introduce a
new value, it just points `packages/assets_util`'s Dart contract at the
existing one so CD / Xcode / App Store Connect stay consistent.

## What `packages/assets_util` implements today

`AssetsUtil.resolvePackRoot()` on iOS:

1. Requires iOS 26.0+ (`AssetPackManager`'s own availability floor; this
   app's `IPHONEOS_DEPLOYMENT_TARGET` is already 26.0).
2. When iOS 26.4+ is available, first checks
   `AssetPackManager.shared.assetPackIsAvailableLocally(withID: "net.yumnumm.eqmonitor.assets")`.
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

## What is *not* implemented yet — required before this works on a real device

Apple's Background Assets header documentation states, verbatim, that using
`AssetPackManager` **requires the app to also have a companion Background
Download App Extension** — for Apple-hosted asset packs (this project's
choice, per `docs/asset-pack-cd.md`), one that adopts `SKDownloaderExtension`
from StoreKit:

> "When using the asset-pack manager, make sure that you also adopt the
> corresponding managed extension protocol. For applications that use Apple
> hosting, the corresponding protocol is `SKDownloaderExtension` from
> StoreKit... **Not adopting the right protocol is a programmer error.**"

**This repository's `app/ios/Runner.xcodeproj` does not have this extension
yet.** The existing extension targets (`AppIntentExtension`,
`WidgetExtension`, `FcmServiceExtension`) are unrelated. Creating this
target is deliberately **out of scope for this task** — hand-authoring a new
`PBXNativeTarget` (build phases, entitlements, provisioning profile,
`Info.plist` `EXAppExtensionAttributes`, an "Embed App Extensions" copy
phase) via raw `project.pbxproj` text edits is high-risk and easy to get
subtly wrong in ways that don't surface until a real device/TestFlight run.

### One-time manual setup (do this in Xcode, not by hand-editing `project.pbxproj`)

1. **Add the Background Assets capability to `Runner`.** Xcode → `Runner`
   target → Signing & Capabilities → **+ Capability** → *Background
   Assets*. Set the asset pack ID to `net.yumnumm.eqmonitor.assets`. This
   both links `BackgroundAssets.framework` properly and adds the
   corresponding entitlement.
2. **Add a Background Download Extension target.** Xcode → File → New →
   Target → search "Background Download Extension" → choose the
   **"Apple-Hosted, Managed"** option (this project uses Apple hosting;
   see `docs/asset-pack-cd.md`'s App Store Connect setup section). Xcode's
   template wires up `SKDownloaderExtension` conformance, the
   `EXAppExtensionAttributes`/`EXPrincipalClass` `Info.plist` entries, and
   the "Embed App Extensions" copy-files build phase automatically — this
   is exactly the kind of multi-part wiring that's unsafe to hand-write.
3. Confirm the extension's target explicitly links
   `BackgroundAssets.framework` under Frameworks and Libraries (per
   `BAManagedDownloaderExtension.h`'s own setup instructions, step 6).
4. Re-run `mise exec -- flutter build ios --no-codesign` from `app/` and
   confirm it still succeeds with the new extension target present.

### App Store Connect coordination

Already documented in detail in `docs/asset-pack-cd.md`'s "App Store
Connect: Managed Background Assets asset pack creation" section — in
summary: create the `net.yumnumm.eqmonitor.assets` Background Assets pack
as **Apple-hosted** in App Store Connect (Account Holder/Admin/App
Manager/Developer role required), and upload an initial version by hand
(Transporter) once to create the resource `upload-asset-pack.yaml`'s
`upload-ios` job's pre-check looks for.

### `ba-package` / Xcode version

Confirmed locally on this machine (Xcode 27.0 beta, build 27A5194q):
`xcrun ba-package --help` works and exposes `convert`, `download-manifest`,
`evaluate`, `package` (default), `template` subcommands. `deploy-app.yaml`
currently pins Xcode `26.3`; `upload-asset-pack.yaml` pins its own
`IOS_ASSET_PACK_XCODE_VERSION` (currently `26.3` too, per
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
preserved at `Contents/Resources/platform/`), which is always present since
it's git-committed and synced by `upload-asset-pack.yaml`'s `sync-macos`
job. No entitlements, capabilities, or extensions are needed for this path.
