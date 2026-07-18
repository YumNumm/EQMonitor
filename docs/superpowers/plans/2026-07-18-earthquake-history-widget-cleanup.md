# Earthquake History Widget Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地図 Widget を廃止し、地震履歴 Widget のヘッダーをブランド色帯に整理する（アイコン・更新ボタン削除、M・small バッジサイズ調整）。

**Architecture:** iOS Widget フォルダは `PBXFileSystemSynchronizedRootGroup` のため、ファイル削除だけで Xcode 参照は追随する。UI 変更は `EarthquakeWidgetView.swift` に集中し、行構造・Timeline・地域解決・deep link は触らない。

**Tech Stack:** SwiftUI / WidgetKit / `DesignTokens`（`Color.eqBrand`）/ `AppFonts`

## Global Constraints

- Spec: `docs/superpowers/specs/2026-07-18-earthquake-history-widget-cleanup-design.md`
- 行レイアウトの EEW 風作り替えはしない
- タイムライン取得・地域解決・deep link・表示件数ポリシーは変更しない
- Android は対象外
- ヘッダー背景は `Color.eqBrand`（ストライプなし）
- コミットは develop から切ったフィーチャーブランチ。PR は `--repo YumNumm/EQMonitor`、base `develop`
- Flutter / Dart コマンドは `mise exec --` 経由（本プランは Swift のみ）

## File map

| 操作 | パス | 役割 |
|------|------|------|
| Delete | `app/ios/Widget/MapEarthquakeWidget.swift` | 地図 Widget 定義 |
| Delete | `app/ios/Widget/Views/MapEarthquakeWidgetView.swift` | 地図 UI / MapSnapshot |
| Modify | `app/ios/Widget/WidgetBundle.swift` | 地図登録を外す |
| Modify | `app/ios/Widget/Views/EarthquakeWidgetView.swift` | ヘッダー・行サイズ・更新ボタン削除 |
| Modify | `app/ios/Widget/AppIntent.swift` | `RefreshWidgetIntent` 削除 |
| Keep | `app/ios/Widget/Widget.swift` | Timeline / EarthquakeWidget 本体（変更なし） |
| Keep | `app/ios/Shared/IntensityBadge.swift` | バッジ本体（呼び出し側の size のみ変更） |

---

### Task 1: 地図 Widget を削除する

**Files:**
- Delete: `app/ios/Widget/MapEarthquakeWidget.swift`
- Delete: `app/ios/Widget/Views/MapEarthquakeWidgetView.swift`
- Modify: `app/ios/Widget/WidgetBundle.swift`

**Interfaces:**
- Consumes: なし
- Produces: Bundle に `EarthquakeWidget`（＋ Live Activity / Controls）のみ残る状態

- [ ] **Step 1: フィーチャーブランチを切る**

```bash
git fetch origin develop
git checkout develop
git pull --ff-only origin develop
git checkout -b feat/earthquake-history-widget-cleanup
```

- [ ] **Step 2: 地図 Widget ファイルを削除する**

```bash
rm app/ios/Widget/MapEarthquakeWidget.swift
rm app/ios/Widget/Views/MapEarthquakeWidgetView.swift
```

- [ ] **Step 3: WidgetBundle から地図登録を外す**

`app/ios/Widget/WidgetBundle.swift` を次の内容にする:

```swift
//
//  WidgetBundle.swift
//  Widget
//
//  Created by 尾上 遼太朗 on 2025/10/09.
//

import WidgetKit
import SwiftUI

@main
struct EQMonitorWidgetBundle: WidgetBundle {
    var body: some Widget {
        EarthquakeWidget()
        if #available(iOS 16.1, *) {
            EewLiveActivityWidget()
            ShakeDetectionLiveActivityWidget()
        }
        if #available(iOS 18.0, *) {
            OpenEarthquakeHistoryControl()
            LatestEarthquakeSnippetControl()
        }
    }
}
```

- [ ] **Step 4: 残留参照がないことを確認する**

```bash
rg 'MapEarthquake|MapSnapshotView' app/ios --glob '*.swift'
```

Expected: マッチなし

- [ ] **Step 5: Commit**

```bash
git add app/ios/Widget/WidgetBundle.swift
git add -u app/ios/Widget/MapEarthquakeWidget.swift app/ios/Widget/Views/MapEarthquakeWidgetView.swift
git commit -m "$(cat <<'EOF'
remove: 地震情報マップWidgetを削除

EOF
)"
```

---

### Task 2: 地震履歴 Widget のヘッダーとサイズを更新する

