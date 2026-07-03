# App Intents 対応 Phase 2（コントロールセンター + ディープリンク）実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.
>
> **前提:** Phase 1（Issue #1418）マージ後に着手すること。`EarthquakeSnippetIntent` / `EarthquakeFetcher` / `DesignTokens` / `AppFonts` は Phase 1 の成果物。

**Goal:** コントロールセンター／ロック画面／アクションボタンから「地震履歴を開く」「最新の地震をスニペット表示」できるようにし、スニペットの「アプリで開く」ボタンから地震詳細画面へディープリンクで遷移できるようにする。

**Architecture:** Flutter 側は `FlutterDeepLinkingEnabled` を有効化して go_router に着信 URI を処理させる（Dart コード追加は原則不要、ルート定義は既存）。iOS 側は WidgetExtension ターゲットに `ControlWidget` を2つ追加し、`OpenURLIntent` でディープリンクを発火する。スニペット表示コントロールは Phase 1 の `EarthquakeSnippetIntent` を再利用する。

**Tech Stack:** Swift / WidgetKit ControlWidget (iOS 18+, 本プロジェクトは 26.0) / AppIntents OpenURLIntent / go_router / Flutter deep linking

## Global Constraints

- ディープリンク URL スキームは `deeplink.eqmonitor.app`（`app/ios/Runner/Info.plist` 登録済み）。URL 形式は `deeplink.eqmonitor.app://app<path>` とし、go_router のパス（例: `/earthquake-history`、`/earthquake-history-details/:eventId`）に対応させる。
- コントロールは WidgetExtension ターゲット（iOS 26.0）に追加し、`EQMonitorWidgetBundle` に登録する。
- Android 側の挙動は変更しない（`FlutterDeepLinkingEnabled` は iOS の Info.plist キーであり Android に影響しないが、AndroidManifest に intent-filter を追加しないこと＝iOS のみの対応に留める）。
- コミットは develop から切ったフィーチャーブランチ（例: `feat/app-intents-controls`）。PR は `--repo YumNumm/EQMonitor`、base `develop`。
- ビルド検証は Phase 1 計画の「共通ビルド」コマンドを使用。

---

### Task 1: FlutterDeepLinkingEnabled 有効化と go_router 遷移検証

**Files:**
- Modify: `app/ios/Runner/Info.plist:48-49`（`FlutterDeepLinkingEnabled` を `true` に）

**Interfaces:**
- Produces: `deeplink.eqmonitor.app://app/<go_router path>` で iOS からアプリ内画面遷移が可能になる。

- [ ] **Step 1: `false` になっている経緯を確認**

```bash
cd app && git log -S "FlutterDeepLinkingEnabled" --oneline -- ios/Runner/Info.plist
git log -p -1 -S "FlutterDeepLinkingEnabled" -- ios/Runner/Info.plist | head -40
```

意図的に無効化した形跡（コミットメッセージ・関連 Issue）があれば、その理由を解消できるか判断してから進む。単なるテンプレート初期値なら続行。

- [ ] **Step 2: Info.plist を変更**

```xml
<key>FlutterDeepLinkingEnabled</key>
<true/>
```

- [ ] **Step 3: シミュレータで遷移検証**

```bash
cd app && flutter run -d <simulator> &
# アプリ起動後:
xcrun simctl openurl booted 'deeplink.eqmonitor.app://app/earthquake-history'
xcrun simctl openurl booted 'deeplink.eqmonitor.app://app/earthquake-history-details/<実在eventId>'
```

期待: 地震履歴／地震詳細画面へ遷移する。遷移しない場合は go_router が受け取る location（host 部の扱い）を `GoRouter.optionURLReflectsImperativeAPIs` やログで確認し、必要なら `redirect` で `uri.host == 'app'` のとき `uri.path` へ誘導する処理を `app/lib/core/router/router.dart` に追加する。

- [ ] **Step 4: Google Sign-In の非干渉確認**

Google ログイン（設定画面）を実行し、コールバック（`com.googleusercontent.apps.*` スキーム）が従来どおり動くことを確認。

- [ ] **Step 5: Commit**

```bash
git add app/ios/Runner/Info.plist app/lib/core/router/ && git commit -m "feat(ios): ディープリンクを有効化"
```

---

### Task 2: スニペットに「アプリで開く」ボタンを追加

**Files:**
- Modify: `app/ios/AppIntentExtension/EarthquakeSnippetView.swift`（Phase 1 成果物）

**Interfaces:**
- Consumes: `EarthquakeDisplayItem.id`（eventId）、`OpenURLIntent`
- Produces: スニペット各行 or フッターの「アプリで開く」ボタン

- [ ] **Step 1: ボタン追加**

```swift
// EarthquakeSnippetView のフッター（「更新」ボタンの隣）に追加
if let first = items.first,
   let url = URL(string: "deeplink.eqmonitor.app://app/earthquake-history-details/\(first.id)") {
    Button(intent: OpenURLIntent(url)) {
        Label("アプリで開く", systemImage: "arrow.up.forward.app")
    }
}
```

複数件表示時は先頭（最新）の詳細へ。行ごとのタップ遷移は snippet の制約（Button のみインタラクティブ）を確認した上で、可能なら各行にも `Button(intent: OpenURLIntent(...))` を張る。

