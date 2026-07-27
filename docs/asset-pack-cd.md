# Asset Pack CD (`upload-asset-pack.yaml`)

This document describes `.github/workflows/upload-asset-pack.yaml`: what it
automates, what still needs one-time manual setup in Google Play Console /
App Store Connect, and every assumption that must be confirmed on the
workflow's first real run against a live `asset_pack_released` event.

## What triggers it

`YumNumm/eqmonitor-backend`'s `release-asset-pack.yaml` publishes a GitHub
Release `asset-pack-vX.Y.Z` (assets: `asset-pack-vX.Y.Z.zip` + `manifest.json`)
and sends a `repository_dispatch` (`asset_pack_released`) to this repo with
`client_payload: { pack_version, artifact_url, manifest_url, sha256 }`. This
workflow can also be run manually via `workflow_dispatch` with the same
`pack_version` / `artifact_url` / `sha256` (no `manifest_url` input — the
manifest is read from inside the downloaded zip, not fetched separately).

## What the workflow automates today

| Stage | Automated? | Notes |
|---|---|---|
| Download + sha256 verify + structure assert + `pack_version` match | Yes | `tool/asset_pack/verify_zip.sh`, shared by all three downstream jobs via an uploaded artifact |
| macOS native bundling sync (`app/assets/platform/`) | Yes, via PR | Replaces the directory's contents with the pack's `manifest.json` / `map/all.pmtiles` / `parameters/*.json` |
| macOS Xcode folder-reference registration check | Check only, no auto-fix | Fails loudly until a separate task registers `app/assets/platform` as a Bundle Resources folder reference in `app/macos/Runner.xcodeproj` |
| Android Play Asset Delivery module sync (`app/android/assetpacks/eqmonitor_assets/src/main/assets/`) | Yes, via PR | Requires the module to already exist (a separate task creates `app/android/assetpacks/eqmonitor_assets/`); fails loudly (`test -d` guard) until it does |
| Android live Google Play upload | **No** | See "Android: why there is no standalone upload" below |
| iOS Managed Background Assets upload | Yes, via App Store Connect API | Requires the asset pack to already exist in App Store Connect (see below); fails loudly if it doesn't |

Every platform runs as its own GitHub Actions job so a failure in one (e.g.
the Android module not existing yet) never hides a success or failure in
another.

## One-time manual setup required before this workflow can succeed end-to-end

### 1. Google Play Console: Play Asset Delivery module

