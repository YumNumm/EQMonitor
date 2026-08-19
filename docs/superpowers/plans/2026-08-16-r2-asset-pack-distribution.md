# R2 Asset Pack Distribution Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** R2 の署名済みトップレベル manifest と immutable ZIP で Asset Pack を配信し、アプリが同梱Packを既定に手動更新・検証・切替・fallbackできるようにする。

**Architecture:** home8s は R2 bucket と custom domain のみを OpenTofu 管理する。backend は既存 Asset Pack Release ZIP を署名済み manifest とともに公開する。Flutter は同梱rootとdownload rootを共通検証し、`background_downloader` で取得したZIPを検証後にatomic切替する。

**Tech Stack:** Cloudflare provider v5/OpenTofu、TypeScript/Valibot/Node crypto/Vitest/Wrangler、Flutter/Riverpod/background_downloader/archive/cryptography。

## Global Constraints

- CDN base URL は `https://assets.eqmonitor.app/v1/assets`。
- トップレベルは `manifest.json` と `manifest.sig`、Pack は `packs/{version}/asset-pack-v{version}.zip`。
- 自動downloadは禁止し、ユーザー操作後だけ開始する。
- download済み旧版は有効化後に全削除し、アプリ同梱Packは必ず残す。
- 未検証データ、固定値、fake dataへfallbackしない。
- Flutter/Dartコマンドは必ず `mise exec --` 経由で実行する。

---

### Task 1: home8s R2 infrastructure

**Files:**
- Modify: `backend/home8s/terraform/cloudflare/r2.tf`
- Create: `backend/home8s/scripts/test-asset-pack-r2.sh`
- Create: `backend/home8s/docs/knowledge/20260816_eqmonitor_asset_pack_r2.md`

**Interfaces:**
- Produces: bucket `eqmonitor-assets` and custom domain `assets.eqmonitor.app`.
- Excludes: Tunnel ingress、Worker route、API route。

- [ ] `r2.tf` に `cloudflare_r2_bucket.asset_pack` と `cloudflare_r2_custom_domain.asset_pack` の期待値を検証する静的テストを先に追加する。
- [ ] テストを実行し、resource未定義で失敗することを確認する。
- [ ] bucket/custom domain resourceを追加し、`min_tls = "1.2"`、`enabled = true`、zoneは `local.zones["eqmonitor.app"]` とする。
- [ ] `mise exec -- tofu fmt -check -recursive` と `mise exec -- tofu validate` を `backend/home8s/terraform/cloudflare` で実行する。
- [ ] custom domainがTunnelに属さないこととplan/apply順をknowledgeへ記録する。
- [ ] `Feat: Asset Pack用R2バケットを追加` と `Docs: R2配信経路を記録` の粒度でcommitする。

### Task 2: backend distribution schemas and signing

**Files:**
- Create: `backend/packages/types/src/asset-pack-distribution.ts`
- Modify: `backend/packages/types/src/index.ts`
- Create: `backend/packages/types/src/asset-pack-distribution.test.ts`
- Create: `backend/tools/asset-pack/src/signature.ts`
- Create: `backend/tools/asset-pack/src/signature.test.ts`

**Interfaces:**
- Produces: `AssetPackDistributionManifest`, `AssetPackDistributionEntry`, `AssetPackSignatureSidecar` Valibot schemas。
- Produces: `signManifest({ content, privateKeyDerBase64, keyId })` and `verifyManifestSignature({ content, sidecar, publicKey })`。

- [ ] schema testでSemVer、revision、latest先頭一致、archive固定path、SHA-256、ja/en sections、重複versionを拒否する期待を書く。
- [ ] `mise exec -- pnpm --dir packages/types test -- asset-pack-distribution.test.ts` がexport未定義で失敗することを確認する。
- [ ] Valibot schemaと追加のmanifest全体整合性validatorを実装する。
- [ ] Ed25519 known-answer、不正content、未知algorithm/key idを拒否するsignature testを書く。
- [ ] `mise exec -- pnpm --dir tools/asset-pack test -- signature.test.ts` が実装未定義で失敗することを確認する。
- [ ] Node `crypto.sign(null, content, privateKey)` と `crypto.verify` を使い、sidecarの`content_sha256`も検証する。
- [ ] 対象2packageのtest/check-typesを実行し、schemaと署名を別commitにする。

