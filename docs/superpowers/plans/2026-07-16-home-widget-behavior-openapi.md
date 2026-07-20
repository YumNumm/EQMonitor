# Home Widget Behavior and Swift OpenAPI Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** iOS 地震履歴 Widget の overflow・現在地・詳細遷移を修正し、最新 OpenAPI から Swift コードを再生成する。

**Architecture:** Widget の表示件数と deep-link URL は Shared の純粋ロジックへ分離する。現在地はテスト可能な位置ローダー経由で App Group に同期し、Swift API は backend の正準 JSON から決定論的に再生成する。

**Tech Stack:** SwiftUI / WidgetKit / AppIntents / Swift Testing / Flutter / Riverpod / Geolocator / swift-openapi-generator

## Global Constraints

- Flutter / Dart コマンドは必ず `mise exec --` 経由で実行する。
- 位置情報を固定値や推測値へフォールバックしない。
- Widget のテキスト可読性を維持し、固定高さによる overflow を作らない。
- 生成 Swift コードは手書き編集しない。

---

### Task 1: 現在地 App Group 同期

**Files:**
- Create: `app/lib/core/provider/widget_current_location_loader.dart`
- Create: `app/test/core/provider/widget_current_location_loader_test.dart`
- Modify: `app/lib/core/provider/app_group_settings_writer.dart`
- Modify: `app/test/core/provider/app_group_settings_writer_test.dart`

**Interfaces:**
- Produces: `WidgetCurrentLocationLoader.load()` が許可済み位置を返す。
- Produces: `writeCurrentLocationRegionToAppGroup(..., clearWhenUnavailable: false)` が一時失敗時に既存値を保持する。

- [ ] 位置ローダーと既存値保持の failing test を追加する。
- [ ] `mise exec -- flutter test` で期待した失敗を確認する。
- [ ] last-known → current-position の最小実装と保存 semantics を実装する。
- [ ] build_runner、対象 test、analyze を実行する。
- [ ] `fix: Widget現在地の地域同期を安定化` としてコミットする。

### Task 2: Widget layout と deep link

**Files:**
- Create: `app/ios/Shared/WidgetLayoutPolicy.swift`
- Create: `app/ios/Shared/EarthquakeDetailURL.swift`
- Modify: `app/ios/WidgetModelsTests/EarthquakeDisplayItemTests.swift`
- Modify: `app/ios/Widget/Views/EarthquakeWidgetView.swift`
- Modify: `app/ios/Runner.xcodeproj/project.pbxproj`

**Interfaces:**
- Produces: `WidgetLayoutPolicy.maxItemCount(family:availableHeight:) -> Int`。
- Produces: `EarthquakeDetailURL.make(eventId:) -> URL?`。

- [ ] family / 高さ別件数と URL の failing test を追加する。
- [ ] WidgetModelsTests で期待した失敗を確認する。
- [ ] Shared 型を実装し、各 Widget 行を `Link` で包む。
- [ ] WidgetModelsTests と Widget extension build を実行する。
- [ ] `fix: Widget表示件数と地震詳細遷移を修正` としてコミットする。

### Task 3: Swift OpenAPI 再生成

**Files:**
- Regenerate: `app/ios/Packages/EQMonitorAPI/Sources/EQMonitorAPI/openapi.json`
- Regenerate: `app/ios/Packages/EQMonitorAPI/Sources/EQMonitorAPI/GeneratedSources/Client.swift`
- Regenerate: `app/ios/Packages/EQMonitorAPI/Sources/EQMonitorAPI/GeneratedSources/Types.swift`
- Modify only if contract drift requires: `app/ios/Packages/EQMonitorAPI/Tests/EQMonitorAPITests/fixtures/*.json`

**Interfaces:**
- Consumes: `backend/api/api/openapi.json`。
- Produces: 最新 backend contract に対応する `EQMonitorAPI`。

- [ ] backend OpenAPI をコピーし Swift 互換パッチを適用する。
- [ ] generator で Client / Types を再生成する。
- [ ] `mise exec -- swift test` を実行し fixture drift を確認する。
- [ ] 必要な fixture だけ正準レスポンスへ更新し再テストする。
- [ ] `Update: Swift OpenAPIを再生成` としてコミットする。

### Task 4: 全体検証と Draft PR

**Files:**
- Modify if new reusable knowledge exists: `docs/knowledge/20260716_home_widget_validation.md`

- [ ] `git --no-pager diff` と生成差分を確認する。
- [ ] Flutter 対象 test / analyze、Swift package test、WidgetModelsTests、Widget extension build を fresh 実行する。
- [ ] コードレビューで Critical / Important 指摘がないことを確認する。
- [ ] branch を push し、変更理由・根本原因・検証結果を含む `develop` 向け Draft PR を作成する。
