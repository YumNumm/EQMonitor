# MapLibre Native Metal Clip Mask Fix Distribution Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** PR #4342を適用した最新MapLibre NativeのiOS XCFrameworkをYumNumm配下から配布し、EQMonitorで固定利用してfill欠損を解消する。

**Architecture:** `YumNumm/maplibre-native`のソースブランチでupstream `main`へPR #4342の2コミットを適用し、生成したXCFrameworkは同リポジトリのGitHub Release Assetとして公開する。別の配布ブランチにはRelease Assetをchecksum付きで参照するSwiftPM manifestだけを置き、SemVerタグを付けて`YumNumm/flutter-maplibre`から固定参照する。

**Tech Stack:** MapLibre Native, Metal, Bazel, XCFramework, Swift Package Manager, Flutter, GitHub Actions/Releases

**Spec:** `docs/knowledge/20260823_ios_maplibre_metal_clip_mask.md`

## Global Constraints

- GitHub上の作成・push・Release操作はYumNumm org配下だけで行い、upstreamへPRやIssueを作成しない。
- MapLibre Nativeは作業開始時点のupstream `main` commitを固定し、PR #4342の全2コミットを適用する。
- EQMonitorとflutter-maplibreは可変ブランチではなく、検証済みcommit/tagへ固定する。
- XCFrameworkのSHA-256 checksumをSwiftPM manifestへ記録し、Release Assetの改変を検出できるようにする。
- 提示されたPMTilesを使い、iOS Simulatorでfill欠損の再現条件を確認する。

---

### Task 1: Native forkと修正ブランチ

**Files:**
- Modify: `YumNumm/maplibre-native` Git refs

**Interfaces:**
- Consumes: upstream `maplibre/maplibre-native:main`, PR #4342 head commits
- Produces: PR #4342を含む固定source commit

- [ ] **Step 1:** `YumNumm/maplibre-native`をGitHub forkとして作成する。
- [ ] **Step 2:** upstream最新`main`を取得し、PR #4342の2コミットを順番どおり適用する。
- [ ] **Step 3:** `src/mbgl/mtl/context.cpp`のunbind処理とMetal回帰テストが含まれることをdiffで確認する。
- [ ] **Step 4:** 対象Metalテストを実行し、成功を確認する。
- [ ] **Step 5:** 修正ブランチをYumNumm forkへpushする。

### Task 2: XCFramework Release

**Files:**
- Modify: `YumNumm/maplibre-native/.github/workflows/ios-yumnumm-release.yml`

**Interfaces:**
- Consumes: Task 1の固定source commit
- Produces: `MapLibre.dynamic.xcframework.zip`とchecksum

- [ ] **Step 1:** 公式iOS release workflowからMetal dynamic XCFrameworkのビルド部分だけを抽出する。
- [ ] **Step 2:** fork所有者と対象commitを検証し、YumNumm側GitHub Releaseへだけアップロードするworkflowを作成する。
- [ ] **Step 3:** workflowの構文と参照actionを確認してcommit・pushする。
- [ ] **Step 4:** workflowをdispatchし、完了まで監視する。
- [ ] **Step 5:** Release Assetをダウンロードして`swift package compute-checksum`を実行する。

### Task 3: 同一fork内SwiftPM配布ブランチ

**Files:**
- Create: `YumNumm/maplibre-native:spm-distribution/Package.swift`

**Interfaces:**
- Consumes: Task 2のRelease URLとchecksum
- Produces: `MapLibre` productを提供する固定SemVerタグ

- [ ] **Step 1:** orphanの`spm-distribution`ブランチを作成する。
- [ ] **Step 2:** Release Assetを`binaryTarget(name:url:checksum:)`で参照する`Package.swift`を作成する。
- [ ] **Step 3:** `swift package dump-package`でmanifestを検証する。
- [ ] **Step 4:** 配布commitをpushし、SemVerタグを付けてpushする。
- [ ] **Step 5:** 一時Swift packageからタグを解決し、XCFrameworkの取得とchecksum検証が成功することを確認する。

### Task 4: flutter-maplibreのNative依存切り替え

**Files:**
- Modify: `packages/maplibre_ios/ios/maplibre_ios/Package.swift`

**Interfaces:**
- Consumes: Task 3のYumNumm MapLibre配布タグ
- Produces: EQMonitorから固定参照できるflutter-maplibre commit

- [ ] **Step 1:** `YumNumm/flutter-maplibre`を隔離checkoutし、現在のEQMonitor固定commitを基点にブランチを作成する。
- [ ] **Step 2:** iOS package dependencyをYumNumm forkのexactタグへ変更する。
- [ ] **Step 3:** `swift package resolve`とiOS package testsで依存解決を検証する。
- [ ] **Step 4:** 差分をcommitしてYumNumm forkへpushする。

### Task 5: EQMonitor導入とiOS回帰検証

**Files:**
- Modify: `app/pubspec.yaml`
- Modify: `pubspec.lock`
- Modify: `app/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved`
- Modify: `app/ios/Runner.xcworkspace/xcshareddata/swiftpm/Package.resolved`
- Modify: `docs/knowledge/20260823_ios_maplibre_metal_clip_mask.md`

**Interfaces:**
- Consumes: Task 4のflutter-maplibre固定commit、提示されたPMTiles
- Produces: 修正版Native binaryを固定利用するEQMonitor commit

- [ ] **Step 1:** 6個のflutter-maplibre dependency overrideをTask 4のcommitへ更新する。
- [ ] **Step 2:** `mise exec -- flutter pub get`でlockfileを更新する。
- [ ] **Step 3:** XcodeのSwiftPM解決結果がYumNumm Native配布タグとchecksum付きReleaseを参照することを確認する。
- [ ] **Step 4:** 関連静的解析・既存テスト・iOSビルドを実行する。
- [ ] **Step 5:** iOS Simulatorで提示された地震履歴詳細を表示し、カメラ移動を含めfill欠損が再発しないことを確認する。
- [ ] **Step 6:** source commit、配布タグ、checksum、検証結果をknowledge文書へ追記する。
- [ ] **Step 7:** EQMonitor差分を分割commitしてpushする。