**Files:**
- Modify: `app/ios/Widget/Views/EarthquakeWidgetView.swift`
- Modify: `app/ios/Widget/AppIntent.swift`（同 Task 内で `RefreshWidgetIntent` 削除）

**Interfaces:**
- Consumes: `Color.eqBrand` / `AppFonts` / `IntensityBadge(size:)` / `EarthquakeEntry`
- Produces: ブランド色ヘッダー・アイコンなし・更新ボタンなし・M/バッジ縮小済みの `EarthquakeWidgetView`

- [ ] **Step 1: `RefreshWidgetIntent` を削除する**

`app/ios/Widget/AppIntent.swift` から `RefreshWidgetIntent` 構造体全体を削除し、次の内容だけ残す:

```swift
//
//  AppIntent.swift
//  Widget
//
//  Created by 尾上 遼太朗 on 2025/10/09.
//

import WidgetKit
import AppIntents

struct EarthquakeWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "地震履歴設定" }
    static var description: IntentDescription {
        "表示する範囲を選択してください。「アプリで選択した地域」はEQMonitor Proで、アプリの設定画面から地域を指定できます。"
    }

    @Parameter(title: "表示範囲", default: .nationwide)
    var regionType: RegionType

    init() {}

    init(regionType: RegionType) {
        self.regionType = regionType
    }
}
```

- [ ] **Step 2: `EarthquakeWidgetView.swift` の import を整理する**

ファイル先頭を次にする（`AppIntents` は不要になる）:

```swift
import SwiftUI
import WidgetKit
```

- [ ] **Step 3: `SmallWidgetView` のヘッダーをブランド色帯に置き換える**

`SmallWidgetView` 内のヘッダー `HStack`（アイコン・タイトル・更新ボタン）と、その下の `Rectangle` 区切り線を削除し、次に置き換える:

```swift
WidgetHeader(
    title: headerTitle,
    updateTime: entry.date,
    width: geometry.size.width,
    compact: true
)
```

`CompactEarthquakeRow` 呼び出しを次に変更する（バッジ 26）:

```swift
CompactEarthquakeRow(
    earthquake: eq,
    availableWidth: geometry.size.width - 24,
    intensityBadgeSize: 26
)
```

- [ ] **Step 4: `WidgetHeader` をブランド色帯実装に置き換える**

既存の `private struct WidgetHeader` を次に置き換える（アイコン・更新ボタンなし）:

```swift
private struct WidgetHeader: View {
    let title: String
    let updateTime: Date
    let width: CGFloat
    var compact: Bool = false

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            VStack(alignment: .leading, spacing: compact ? 1 : 2) {
                Text(title)
                    .font(AppFonts.flex(size: compact ? 12 : 15, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Text("更新 \(formattedTime)")
                    .font(AppFonts.code(size: compact ? 9 : 10))
                    .foregroundStyle(.white.opacity(0.7))
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, compact ? 12 : 16)
        .padding(.vertical, compact ? 8 : 10)
        .frame(width: width, alignment: .leading)
        .background(Color.eqBrand)
    }

    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = TimeZone.current
        return formatter.string(from: updateTime)
    }
}
```

`LargeWidgetView` の既存 `WidgetHeader(...)` 呼び出しはそのまま（`compact` 省略で false）。

- [ ] **Step 5: マグニチュードと small バッジサイズを調整する**

`EarthquakeRow` の M 表示を次に変更する（15 → 12）:

```swift
Text(earthquake.magnitude)
    .font(AppFonts.code(size: 12, weight: .bold))
    .foregroundStyle(Color.eqTextPrimary)
```

`CompactEarthquakeRow` を次の形に更新する:

```swift
struct CompactEarthquakeRow: View {
    let earthquake: EarthquakeDisplayItem
    let availableWidth: CGFloat
    var intensityBadgeSize: CGFloat = 26

    private var subtitle: String {
        var parts = [earthquake.formattedTime]
        if !earthquake.depth.isEmpty {
            parts.append("深さ\(earthquake.depth)")
        }
        return parts.joined(separator: " ")
    }

    var body: some View {
        HStack(spacing: 8) {
            IntensityBadge(
                intensity: earthquake.formattedIntensity,
                backgroundColor: earthquake.intensityBackgroundColor,
                textColor: earthquake.intensityTextColor,
                size: intensityBadgeSize
            )

            VStack(alignment: .leading, spacing: 1) {
                HStack(spacing: 3) {
                    Text(earthquake.hypocenterName)
                        .font(AppFonts.flex(size: 11, weight: .bold))
                        .foregroundStyle(Color.eqTextPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .truncationMode(.tail)

                    if let badge = earthquake.statusBadge {
                        StatusBadge(text: badge, small: true)
                    }
                }

                Text(subtitle)
                    .font(AppFonts.code(size: 9))
                    .foregroundStyle(Color.eqTextTertiary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: 2)

            Text(earthquake.magnitude)
                .font(AppFonts.code(size: 10, weight: .bold))
                .foregroundStyle(Color.eqTextPrimary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(
            RoundedRectangle(cornerRadius: DesignTokens.radiusXs, style: .continuous)
                .fill(earthquake.intensityBackgroundColor.opacity(0.4))
        )
        .frame(width: availableWidth)
    }
}
```

