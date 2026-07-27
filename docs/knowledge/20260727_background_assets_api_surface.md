# Background Assets API surface (confirmed locally, Xcode 27.0 beta / iOS 27 SDK)

Task 9 (`AssetPackLocator` 抽象 + `assets_util` 拡張) mandates a Step 1 spike
before touching code, because Apple's `developer.apple.com/documentation/backgroundassets`
pages are JS-rendered and unreadable by automated fetchers. This machine has
**Xcode 27.0 (build 27A5194q)** installed with a real iOS 27 SDK, so the spike
was done by reading the actual framework headers/swiftinterface and by
**compiling real Swift code against them** (not guessing from WWDC transcripts
or third-party blog posts).

## Environment

```
$ xcodebuild -version
Xcode 27.0
Build version 27A5194q
$ xcodebuild -showsdks | grep -i ios
iOS SDKs: iOS 27.0  -sdk iphoneos27.0
iOS Simulator SDKs: Simulator - iOS 27.0  -sdk iphonesimulator27.0
$ xcrun ba-package --help
OVERVIEW: A tool that packages asset files into asset-pack archives.
SUBCOMMANDS: convert, download-manifest, evaluate, package (default), template
```

`BackgroundAssets.framework` ships in both the iOS and macOS 27 SDKs:

```
$(xcrun --sdk iphoneos --show-sdk-path)/System/Library/Frameworks/BackgroundAssets.framework
$(xcrun --sdk macosx --show-sdk-path)/System/Library/Frameworks/BackgroundAssets.framework
```

Headers present: `BAAssetPackManager.h`, `BAAssetPack.h`,
`BAAssetPackManifest.h`, `BAAssetPackStatus.h`,
`BAManagedAssetPackDownloadDelegate.h`, `BAManagedDownloaderExtension.h`,
`BADownloaderExtension.h`, `BAAppExtensionInfo.h`, `BADownloadManager.h`,
`BAURLDownload.h`, `BAError.h`, `BAManagedError.h`.

## Finding 1 — the Objective-C classes are `NS_REFINED_FOR_SWIFT`; the real Swift API is different

`BAAssetPackManager` (the ObjC class documented by header comments) is
annotated `NS_REFINED_FOR_SWIFT`, which means Apple ships a **hand-written
Swift overlay** and the raw ObjC symbol is not what Swift code actually sees.
Trying to write `BAAssetPackManager.shared` in Swift fails
(`cannot find 'BAAssetPackManager' in scope`) — confirmed by direct
compilation (see below). The real Swift-visible API, read from
`BackgroundAssets.swiftmodule/arm64e-apple-ios.swiftinterface`, is:

```swift
@available(iOS 26, macOS 26, tvOS 26, visionOS 26, *)
public actor AssetPackManager {
  public static let shared: AssetPackManager

  @available(iOS 26.4, macOS 26.4, *)
  nonisolated public func assetPackIsAvailableLocally(withID assetPackID: String) -> Bool

  nonisolated public func url(for path: System.FilePath) throws -> Foundation.URL
  @available(iOS 27, macOS 27, *)
  nonisolated public func url(for path: System.FilePath, asLocalizedFor language: Locale.Language) throws -> Foundation.URL

  nonisolated public func contents(at path: System.FilePath, searchingInAssetPackWithID assetPackID: String? = nil, options: Data.ReadingOptions = .mappedIfSafe) throws -> Data
  nonisolated public func descriptor(for path: System.FilePath, searchingInAssetPackWithID assetPackID: String? = nil) throws -> System.FileDescriptor

  @available(iOS 27, macOS 27, *)
  public var manifest: AssetPackManifest { get async throws }
  public func remove(assetPackWithID assetPackID: String) async throws
  @discardableResult
  public func checkForUpdates() async throws -> (updatingIDs: Set<String>, removedIDs: Set<String>)
  // ...ensureLocalAvailability(of:), status(relativeTo:), etc. are all `async throws`
}
```

