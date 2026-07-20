# Platform Asset Base Map Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** iOSとAndroidのベースマップPMTilesを、単一のPlatform AssetからMapLibre Nativeが直接参照するようにする。

**Architecture:** 既存PMTilesを `app/assets/platform/` へ移し、Android assets source setとiOS Runner Bundle Resourcesの両方から同じ実体を登録する。Dart側は `MapStyleUtil` 内の同期的なプラットフォーム分岐だけで、モバイルの `asset://` とmacOS/WebのHTTPSを選択する。

**Tech Stack:** Flutter/Dart、MapLibre Native PMTiles、Android Gradle Kotlin DSL、Xcode project file

## Global Constraints

- PMTilesの内容とファイル名は変更しない。
- iOSとAndroidではHTTPSフォールバックを追加しない。
- macOSとWebのHTTPS参照は維持する。
- Provider、Notifier、MethodChannel、実行時コピー、更新処理を追加しない。
- Glyphおよびベースマップ以外のネットワーク取得は変更しない。
- ユーザーの指定により、新規テストとスモークテストは追加・実行しない。
- Flutter/Dartコマンドは必ず `mise exec --` 経由で実行する。

---

### Task 1: PMTilesをPlatform Assetとして登録

**Files:**
- Move: `app/assets/map/earthquake_tsunami_all.pmtiles` → `app/assets/platform/earthquake_tsunami_all.pmtiles`
- Modify: `app/pubspec.yaml`
- Modify: `app/android/app/build.gradle.kts`
- Modify: `app/ios/Runner.xcodeproj/project.pbxproj`

**Interfaces:**
- Produces: iOS/Androidの `asset://earthquake_tsunami_all.pmtiles`
- Consumes: 既存の `earthquake_tsunami_all.pmtiles` バイナリ

- [ ] **Step 1: 既存PMTilesを移動する**

```bash
mkdir -p app/assets/platform
git mv app/assets/map/earthquake_tsunami_all.pmtiles app/assets/platform/earthquake_tsunami_all.pmtiles
```

- [ ] **Step 2: Flutter Asset登録を削除する**

`app/pubspec.yaml` から次の行を削除する。

```yaml
    - assets/map/
```

- [ ] **Step 3: Android assets source setへ同じディレクトリを登録する**

`app/android/app/build.gradle.kts` の `sourceSets` を次の形にする。

```kotlin
sourceSets {
    getByName("main") {
        java.srcDirs("src/main/kotlin")
        assets.srcDir("../../assets/platform")
    }
}
```

- [ ] **Step 4: iOS Runner Bundle Resourcesへ同じファイルを登録する**

`app/ios/Runner.xcodeproj/project.pbxproj` にPMTilesの `PBXFileReference` と
`PBXBuildFile` を追加し、main groupとRunnerのResources build phaseへ接続する。
ファイル参照は次の相対パスを使用する。

```text
../assets/platform/earthquake_tsunami_all.pmtiles
```

Runner bundle内の出力名は `earthquake_tsunami_all.pmtiles` とする。

- [ ] **Step 5: Asset構成の差分を確認する**

Run:

```bash
git --no-pager diff -- app/pubspec.yaml app/android/app/build.gradle.kts app/ios/Runner.xcodeproj/project.pbxproj
git --no-pager status --short
```

Expected: PMTilesはrenameとして表示され、AndroidとiOSは同じ新パスを参照し、
`app/pubspec.yaml` から `assets/map/` が消えている。

---

### Task 2: ベースマップURIを同期的に分岐

**Files:**
- Modify: `app/lib/feature/map/data/provider/map_style_util.dart`

**Interfaces:**
- Consumes: `kIsWeb` と `defaultTargetPlatform`
- Produces: style JSONの `eqmonitor_map.url`

- [ ] **Step 1: Flutter platform APIをimportする**

```dart
import 'package:flutter/foundation.dart';
```

- [ ] **Step 2: `getStyle` 内でURIを同期的に選択する**

style JSONを作る前に次を追加する。