- [ ] **Step 6: 残留参照を確認する**

```bash
rg 'RefreshWidgetIntent|waveform\.path\.ecg|eqGlass|arrow\.clockwise' app/ios/Widget --glob '*.swift'
```

Expected:
- `RefreshWidgetIntent`: マッチなし
- `EarthquakeWidgetView` 内のヘッダー用 `waveform` / 更新ボタン用 `arrow.clockwise` / `eqGlass`: マッチなし
- `EQEmptyView` の `waveform.path.ecg` は空状態アイコンとして残ってよい

- [ ] **Step 7: Widget extension をビルドする**

```bash
cd app/ios
xcodebuild -scheme WidgetExtension -destination 'platform=iOS Simulator,name=iPhone 16' -quiet build
```

Expected: `BUILD SUCCEEDED`

（シミュレータ名が違う場合は `xcrun simctl list devices available` で存在する iPhone を選ぶ）

- [ ] **Step 8: Preview で目視確認する**

Xcode で `EarthquakeWidgetView.swift` の Preview を開き、次を確認する:

- small / medium / large: ヘッダーがブランド色、アイコンなし、更新ボタンなし
- medium/large: M が以前より小さい
- small: 「6強」バッジが見切れない（Large - 震度6強 Preview の先頭行を small でも確認）

- [ ] **Step 9: Commit**

```bash
git add app/ios/Widget/Views/EarthquakeWidgetView.swift app/ios/Widget/AppIntent.swift
git commit -m "$(cat <<'EOF'
refactor: 地震履歴Widgetのヘッダーをブランド色帯に整理

EOF
)"
```

---

### Task 3: 計画ドキュメントをコミットし Draft PR を出す

**Files:**
- Create（本ファイル）: `docs/superpowers/plans/2026-07-18-earthquake-history-widget-cleanup.md`

**Interfaces:**
- Consumes: Task 1–2 の完了状態
- Produces: `develop` 向け Draft PR

- [ ] **Step 1: 本プランをリポジトリに含める（未コミットなら）**

```bash
git add docs/superpowers/plans/2026-07-18-earthquake-history-widget-cleanup.md
git commit -m "$(cat <<'EOF'
docs: 地震履歴Widget整理の実装プランを追加

EOF
)"
```

- [ ] **Step 2: push して Draft PR を作成する**

```bash
git push -u origin HEAD

gh pr create --repo YumNumm/EQMonitor --base develop --draft --title "refactor: 地震履歴ホームWidgetの整理" --body "$(cat <<'EOF'
## Summary
- 地図 Widget（`MapEarthquakeWidget`）を削除
- 地震履歴 Widget のヘッダーをブランド色帯に変更（アイコン・更新ボタン削除）
- マグニチュードと small 震度バッジのサイズを調整

## Spec
- `docs/superpowers/specs/2026-07-18-earthquake-history-widget-cleanup-design.md`

## Test plan
- [ ] WidgetExtension ビルド成功
- [ ] small / medium / large Preview でヘッダー色・アイコンなし・更新ボタンなしを確認
- [ ] small で「6強」が見切れないこと
- [ ] ホーム画面に追加済みの地図 Widget が消える／追加できなくなること

EOF
)"
```

---

## Spec coverage checklist

| Spec 要件 | Task |
|-----------|------|
| MapEarthquakeWidget 削除 | Task 1 |
| WidgetBundle から登録削除 | Task 1 |
| 左上アイコン削除 | Task 2 |
| 更新ボタン全削除 + RefreshWidgetIntent 削除 | Task 2 |
| ヘッダーブランド色帯・白文字・ストライプなし | Task 2 |
| M フォント縮小 | Task 2 |
| small バッジ縮小 | Task 2 |
| 行構造維持 / Timeline 等非変更 | Task 2（触らない） |
| Preview / ビルド検証 | Task 2 Step 7–8 |
| PR | Task 3 |