Important detail: `AssetPackManager` is an **actor**, but the read-only
methods we need (`assetPackIsAvailableLocally(withID:)`, `url(for:)`,
`contents(at:...)`, `descriptor(for:...)`) are all marked `nonisolated`, so
they're callable **synchronously, without `await`**, from any thread. This
matters because `resolveLocalPath` (the existing sibling API) is also
synchronous, and it means we don't need to bridge Swift async/await or
completion-handler blocks through ffigen at all for this feature.

## Finding 2 — there is no "get me the pack's root directory" API; only file-level access into a merged namespace

`AssetPackManager` never exposes an on-disk directory handle for "asset pack
X". The only file-system-shaped APIs are:

- `url(for path: FilePath) throws -> URL` — **no** `assetPackID` parameter at
  all. It resolves a path against the union of *all* currently-downloaded
  asset packs.
- `contents(at:searchingInAssetPackWithID:)` / `descriptor(for:searchingInAssetPackWithID:)`
  — these two *do* take an optional `assetPackID` to scope the search, but
  they return file bytes / a file descriptor, not a directory URL.

The ObjC header doc for the equivalent `URLForPath:error:` is explicit:

> "In particular, this method shouldn't be used to get the URL to the root of
> the shared asset-pack namespace. Don't use this method to block the main
> thread."

So calling `url(for: FilePath(""))` to get "the root" is something Apple's
own docs tell you not to do. Since this app manages exactly **one** asset
pack (`eqmonitor-assets`), the "merged namespace" is in practice
just that one pack, so the adaptation chosen here is: resolve a **known
top-level file that the pack layout guarantees exists** (`manifest.json`,
per `backend/docs/superpowers/specs/2026-07-18-asset-pack-design.md`'s
mandated layout) via `url(for:)`, then return
`url.deletingLastPathComponent().path` as the "pack root". This is a
deliberate, documented workaround for a real API gap, not a guess — see
`EQMAssetsUtil.swift`'s `resolveIOSManagedAssetPackRoot` for the
implementation and inline reasoning.