### Task 3: backend immutable ZIP publisher

**Files:**
- Create: `backend/tools/asset-pack/changelog.json`
- Create: `backend/tools/asset-pack/src/distribution-publisher.ts`
- Create: `backend/tools/asset-pack/src/distribution-publisher.test.ts`
- Modify: `backend/tools/asset-pack/src/index.ts`
- Modify: `backend/tools/asset-pack/src/cli.ts`

**Interfaces:**
- Consumes: Release ZIP、現在の署名済みmanifest（初回はnull）、changelog、PKCS#8 private key。
- Produces: `distribution/manifest.json`、`distribution/manifest.sig`、archive metadata。

- [ ] testで初回manifest、append-only更新、過去entry改変拒否、version重複、ZIP size/hash算出を定義する。
- [ ] testを実行しpublisher未定義で失敗することを確認する。
- [ ] `buildDistributionArtifacts` を実装し、JSON bytesを改行込みで決定的に生成してそのbytesを署名する。
- [ ] CLIに `distribution` subcommandと `--zip --changelog --previous-manifest --previous-signature --private-key-base64 --key-id --out-dir` を追加する。
- [ ] CLI testで必須引数、秘密鍵をlogへ出さないこと、生成物名を検証する。
- [ ] `mise exec -- pnpm --dir tools/asset-pack test` とcheck-typesを実行してcommitする。

### Task 4: backend R2 release workflow

**Files:**
- Modify: `backend/.github/workflows/release-asset-pack.yaml`
- Create: `backend/scripts/test-release-asset-pack-r2.sh`
- Modify: `backend/tools/asset-pack/package.json`
- Modify: `backend/pnpm-lock.yaml`
- Create: `backend/docs/knowledge/20260816_asset_pack_r2_release.md`

**Interfaces:**
- Requires: `CLOUDFLARE_API_TOKEN`, `CLOUDFLARE_ACCOUNT_ID`, `ASSET_PACK_SIGNING_PRIVATE_KEY_BASE64`, `ASSET_PACK_SIGNING_KEY_ID`。
- Publishes: ZIP first、`manifest.sig` second、`manifest.json` last。

- [ ] workflow契約testでupload順、immutable `Cache-Control`、manifest revalidation metadata、既存archive拒否を先に定義する。
- [ ] Wranglerを固定devDependencyとして追加する。
- [ ] assemble後に既存manifest/signatureを取得し、publisher CLIを実行するstepを追加する。
- [ ] `wrangler r2 object get` でversion keyが存在する場合は失敗し、put後にcustom domainから再取得してSHA-256を照合する。
- [ ] signatureを先、manifestを最後にputし、公開URLから署名とZIPをend-to-end再検証する。
- [ ] `force_redispatch` 経路でもR2未公開なら指定Releaseをbootstrap公開し、公開済みなら検証だけ行う。
- [ ] actionlint/zizmor/secret scanとpackage testを実行し、workflowとrunbookを分けてcommitする。

### Task 5: bundled Pack resolver and platform cleanup

**Files:**
- Modify: `packages/assets_util/lib/assets_util.dart`
- Modify: `packages/assets_util/lib/src/assets_util_android.dart`
- Modify: `packages/assets_util/android/src/main/kotlin/net/yumnumm/assets_util/AssetsUtil.kt`
- Modify: `packages/assets_util/android/build.gradle.kts`
- Modify: `packages/assets_util/ios/assets_util/Sources/assets_util/EQMAssetsUtil.swift`
- Modify: `packages/assets_util/hook/build.dart`
- Modify: `app/android/settings.gradle.kts`
- Modify: `app/android/app/build.gradle.kts`
- Delete: `app/android/assetpacks/eqmonitor_assets/`
- Modify: `app/ios/Runner.xcodeproj/project.pbxproj`
- Delete: `app/ios/AssetDownloader/`
- Modify: `app/ios/Runner/Info.plist`
- Modify: `app/ios/Runner/Runner.entitlements`
- Delete: `app/ios/AssetDownloader/AssetDownloader.entitlements`
- Delete: `app/ios/AssetDownloader/Info.plist`

