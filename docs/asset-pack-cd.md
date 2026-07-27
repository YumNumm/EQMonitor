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

**Private Release download:** `eqmonitor-backend` is private, so the zip must
be fetched with authentication. `download-and-verify` issues a GitHub App
token (`vars.EQMONITOR_GITHUB_APP_ID` / `secrets.EQMONITOR_GITHUB_APP_PRIVATE_KEY`,
`repositories: eqmonitor-backend`, `permission-contents: read` — same App as
integration tests) and uses `gh release download`. Unauthenticated `curl` of
`artifact_url` returns 404.

## What the workflow automates today

| Stage | Automated? | Notes |
|---|---|---|
| Download + sha256 verify + structure assert + `pack_version` match | Yes | GitHub App token で private Release を取得し Artifact 化 |
| iOS Managed Background Assets upload | Yes | `ba-package` → ASC API（パック未作成なら `POST /v1/backgroundAssets` で作成） |
| Android Play Asset Delivery contents | **Not in this workflow** | `deploy-app.yaml` の `build-android` が `tool/asset_pack/stage_from_release.sh` で最新 Release をビルド直前に展開 |
| macOS bundled assets | **Not in this workflow** | ローカル / 将来の macOS CI で同じ `stage_from_release.sh --target macos` を使う。git にはコミットしない |

**pmtiles はリポジトリに置かない。** 正本は常に `eqmonitor-backend` の `asset-pack-v*` Release。Git LFS / sync-PR は使わない（100MB 制限を踏むだけなので廃止）。


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

**What this means for automation:** Play ties install-time asset packs to a
full AAB upload, so there is no independent "upload asset pack only" path.
Instead, `deploy-app.yaml` stages the latest `asset-pack-v*` Release into
`app/android/assetpacks/eqmonitor_assets/src/main/assets/` immediately before
`flutter build appbundle` via `tool/asset_pack/stage_from_release.sh`. The new
pack therefore ships with the next Android app release — not via a git PR of
binaries. Staged files are gitignored.

If a faster path is ever needed, the two realistic options are (a) switch this
asset pack to **on-demand** delivery, which supports `bundletool
build-apks`/`install-apks` workflows closer to independent updates, or (b)
accept the "ships with the next app release" cadence permanently and instead
tighten `deploy-app.yaml`'s release cadence.

### 2. App Store Connect: Managed Background Assets

The iOS job (`upload-ios`) packages the Release zip with `xcrun ba-package`
and uploads via App Store Connect API. If the `backgroundAssets` record for
`eqmonitor-assets` does not exist yet, the job creates it
(`POST /v1/backgroundAssets`) before creating a version and uploading.

**One-time / ongoing alignment:**

1. Xcode Runner target Background Assets capability の asset pack ID は
   **`eqmonitor-assets`**（ドット付き reverse-DNS は ASC が拒否 — ITMS-91133）。
   `packages/assets_util` の `_iosAssetPackIdentifier` と一致させる。
2. Info.plist: `BAHasManagedAssetPacks` / `BAUsesAppleHosting` / `BAAppGroupID`
   （リポジトリ済み）。
3. `AssetDownloader` ExtensionKit target（リポジトリ済み）。

Manual Transporter upload remains a fallback if the API path fails
(see below).

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
  entries' shape, `sourceFileChecksums` (MD5 via the Checksums type; the
  deprecated `sourceFileChecksum` attribute must not be used on ASC API 4.1+),
  the terminal processing state
  name). `tool/asset_pack/asc_client.py`'s module docstring has the full
  "UNVERIFIED SURFACE WARNING" and cites why this shape was chosen (it
  mirrors the reservation/upload/commit pattern used by every other ASC API
  asset-upload family — appScreenshots, appPreviews, buildIcons — which has
  been stable for years).
- The exact filename/extension `ba-package` writes its output archive as.
  Confirmed locally (Xcode 27 / `ba-package` CLI): use the `package`
  subcommand with `--output-path` / `-o`, and the path **must** end with
  `.aar` — see `docs/knowledge/20260728_ba_package_cli.md`.
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

1. Open App Store Connect → the app (`ASC_APP_ID` `6447546703`) → **Background Assets** → the pack matching `IOS_BACKGROUND_ASSET_PACK_ID` (`eqmonitor-assets`).
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

The workflow hardcodes `IOS_BACKGROUND_ASSET_PACK_ID: eqmonitor-assets`.
This value must be **identical** to:

- the `assetPackID` configured in Xcode's Background Assets capability for the Runner target, and
- the identifier App Store Connect stores for the manually-created asset pack (step 1 of the App Store Connect setup above).

As of 2026-07-28, the Xcode side registers this via the `AssetDownloader`
ExtensionKit target and `Runner/Info.plist` BA keys — confirm the Apple
Developer portal capability and App Store Connect pack use the same id before
the first `upload-ios` run.

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