Readiness is additionally (defense-in-depth) checked via
`assetPackIsAvailableLocally(withID:)` when running on iOS/macOS 26.4+ (this
method didn't exist before 26.4), **and** always via
`FileManager.default.fileExists(atPath:)` on the resolved manifest URL
(`url(for:)`'s own doc says it returns "a well formed URL even if no item
exists at the specified relative path", so its return value alone is not a
reliable readiness signal on any OS version — the `FileManager` check is
the one guard available across the entire 26.0+ range).

## Finding 3 — Managed Background Assets requires a companion App Extension (**now implemented as `AssetDownloader`**)

The `BAAssetPackManager`/`AssetPackManager` header doc states, verbatim:

> "The first time that your code refers to the shared manager, Background
> Assets considers that your application is opting into automatic system
> management of your asset packs. **Important:** When using the asset-pack
> manager, make sure that you also adopt the corresponding managed extension
> protocol. For applications that use Apple hosting, the corresponding
> protocol is `SKDownloaderExtension` from StoreKit. For other applications,
> the corresponding protocol is `BAManagedDownloaderExtension`. **Not
> adopting the right protocol is a programmer error.**"

`BAManagedDownloaderExtension.h`'s doc comment corroborates this with a
step-by-step "Creating an Objective-C Downloader Extension" walkthrough that
starts from "Xcode's Background Download extension template" — i.e. Apple
expects a **separate App Extension target** (Apple-hosted apps adopt
`StoreDownloaderExtension` from StoreKit; self-hosted apps adopt
`BAManagedDownloaderExtension`), not just framework calls from the main app.

**Status (2026-07-28):** `app/ios/AssetDownloader/` is an ExtensionKit target
embedded from `Runner`, adopting `StoreDownloaderExtension` with a shared App
Group (`group.net.yumnumm.eqmonitor`). `Runner/Info.plist` sets
`BAAppGroupID`, `BAHasManagedAssetPacks`, and `BAUsesAppleHosting`. See
`docs/ios-background-assets.md` for the remaining manual steps (Apple
Developer portal capability registration, App Store Connect initial `.aar`
upload).

**Still outstanding before end-to-end works on a real device:**

1. Apple Developer portal / provisioning: enable the Background Assets
   capability for the `net.yumnumm.eqmonitor` App ID and refresh profiles.
   The capability is per-app — the pack id `eqmonitor-assets` is never
   entered in Xcode or the portal, only in the `ba-package` manifest, the
   runtime lookup, and App Store Connect (plist keys are already in place).
2. App Store Connect: create the Apple-hosted pack and upload an initial
   `.aar` (see `docs/asset-pack-cd.md`).
3. Unrelated iOS build blocker: `jma_code_table.json` bundle reference drift
   (`docs/todo/850_ios_missing_jma_code_table_json_build_break.md`).

## Finding 4 — deployment target compatibility

- App's actual `IPHONEOS_DEPLOYMENT_TARGET` is already **26.0**
  (`app/ios/Runner.xcodeproj/project.pbxproj`), so no additional OS floor is
  introduced by using `AssetPackManager` (class-level availability
  `iOS 26, macOS 26`).
- `assets_util`'s own build hook compiles its xcframework against a lower
  target (`arm64-apple-ios16.0`, to keep the package generically reusable)
  — this is fine: `AssetPackManager` usage is wrapped in
  `if #available(iOS 26.0, *)` / `if #available(iOS 26.4, *)` guards, which
  compiles cleanly at a 16.0 deployment target (verified below) and simply
  returns `nil` (→ `AssetPackNotReadyException` on the Dart side) on
  hypothetical older OS versions the package might run on outside this app.
- App's actual macOS `MACOSX_DEPLOYMENT_TARGET` is **15.6**
  (`app/macos/Runner.xcodeproj/project.pbxproj`, `Runner` target, not the
  `Pods`/`Flutter Assemble` aggregate targets which sit at 13.3) — far below
  `AssetPackManager`'s `macOS 26` floor. This matches the plan's own Global
  Constraints: macOS is explicitly **out of scope** for Managed Background
  Assets and uses plain native bundling instead (`app/assets/platform/` as a
  Bundle Resources folder reference, staged from the backend Release at
  build time by `tool/asset_pack/stage_from_release.sh`, not committed). The
  macOS branch of `EQMAssetsUtil.resolvePackRoot` therefore never touches
  `BackgroundAssets` at all (`#if os(iOS)`-gated import).

## Compilation evidence

All three compiled cleanly against the real Xcode 27 SDKs (only an unrelated
"Unable to locate libSwiftScan" fallback warning, no errors):

```bash
$ swiftc -typecheck -sdk "$(xcrun --sdk iphoneos --show-sdk-path)" \
    -target arm64-apple-ios16.0 EQMAssetsUtilSpike.swift        # OK
$ swiftc -typecheck -sdk "$(xcrun --sdk iphonesimulator --show-sdk-path)" \
    -target arm64-apple-ios16.0-simulator EQMAssetsUtilSpike.swift  # OK
$ swiftc -typecheck -sdk "$(xcrun --sdk macosx --show-sdk-path)" \
    -target arm64-apple-macosx15.6 EQMAssetsUtilSpike.swift     # OK
```

And with `-emit-objc-header`, the generated selector for the new method is
exactly what ffigen picks up:

```objc
- (NSString * _Nullable)resolvePackRootWithPackIdentifier:(NSString * _Nonnull)packIdentifier SWIFT_WARN_UNUSED_RESULT;
```

## Android note (not part of the Xcode spike, but confirmed the same way — via official docs, not memory)

`AssetPackManager.getPackLocation(packName)` / `AssetPackLocation` are the
real, current (Play Core `2.3.0`, confirmed against
`https://dl.google.com/android/maven2/.../group-index.xml`) Play Asset
Delivery APIs. Per
[`AssetPackLocation`](https://developer.android.com/reference/com/google/android/play/core/assetpacks/AssetPackLocation):
`path()`/`assetsPath()` return **`null` when `packStorageMethod()` is
`APK_ASSETS`** (i.e. Play fused the install-time pack into the base APK
instead of a separate split) — "To access assets from packs installed as
APKs, use Asset Manager." This exactly matches the brief's expected
`context.assets` fallback, and is implemented as such in `AssetsUtil.kt`.