- [ ] **Step 2: 共通ビルド → シミュレータでスニペットのボタンから詳細画面へ遷移することを確認**

- [ ] **Step 3: Commit**

```bash
git add app/ios && git commit -m "feat(ios/intents): スニペットにアプリで開くボタンを追加"
```

---

### Task 3: 「地震履歴を開く」コントロール

**Files:**
- Create: `app/ios/Widget/Controls/OpenEarthquakeHistoryControl.swift`（WidgetExtension ターゲット）
- Modify: `app/ios/Widget/WidgetBundle.swift`

**Interfaces:**
- Produces: コントロールセンターに配置可能な「地震履歴」ボタン

- [ ] **Step 1: 実装**

```swift
import WidgetKit
import SwiftUI
import AppIntents

struct OpenEarthquakeHistoryControl: ControlWidget {
    static let kind = "net.yumnumm.eqmonitor.control.open-earthquake-history"

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: Self.kind) {
            ControlWidgetButton(action: OpenEarthquakeHistoryIntent()) {
                Label("地震履歴", systemImage: "clock.arrow.circlepath")
            }
        }
        .displayName("地震履歴を開く")
        .description("EQMonitor の地震履歴を開きます")
    }
}

struct OpenEarthquakeHistoryIntent: AppIntent {
    static let title: LocalizedStringResource = "地震履歴を開く"
    static let openAppWhenRun = true

    func perform() async throws -> some IntentResult & OpensIntent {
        .result(opensIntent: OpenURLIntent(
            URL(string: "deeplink.eqmonitor.app://app/earthquake-history")!))
    }
}
```

- [ ] **Step 2: WidgetBundle に登録**

```swift
// EQMonitorWidgetBundle.body に追加
OpenEarthquakeHistoryControl()
```

- [ ] **Step 3: 共通ビルド → シミュレータのコントロールセンター編集で「地震履歴を開く」を追加し、タップで地震履歴画面が開くことを確認**

- [ ] **Step 4: Commit**

```bash
git add app/ios && git commit -m "feat(ios/widget): 地震履歴を開くコントロールを追加"
```

---

### Task 4: 「最新の地震スニペット」コントロール（スパイク含む）

**Files:**
- Create: `app/ios/Widget/Controls/LatestEarthquakeSnippetControl.swift`
- Modify: `app/ios/Runner.xcodeproj/project.pbxproj`（`EarthquakeSnippetIntent` 一式を WidgetExtension ターゲットにもメンバーシップ追加）
- Modify: `app/ios/Widget/WidgetBundle.swift`

**Interfaces:**
- Consumes: `EarthquakeSnippetIntent`（Phase 1）、`EarthquakeFetcher`、`EarthquakeSnippetView`
- Produces: コントロールセンターから直接スニペットを表示するボタン

- [ ] **Step 1: 【スパイク】コントロールから SnippetIntent が表示できるか検証**

`EarthquakeSnippetIntent` / `EarthquakeFetcher` / `EarthquakeSnippetView` / `EarthquakeEntity` / `MinIntensityOption` のソースを WidgetExtension ターゲットのメンバーシップに追加し、以下を実装してビルド・実機/シミュレータで確認する:

```swift
struct LatestEarthquakeSnippetControl: ControlWidget {
    static let kind = "net.yumnumm.eqmonitor.control.latest-earthquake"

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: Self.kind) {
            ControlWidgetButton(action: EarthquakeSnippetIntent(
                regionID: nil, minIntensity: nil, limit: 3)) {
                Label("最新の地震", systemImage: "waveform.path.ecg")
            }
        }
        .displayName("最新の地震を確認")
        .description("アプリを開かずに最新の地震情報を表示します")
    }
}
```

判定: コントロールセンターのボタンタップでスニペットカードが表示されるか。

- [ ] **Step 2: スパイク結果に応じて確定**

- **表示できる場合**: Step 1 の実装のまま WidgetBundle に登録。
- **表示できない場合**: `ControlWidgetButton(action:)` を `OpenEarthquakeHistoryIntent` 同様の「アプリを開く」動作（`OpenURLIntent` で地震履歴へ）に差し替え、displayName は「地震履歴を開く（最新の地震）」等に調整。スパイク結果を Issue にコメントで記録する。

- [ ] **Step 3: 共通ビルド → 手動確認 → Commit**

```bash
git add app/ios && git commit -m "feat(ios/widget): 最新地震スニペットのコントロールを追加"
```

---

### Task 5: 総合検証と PR

- [ ] **Step 1: 検証チェックリスト**

- コントロールセンター編集画面に EQMonitor のコントロールが2つ表示される
- ロック画面・アクションボタン（実機のみ）への割り当てが可能
- 「地震履歴を開く」→ アプリの地震履歴画面が直接開く
- スニペットコントロール → カード表示（またはフォールバック動作）
- スニペットの「アプリで開く」→ 該当地震の詳細画面が開く
- Google Sign-In・FCM 通知タップなど既存の URL/通知経路が壊れていない

- [ ] **Step 2: PR 作成**

```bash
gh pr create --repo YumNumm/EQMonitor --base develop \
  --title "feat(ios): App Intents対応 Phase 2 — コントロールセンターとディープリンク" \
  --body "(検証結果・スパイク判定を記載)"
```
