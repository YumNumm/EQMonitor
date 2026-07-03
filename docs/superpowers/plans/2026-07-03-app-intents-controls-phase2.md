# App Intents 対応 Phase 2（コントロールセンター + ディープリンク）実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.
>
> **前提:** Phase 1（Issue #1418）マージ後に着手すること。`EarthquakeSnippetIntent` / `EarthquakeFetcher` / `DesignTokens` / `AppFonts` は Phase 1 の成果物。

**Goal:** コントロールセンター／ロック画面／アクションボタンから「地震履歴を開く」「最新の地震をスニペット表示」できるようにし、スニペットの「アプリで開く」ボタンから地震詳細画面へディープリンクで遷移できるようにする。

**Architecture:** Flutter 側は `app_links` プラグインで OS レベルのディープリンク（`eqmonitor:///<path>`）を受信し、既存の `NotificationDeepLink` の検証ロジック（スキーム + allowlist）を共用して go_router で自前ルーティングする（`FlutterDeepLinkingEnabled` は false のまま）。iOS 側は WidgetExtension ターゲットに `ControlWidget` を2つ追加し、`OpenURLIntent` でディープリンクを発火する。スニペット表示コントロールは Phase 1 の `EarthquakeSnippetIntent` を再利用する。

**Tech Stack:** Swift / WidgetKit ControlWidget (iOS 18+, 本プロジェクトは 26.0) / AppIntents OpenURLIntent / go_router / Flutter deep linking

## Global Constraints

- **`FlutterDeepLinkingEnabled` は `false` のまま変更しない**（Flutter の自動ルーティングは使わない。ユーザー指示 2026-07-03）。OS レベルのディープリンクは `app_links` プラグインで受信し、既存の `NotificationDeepLink`（`app/lib/core/fcm/notification_deep_link.dart`）の検証ロジックを共用して自前でルーティングする。
- ディープリンク URL は通知の link 契約と同一形式 `eqmonitor:///<path>`（スキーム `eqmonitor`・host 空）。`app/ios/Runner/Info.plist` の CFBundleURLTypes へ `eqmonitor` スキームを追加登録する。
- **`app/ios/Runner.xcodeproj/project.pbxproj` は編集禁止**（ユーザーが Xcode で操作する。必要になったら操作内容を明示して依頼し完了を待つ）。`Widget/`・`AppIntentExtension/` は synchronized folder のため配下への新規ファイル追加は pbxproj 変更不要。
- コントロールは WidgetExtension ターゲット（iOS 26.0）に追加し、`EQMonitorWidgetBundle` に登録する。
- Android 側の挙動は変更しない（`FlutterDeepLinkingEnabled` は iOS の Info.plist キーであり Android に影響しないが、AndroidManifest に intent-filter を追加しないこと＝iOS のみの対応に留める）。
- コミットは develop から切ったフィーチャーブランチ（例: `feat/app-intents-controls`）。PR は `--repo YumNumm/EQMonitor`、base `develop`。
- ビルド検証は Phase 1 計画の「共通ビルド」コマンドを使用。

---

### Task 1: app_links による OS ディープリンク受信（ユーザー承認済み構成）

**Files:**
- Modify: `app/pubspec.yaml`（`app_links` を dependencies に追加 → `flutter pub get`）
- Modify: `app/ios/Runner/Info.plist`（CFBundleURLTypes に `eqmonitor` スキームを追加。`FlutterDeepLinkingEnabled` は false のまま）
- Modify: `app/lib/core/fcm/notification_deep_link.dart`（`fromUri(Uri)` 追加・allowlist に `/earthquake-history` 追加）
- Create: `app/lib/core/provider/app_links_interaction.dart`（公開 Provider は1つ）
- Modify: `app/lib/page/splash_page.dart`（コールド起動の pending 消費に app_links 分を追加）

**Interfaces:**
- Consumes: `NotificationDeepLink` / `goRouterProvider` / `firebase_messaging_interaction.dart` の pending パターン
- Produces:
  - `NotificationDeepLink.fromUri(Uri uri) -> NotificationDeepLink?` — スキーム `eqmonitor` + allowlist（`/earthquake-history-details/`・`/feed/source/`・完全一致 `/earthquake-history`）を検証し `NotificationRouteLink` を返す。https/http は `NotificationUrlLink`（fromData と同じ規則）
  - `appLinksInteraction`（`@Riverpod(keepAlive: true)` の Stream provider）— `AppLinks().getInitialLink()` は pending に積み splash で消費、`uriLinkStream` は `goRouterProvider.push`
  - `eqmonitor:///earthquake-history` / `eqmonitor:///earthquake-history-details/{eventId}` で OS からアプリ内遷移が可能になる

- [ ] **Step 1: `app_links` を追加し pub get**

- [ ] **Step 2: `NotificationDeepLink.fromUri` と allowlist 拡張を実装（fromData は fromUri を再利用する形にリファクタしてよい）**

- [ ] **Step 3: `appLinksInteraction` provider を実装**（`firebase_messaging_interaction.dart` と同構造。provider は既存のmessaging interactionと同じ場所で ref.watch されるよう配線 — 配線箇所は `firebaseMessagingInteractionProvider` を watch している場所を grep して同じ場所に追加）

- [ ] **Step 4: Info.plist に `eqmonitor` スキームを追加**（既存の CFBundleURLTypes 配列に dict を追加。`FlutterDeepLinkingEnabled` は変更しない）

- [ ] **Step 5: `dart analyze` と `dart format` を通し、シミュレータで遷移検証**

```bash
xcrun simctl openurl booted 'eqmonitor:///earthquake-history'
xcrun simctl openurl booted 'eqmonitor:///earthquake-history-details/<実在eventId>'
```

期待: フォアグラウンド時に地震履歴／地震詳細へ push 遷移。コールド起動（アプリ kill 後に openurl）でも遷移する。

- [ ] **Step 6: Commit**

```bash
git add app/ && git commit -m "feat(app): app_links による OS ディープリンク受信を追加"
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
   let url = URL(string: "eqmonitor:///earthquake-history-details/\(first.id)") {
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
            URL(string: "eqmonitor:///earthquake-history")!))
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