**Interfaces:**
- Produces: `AssetsUtil.resolveBundledPackRoot()` returning a read-only bundled root。
- Removes: Managed Background Assets diagnostics/update API and Play Asset Delivery manager dependency。

- [ ] Android testを先に、`flutter_assets/assets/platform` またはbase assetsのPackをversion単位でatomic抽出する期待へ変更する。
- [ ] Swift testを先に、iOS/macOSのbundle `platform/manifest.json` をrootとして返す期待へ変更する。
- [ ] 旧native APIを削除し、同梱root解決だけに縮小する。
- [ ] PAD moduleとBackground Assets extension/capability/Info.plist keyを削除する。
- [ ] Kotlin/Swift/Dart unit tests、`mise exec -- flutter analyze` の対象package実行、Xcode project整合性checkを行う。
- [ ] platform別に30〜100行単位でcommitする。

### Task 6: app remote manifest verification and Pack selection

**Files:**
- Modify: `app/pubspec.yaml` and lockfiles via `flutter pub add`。
- Create: `app/lib/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart`
- Create: `app/lib/feature/asset_pack/data/model/asset_pack_signature.dart`
- Create: `app/lib/feature/asset_pack/data/repository/asset_pack_signature_verifier.dart`
- Create: `app/lib/feature/asset_pack/data/repository/asset_pack_distribution_repository.dart`
- Create: `app/lib/feature/asset_pack/data/repository/asset_pack_storage_repository.dart`
- Modify: `app/lib/feature/asset_pack/data/repository/asset_pack_repository.dart`
- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`
- Test: matching files under `app/test/feature/asset_pack/`。

**Interfaces:**
- Produces: `checkForUpdate()` with ETag/304 and verified bytes。
- Produces: `resolveActivePackRoot()` preferring valid newer download, otherwise bundled。

- [ ] `mise exec -- flutter pub add archive background_downloader cryptography` をappで実行する。
- [ ] manifest parsing/path/rollback/signature known-answer testsを先に書いて失敗を確認する。
- [ ] raw Ed25519 public key registryとbyte列そのものの署名検証を実装する。
- [ ] ETag cache、304、minimum app version、複数世代changelog選択をrepository testで定義して実装する。
- [ ] storage testで同梱優先条件、download破損時fallback、pointer key enum、旧download全削除を定義して実装する。
- [ ] 既存AssetPackRepositoryをactive root resolver注入へ変更し、全asset size/hash検証を維持する。
- [ ] 対象testとcodegenを実行して責務別にcommitする。

### Task 7: background ZIP download, safe extraction, and activation

**Files:**
- Create: `app/lib/feature/asset_pack/data/model/asset_pack_update_state.dart`
- Create: `app/lib/feature/asset_pack/data/repository/asset_pack_archive_extractor.dart`
- Create: `app/lib/feature/asset_pack/data/notifier/asset_pack_update_notifier.dart`
- Create: `app/lib/feature/asset_pack/data/flow/asset_pack_update_flow.dart`
- Test: notifier/extractor/storage/widget tests under `app/test/feature/asset_pack/`。

**Interfaces:**
- States: idle、available、waitingForConsent、downloading(received,total)、verifying、activating、complete、failed(userMessage,retryable)。
- Activation order: archive hash → safe extract → Pack manifest/assets → atomic rename → pointer → provider invalidation → cleanup。

- [ ] extractor testsでabsolute/path traversal/backslash/symlink/duplicate/zip bomb上限を拒否する期待を先に書く。
- [ ] archive extractorを実装し、final directoryを全検証前に公開しない。
- [ ] notifier testで同意前download禁止、進捗、再接続、重複task抑止、失敗時bundle維持を定義する。
- [ ] `background_downloader` のapplicationSupport taskをversion固定task id・`allowPause: true`・status/progress updatesで実装する。
- [ ] 完了後だけ検証・atomic activationを行い、Riverpod providerをinvalidateするflowを実装する。
- [ ] 全状態testとprocess再起動相当のtask復元testを実行してcommitする。

### Task 8: update UI, debug UI, and app startup wiring

**Files:**
- Create: `app/lib/feature/asset_pack/ui/components/asset_pack_update_card.dart`
- Modify: `app/lib/page/home_page.dart`
- Modify: `app/lib/feature/settings/settings_page.dart`
- Replace: `app/lib/feature/settings/children/config/debug/asset_pack/*`
- Modify: `app/lib/app.dart` or startup wiring provider。
- Test: Home card、settings、debug、text scale tests。

**Interfaces:**
- Home/settings share the same notifier state and explicit update action。
- User-visible errors are bounded Japanese messages; raw exception is debug/talker only。

- [ ] Widget testでupdateあり、minimum app mismatch、download進捗、失敗、完了、長文/text scaleを先に定義する。
- [ ] `AssetPackUpdateCard` をHomeの地震履歴cardより前に配置し、同意dialog後だけstartする。
- [ ] settingsへ現在/同梱/remote version、全changelog、再確認入口を追加する。
- [ ] debug画面をCDN/ETag/signature/storage/staging/archive/asset検証状態へ置換する。
- [ ] app起動後に非blockingでmanifest checkとdownloader再接続を開始する。
- [ ] Widget tests、analyze、codegenを実行してUI単位でcommitする。

### Task 9: build staging, legacy removal, and end-to-end verification

**Files:**
- Modify: `tool/asset_pack/stage_from_release.sh` and tests。
- Create: `scripts/ci/test-stage-from-release.sh`
- Modify: `.github/workflows/deploy-app.yaml`
- Delete: `.github/workflows/upload-asset-pack.yaml`
- Delete: obsolete ASC helper scripts/workflow entries used only by Background Assets。
- Update: `docs/asset-pack-cd.md`, `docs/ios-background-assets.md`, relevant knowledge docs。

**Interfaces:**
- iOS/macOS stage full Pack to Xcode bundled `platform/` folder。
- Android stage full Pack to base app assets, not PAD。

- [ ] staging testを先に、iOS/Android/macOSが同じRelease ZIPとpack_versionを使う期待へ変更する。
- [ ] deploy jobsがbuild前にfull Packをstageするよう変更し、iOS slim JMA extractionも維持する。
- [ ] Managed Background Assets upload workflowと専用scripts/configを削除する。
- [ ] shellcheck/actionlint/zizmor、Flutter asset presence check、Android AAB/iOS config buildを実行する。
- [ ] backend fixtureをlocal HTTPで配信し、manifest検出→ZIP取得→改ざん拒否→有効化→旧版cleanup→bundle fallbackを統合testする。
- [ ] `docs/knowledge/20260816_r2_asset_pack_runtime.md` に運用知見を記録し、docsとcleanupを分けてcommitする。

### Task 10: production provisioning and release proof

**Files:** no plaintext secret files。

- [ ] Ed25519 production key pairを一時directoryで生成し、private keyを出力表示せずGitHub secretへ登録する。
- [ ] raw public keyだけをapp key registryへcommitし、key id一致testを実行する。
- [ ] home8s OpenTofu plan/applyでbucket/custom domainを作成し、DNS/TLS readyを確認する。
- [ ] backend workflowを既存latest Releaseでbootstrap実行する。
- [ ] `curl`でmanifest cache headers/ETag、signature、ZIP Range、immutable headersを確認する。
- [ ] appのiOS/Android実機またはCI integrationでbundle offline起動とR2更新を確認する。
- [ ] 各repositoryのstatus/diff/test結果を確認し、明示承認後にpushする。