Play Asset Delivery install-time asset packs are Gradle dynamic-feature-style
modules bundled *inside* the app's `.aab` — they are not independent
artifacts uploaded on their own. This is why `google-play-cli` (this repo's
existing Play upload tool, `github:YumNumm/google-play-cli`) only exposes
`bundles publish` and `get-latest-build-number` (verified locally: `mise exec
-- google-play-cli --help` / `google-play-cli bundles --help` during Task 7's
implementation — no `assetpacks` subcommand exists), and why the public
Google Play Developer API has no standalone `edits.assetpacks.upload`
endpoint — the only bundle-upload method is
[`edits.bundles.upload`](https://developers.google.com/android-publisher/api-ref/rest/v3/edits.bundles/upload),
which uploads the whole `.aab` (asset packs and all).

**Manual setup:**

1. Add the `com.android.dynamic-feature` module `app/android/assetpacks/eqmonitor_assets/` to the Android Gradle project (a separate task's responsibility — this repo's asset-pack CD assumes the module directory already exists at `app/android/assetpacks/eqmonitor_assets/src/main/assets/`).
2. Declare it as an `install-time` delivery asset pack in the module's `build.gradle`/`AndroidManifest.xml` (per [Android's Play Asset Delivery guide](https://developer.android.com/guide/playcore/asset-delivery)) and reference it from the base app module.
3. Nothing needs to be pre-created in the Play Console UI itself for an install-time pack — Play derives the asset pack from the uploaded `.aab`'s module structure the first time a bundle containing it is uploaded through `deploy-app.yaml`.

**What this means for automation:** because Play ties install-time asset
packs to a full bundle upload, there is no way to publish a new asset pack
version independently of an app release using Google's supported public
API surface. `sync-android` in this workflow therefore only updates
`app/android/assetpacks/eqmonitor_assets/src/main/assets/` on `develop` (via
PR) — the new pack contents ship the next time `deploy-app.yaml` builds and
publishes an AAB, not immediately when the Asset Pack is released. This is
the brief-mandated fallback (`docs/asset-pack-cd.md` documenting the
constraint instead of forcing full independence), but based on this task's
research it is not merely a workaround for a tooling gap — it reflects a
real limitation of Play's public upload API for install-time packs. If a
faster path is ever needed, the two realistic options are (a) switch this
asset pack to **on-demand** delivery, which supports `bundletool
build-apks`/`install-apks` workflows closer to independent updates, or (b)
accept the "ships with the next app release" cadence permanently and instead
tighten `deploy-app.yaml`'s release cadence.

### 2. App Store Connect: Managed Background Assets asset pack creation

The iOS job (`upload-ios`) never creates the Background Assets pack itself —
App Store Connect requires it to exist before any version can be uploaded to
it (this is also this workflow's mandatory pre-check #2; see below).

**Manual setup (one-time, per Apple's documented flow):**

1. In Xcode, add the **Background Assets** capability to the Runner target and configure the asset pack ID that will be used. The canonical ID is `net.yumnumm.eqmonitor.assets`, aligned across `IOS_BACKGROUND_ASSET_PACK_ID` in the workflow and `_iosAssetPackIdentifier` in `packages/assets_util/lib/assets_util.dart`. This Xcode-side capability registration (see `docs/ios-background-assets.md`) must exist before the first real `upload-asset-pack` run.
2. In App Store Connect, under the app's Background Assets management (Account Holder/Admin/App Manager/Developer role required — [App Store Connect Help: Manage Asset Packs](https://developer.apple.com/help/app-store-connect/manage-asset-packs/upload-apple-hosted-asset-packs)), choose **Apple-hosted** so Apple hosts and serves the pack (this workflow assumes Apple-hosted; self-hosted Background Assets would need an entirely different, non-ASC-API upload path).
3. Upload an initial version once by hand (Transporter drag-and-drop is the simplest — see "Manual fallback" below) to create the `backgroundAssets` resource that this workflow's pre-check looks for. Subsequent versions can then go through the automated `upload-ios` job.

Reference: [Overview of Apple-hosted asset packs](https://developer.apple.com/help/app-store-connect/manage-asset-packs/overview-of-apple-hosted-asset-packs), [Creating managed asset packs](https://developer.apple.com/documentation/backgroundassets/creating-managed-asset-packs).

## iOS: what is doc/WWDC-verified vs. best-effort

Apple's Background Assets / App Store Connect API reference pages are
JS-rendered SPAs; this task's tooling could not retrieve their full content
verbatim (only page titles / summarized fragments came back from automated
fetches). The following is what could actually be confirmed, and how:

**Confirmed (cite-able):**

- `ba-package` ships with Xcode 26+ and requires macOS 26 (Tahoe) at
  `/Applications/Xcode.app/Contents/Developer/usr/bin/ba-package` — confirmed
  via the [Apple Developer Forums "ba-package tool not available"
  thread](https://developer.apple.com/forums/thread/795796), including the
  exact error messages seen on older Xcode/macOS.
- The command syntax `xcrun ba-package template` (scaffold a manifest) and
  `ba-package <manifest-path> <output-archive-path>` (build the archive, run
  from the directory the manifest's file selectors are relative to), plus the
  manifest JSON schema (`assetPackID`, `downloadPolicy` with
  `essential`/`prefetch`/`onDemand`, `fileSelectors` with `file`/`directory`
  entries, `platforms`) — confirmed via the [WWDC25 "Discover Apple-Hosted
  Background Assets" session](https://developer.apple.com/videos/play/wwdc2025/325/)
  transcript.
- `xcrun altool --upload-asset-pack asset_pack --apple-id apple-id -u username
  [-p password]`, Transporter (drag-and-drop), iTMSTransporter, and the App
  Store Connect API as the four documented upload methods — confirmed via
  [App Store Connect Help: Upload Apple-hosted asset packs](https://developer.apple.com/help/app-store-connect/manage-asset-packs/upload-apple-hosted-asset-packs).
  Note `altool --upload-asset-pack` only documents `-u`/`-p` (Apple ID +
  app-specific password) auth in this help page, not `--apiKey`/`--apiIssuer`
  — this repo only holds App Store Connect **API key** secrets
  (`APP_STORE_CONNECT_API_KEY_*`, no Apple ID credentials), which is why the
  automated path uses the App Store Connect API directly instead of `altool`.
- Resource *names* `backgroundAssets`, `backgroundAssetVersions`,
  `backgroundAssetUploadFiles` exist in the App Store Connect API — confirmed
  as literal resource/page names via
  [`AppStoreConnectAPI/managing-apple-hosted-background-assets`](https://developer.apple.com/documentation/AppStoreConnectAPI/managing-apple-hosted-background-assets)
  and corroborated by multiple independent search results describing the
  same create-version → reserve-upload → commit sequence.

**NOT verified (best-effort, structurally-informed guess):**

- The exact JSON:API attribute names inside each request/response body
  (`fileName`/`fileSize`/`assetType` on the reservation, `uploadOperations`
  entries' shape, `sourceFileChecksum` as MD5, the terminal processing state
  name). `tool/asset_pack/asc_client.py`'s module docstring has the full
  "UNVERIFIED SURFACE WARNING" and cites why this shape was chosen (it
  mirrors the reservation/upload/commit pattern used by every other ASC API
  asset-upload family — appScreenshots, appPreviews, buildIcons — which has
  been stable for years).
- The exact filename/extension `ba-package` writes its output archive as.
  The WWDC transcript's command form (`ba-package <manifest> <output-path>`)
  implies the given output path is respected, but this could not be verified
  against a real invocation (no macOS 26 + Xcode 26 environment was
  available in the implementation sandbox). The workflow's "Package archive
  with ba-package" step therefore checks for the exact requested path first,
  then falls back to a glob (`ios-background-asset*`) and fails loudly with
  actionable instructions if neither is found.
- The attribute name App Store Connect uses to store a `backgroundAssets`
  resource's asset pack identifier (needed by the pre-check to find "our"
  pack among possibly several). `find_background_asset_id` in
  `tool/asset_pack/asc_client.py` tries a few plausible attribute names and,
  if none match but the app has *some* Background Assets pack(s), logs the
  raw API response so a human can confirm the right key and fix the code.

**Every one of the unverified points above degrades to a loud, actionable
failure** (an `AscApiError` with the raw API response body, or an
`::error::` annotation pointing at this document) rather than silently
uploading something wrong. The manual fallback — Transporter drag-and-drop,
or `xcrun altool --upload-asset-pack ... -u <apple-id> -p <app-specific
password>` (requires adding new Apple ID credential secrets not currently in
this repo) — always remains available if the automated path needs to be
bypassed for a release.

### Manual verification if polling fails or times out

`AscClient.poll_background_asset_version_state` (in `tool/asset_pack/asc_client.py`)
only returns normally when the observed state is in its `KNOWN_SUCCESS_STATES`
allow-list (`READY_FOR_TESTING`, `PROCESSING_COMPLETE`). Any explicitly-known
failure state (`FAILED_PROCESSING`, `REJECTED`, `INVALID`) **or** a 20-minute
timeout on an unrecognized state both raise `AscApiError` and fail the
`upload-ios` job — on purpose, because the terminal state name is unverified
(see above) and this job must never report green for an upload that's
actually stuck or failed.

If this happens, the file itself was already uploaded and committed
successfully (polling only starts after `commit_background_asset_upload`
succeeds) — only the *processing* status is in question. To check by hand:

1. Open App Store Connect → the app (`ASC_APP_ID` `6447546703`) → **Background Assets** → the pack matching `IOS_BACKGROUND_ASSET_PACK_ID` (`net.yumnumm.eqmonitor.assets`).
2. Find the version the failed job created — the workflow log prints `created backgroundAssetVersion <id>` right before polling starts; match it, or just look at the most recent version's timestamp.
3. Read its status directly in the UI:
   - If it shows a legitimate success state (e.g. ready for TestFlight/App Store submission) under a name this client doesn't recognize, add that literal state string to `KNOWN_SUCCESS_STATES` in `tool/asset_pack/asc_client.py` so future runs don't need manual checking.
   - If it shows a genuine failure/rejection, treat the Asset Pack version as failed: re-run `upload-ios` (it creates a fresh `backgroundAssetVersion` each time, so a failed one doesn't block retrying) after investigating the cause in the UI's error detail, if shown.
   - If it's still legitimately processing beyond 20 minutes, either re-run the poll manually (`python3 -m tool.asset_pack.upload_ios_background_assets ... check-exists` won't re-poll a specific version; use the ASC UI, or `curl`/the App Store Connect API directly against `GET /v1/backgroundAssetVersions/<id>`) or raise `timeout_seconds` in the workflow if this turns out to be normal/expected latency.

## Xcode version for `ba-package`

`upload-ios` pins its own `IOS_ASSET_PACK_XCODE_VERSION` (currently `26.3`,
matching `deploy-app.yaml`'s `XCODE_VERSION` today) — deliberately **not**
shared with `deploy-app.yaml`'s env var, so bumping one never accidentally
changes app-build reproducibility or vice versa. The workflow's mandatory
"Pre-check: ba-package availability" step runs `xcrun ba-package --help`
before anything else in the job; if it ever fails, bump
`IOS_ASSET_PACK_XCODE_VERSION` in the workflow file (via
`maxim-lobanov/setup-xcode`), not `deploy-app.yaml`'s pin.

## `assetPackID` coordination (`IOS_BACKGROUND_ASSET_PACK_ID`)

The workflow hardcodes `IOS_BACKGROUND_ASSET_PACK_ID: net.yumnumm.eqmonitor.assets`.
This value must be **identical** to:

- the `assetPackID` configured in Xcode's Background Assets capability for the Runner target, and
- the identifier App Store Connect stores for the manually-created asset pack (step 1 of the App Store Connect setup above).

As of this workflow's authoring, no other task has registered the Xcode
capability yet — confirm this value (or change it consistently in all three
places) before the first real run.

## macOS folder-reference check: known simplification

The "Check app/assets/platform is registered as an Xcode folder reference"
step in `sync-macos` greps `app/macos/Runner.xcodeproj/project.pbxproj` for a
`PBXFileReference` line containing both `lastKnownFileType = folder;` (the
literal marker for a "blue folder" reference, as opposed to
`folder.assetcatalog` used by yellow asset-catalog groups) and a `path`
mentioning `platform`. This is a heuristic, not a full pbxproj parse: it does
not resolve the referenced folder's full path through parent group nesting,
so it could theoretically match a same-named folder reference that isn't
actually `app/assets/platform`. Whoever registers the folder reference
(pending task) should double check the sync-macos job goes green for the
right reason, not just because *some* `platform`-named folder reference
exists somewhere in the project.

## Validation performed for this task (no live credentials available)

- `tool/asset_pack/verify_zip.sh` exercised against a hand-built fixture zip
  matching the mandated layout: success case, wrong-sha256 case,
  missing-required-file case, and `pack_version`-mismatch case all produced
  the correct exit code and error message.
- `tool/asset_pack/asc_client.py`'s ES256 JWT builder was cross-verified two
  ways: (1) decoded and validated with Python's `cryptography`/`PyJWT`
  against a generated P-256 test key, and (2) round-tripped its raw r||s
  signature back into DER and verified with `openssl dgst -verify` against
  the same key's public half. It was also smoke-tested against the **real**
  `https://api.appstoreconnect.apple.com` with intentionally-fake
  credentials, which correctly returned a structured `401 NOT_AUTHORIZED`
  JSON:API error (proving the JWT/request are well-formed enough to reach
  Apple's real auth layer) rather than a malformed-request/routing error.
- `mise exec -- actionlint`, `mise exec -- zizmor`, `mise exec -- pinact run
  --check`, and `mise exec -- shellcheck -S error` all pass with zero
  findings for `upload-asset-pack.yaml` / `verify_zip.sh`, both individually
  and across the whole `.github/workflows/` directory (no regressions).

None of this substitutes for a real trigger against a live Background Assets
pack in App Store Connect, a live Play Console module, and a live macOS
`project.pbxproj` folder reference — see the "NOT verified" list above for
exactly what the first real run must confirm.