```dart
final mapSourceUrl = kIsWeb
    ? 'pmtiles://https://v2.map.eqmonitor.app/all.pmtiles'
    : switch (defaultTargetPlatform) {
        .android || .iOS =>
          'pmtiles://asset://earthquake_tsunami_all.pmtiles',
        _ => 'pmtiles://https://v2.map.eqmonitor.app/all.pmtiles',
      };
```

- [ ] **Step 3: vector sourceへ選択済みURIを設定する**

```dart
'eqmonitor_map': {
  'type': 'vector',
  'url': mapSourceUrl,
},
```

- [ ] **Step 4: Dart formatterを実行する**

Run:

```bash
cd app && mise exec -- dart format lib/feature/map/data/provider/map_style_util.dart
```

Expected: `Changed 1 file` または `Formatted 1 file`。

---

### Task 3: 生成Asset参照とドキュメントを更新

**Files:**
- Modify: `app/lib/core/gen/assets.gen.dart`
- Modify: `docs/map_spec_v3.md`
- Create: `docs/knowledge/20260717_maplibre_platform_pmtiles_assets.md`

**Interfaces:**
- Consumes: 更新後の `app/pubspec.yaml` とPlatform Asset構成
- Produces: Flutter Assetから削除済みの生成コード、現行仕様、運用知見

- [ ] **Step 1: コード生成を実行する**

Run:

```bash
cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: `assets.gen.dart` から `$AssetsMapGen` と `Assets.map` が削除される。

- [ ] **Step 2: マップ仕様のタイルソースを更新する**

`docs/map_spec_v3.md` の共通仕様へ次の内容を記載する。

```markdown
| タイルソース | iOS/Android: `pmtiles://asset://earthquake_tsunami_all.pmtiles`、macOS/Web: `pmtiles://https://v2.map.eqmonitor.app/all.pmtiles` (ベクタータイル) |
```

- [ ] **Step 3: Platform固有の知見を記録する**

`docs/knowledge/20260717_maplibre_platform_pmtiles_assets.md` に次を記録する。

````markdown
# MapLibre NativeでPMTilesをPlatform Assetから参照する

## ルール

- iOS/AndroidのMapLibre Nativeは `pmtiles://asset://<filename>` でPMTilesを直接参照できる。
- Flutter AssetからApplication Supportへコピーする処理は不要。
- 単一ファイルをAndroid assets source setとiOS Bundle Resourcesへ登録し、重複管理しない。
- Android/iOSでAsset読込に失敗してもHTTPSへフォールバックしない。

## 構成確認

```bash
rg -n "earthquake_tsunami_all.pmtiles|assets/platform" \
  app/android/app/build.gradle.kts \
  app/ios/Runner.xcodeproj/project.pbxproj \
  app/lib/feature/map/data/provider/map_style_util.dart
```
````

---

### Task 4: 静的検証とコミット

**Files:**
- Verify: Task 1〜3の全変更

**Interfaces:**
- Consumes: Platform Asset登録、URI分岐、生成コード、ドキュメント
- Produces: レビュー可能なコミット

- [ ] **Step 1: 対象Dartファイルを静的解析する**

Run:

```bash
cd app && mise exec -- dart analyze lib/feature/map/data/provider/map_style_util.dart lib/core/gen/assets.gen.dart
```

Expected: `No issues found!`

- [ ] **Step 2: 構成を確認する**

Run:

```bash
rg -n "earthquake_tsunami_all.pmtiles|assets/map/|assets/platform|pmtiles://" \
  app/pubspec.yaml \
  app/android/app/build.gradle.kts \
  app/ios/Runner.xcodeproj/project.pbxproj \
  app/lib/feature/map/data/provider/map_style_util.dart \
  app/lib/core/gen/assets.gen.dart \
  docs/map_spec_v3.md
find app/assets -name 'earthquake_tsunami_all.pmtiles' -print
git --no-pager diff --check
```

Expected: PMTiles実体は `app/assets/platform/` の一つだけ。モバイルURIはasset、
macOS/WebはHTTPS。Flutter生成コードに旧Asset参照はない。`diff --check` は出力なし。

- [ ] **Step 3: 実装差分をコミットする**

```bash
git add app docs
git commit -m "feat: ベースマップをPlatform Assetから参照"
```

- [ ] **Step 4: ブランチをpushする**

```bash
git push origin codex/platform-map-assets
```
