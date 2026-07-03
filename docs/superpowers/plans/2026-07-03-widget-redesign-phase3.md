# App Intents 対応 Phase 3（ホーム画面 Widget デザイン刷新）実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.
>
> **前提:** Phase 1（Issue #1418）マージ後に着手すること。`DesignTokens` / `AppFonts` / 共有 `IntensityBadge` は Phase 1 の成果物。

**Goal:** ホーム画面ウィジェット（EarthquakeWidget / MapEarthquakeWidget）の見た目を Flutter アプリのデザイン言語（色・タイポグラフィ・震度バッジ・リスト行構造）に揃える。

**Architecture:** Phase 1 で導入した `DesignTokens`（アプリ ColorThemeExtension 同値の色・角丸トークン）と `AppFonts`（GoogleSansFlex / GoogleSansCode）に、既存の `EarthquakeWidgetView` / `MapEarthquakeWidgetView` を載せ替える。震度バッジと地震リスト行はアプリの `JmaIntensityIcon` / `earthquake_history_list_tile` を移植基準とし、Liquid Glass（`eqGlass`）は iOS らしさとして維持する。

**Tech Stack:** SwiftUI / WidgetKit / DesignTokens・AppFonts（Phase 1 成果物）

## Global Constraints

- 移植基準は Flutter 実装: 震度バッジは角丸 `size / 4`（25%）・weight **bold**（heavy をやめる）・数字はコンテナに対し大きく（FittedBox 相当のスケーリング）。リスト行は 背景=最大震度色 alpha 0.4、リーディング=バッジ、タイトル=震源名(bold)、サブ=日時+深さ（等幅フォント）、トレーリング=M値。
- 震度カラー値（eqmonitor スキーム）は変更しない。
- Liquid Glass（`Color.eqGlass` / `.glassEffect()`）は維持する。
- フォントは `AppFonts.flex` / `AppFonts.code` を使用（`AppFonts.registerIfNeeded()` を TimelineProvider または View 初期化で呼ぶ）。日本語はシステムフォールバック。
- ウィジェットの情報構造（表示項目・タイムライン・RegionType 設定）は変更しない。純粋な見た目の刷新。
- フォントファイル（可変TTF ×2）を WidgetExtension のリソースにも追加（AppIntentExtension と同じ file reference を共有）。
- コミットは develop から切ったフィーチャーブランチ（例: `feat/widget-redesign`）。PR は `--repo YumNumm/EQMonitor`、base `develop`。
- ビルド検証は Phase 1 計画の「共通ビルド」コマンドを使用。

---

### Task 1: IntensityBadge のアプリ準拠刷新

**Files:**
- Modify: `app/ios/Widget/Views/EarthquakeWidgetView.swift` 内 `IntensityBadge`（Phase 1 で共有ファイル化済みならそのファイル。members: `intensity: (main: String, sub: String?)` / `backgroundColor` / `textColor` / `size`）

**Interfaces:**
- Produces: 刷新された `IntensityBadge`（両ウィジェット + スニペットで共用）

- [ ] **Step 1: バッジをアプリ準拠に修正**

```swift
struct IntensityBadge: View {
    let intensity: (main: String, sub: String?)
    let backgroundColor: Color
    let textColor: Color
    var size: CGFloat = 40

    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 0) {
            Text(intensity.main)
                .font(AppFonts.code(size: size * 0.62, weight: .bold))  // 現行 0.5/heavy → 0.62/bold
            if let sub = intensity.sub {
                Text(sub)
                    .font(AppFonts.code(size: size * 0.30, weight: .bold))
            }
        }
        .minimumScaleFactor(0.5)
        .lineLimit(1)
        .foregroundStyle(textColor)
        .frame(width: size, height: size)
        .background(
            RoundedRectangle(cornerRadius: size / 4)  // 現行 size * 0.22 → アプリ準拠 25%
                .fill(backgroundColor)
        )
    }
}
```

- [ ] **Step 2: 共通ビルド → Xcode Preview または実機で 震度1〜7・5弱/5強 の全パターンを目視確認**

確認観点: 「5弱」の弱がはみ出さない／数字がアプリの `JmaIntensityIcon` と同等の存在感／6弱以上の白文字が読める。

- [ ] **Step 3: Commit**

```bash
git add app/ios && git commit -m "refactor(ios/widget): 震度バッジをアプリのデザインに統一"
```

---

### Task 2: EarthquakeWidgetView の DesignTokens / AppFonts 移行

**Files:**
- Modify: `app/ios/Widget/Views/EarthquakeWidgetView.swift`
- Modify: `app/ios/Widget/DesignSystem.swift`（未参照になった旧色定数の削除）

**Interfaces:**
- Consumes: `DesignTokens` / `AppFonts` / 刷新済み `IntensityBadge`（Task 1）
- Produces: アプリ準拠のリスト型ウィジェット

- [ ] **Step 1: 行レイアウトをアプリの earthquake_history_list_tile 構造に揃える**

`EarthquakeRow`（および small サイズ表示）を以下の構造へ:

```swift
HStack(spacing: 10) {
    IntensityBadge(...)                                   // leading
    VStack(alignment: .leading, spacing: 2) {
        Text(item.hypocenterName)
            .font(AppFonts.flex(size: 13, weight: .bold)) // タイトル: 震源名
        Text(subtitleText(item))                          // "yyyy/MM/dd HH:mm頃発生 深さ50km"
            .font(AppFonts.code(size: 10))
            .foregroundStyle(Color.eqTextSecondary)
    }
    Spacer(minLength: 4)
    Text(item.magnitude)
        .font(AppFonts.code(size: 15, weight: .bold))     // trailing: M値
}
.padding(.horizontal, 10).padding(.vertical, 6)
.background(
    RoundedRectangle(cornerRadius: DesignTokens.radiusSm)
        .fill((item.maxIntensity?.backgroundColor ?? Color.eqCard).opacity(0.4))
)
```

深さが空文字（不明）のときはサブテキストから省略。ヘッダー（タイトル・更新時刻）は `AppFonts.flex(size: 15, weight: .bold)` / `AppFonts.code(size: 10)` に置換。

- [ ] **Step 2: 共通ビルド → small / medium / large × light / dark の6パターンをスクリーンショット確認**

シミュレータにウィジェットを配置し、アプリの地震履歴画面と並べて色・フォント・バッジの調和を目視確認。ズレがあれば DesignTokens 側でなく View 側を直す（トークン値はアプリが正）。

- [ ] **Step 3: Commit**

```bash
git add app/ios && git commit -m "refactor(ios/widget): 地震履歴ウィジェットをアプリのデザインに刷新"
```

---

### Task 3: MapEarthquakeWidgetView の移行

**Files:**
- Modify: `app/ios/Widget/Views/MapEarthquakeWidgetView.swift`

**Interfaces:**
- Consumes: `DesignTokens` / `AppFonts` / `IntensityBadge`
- Produces: アプリ準拠の地図型ウィジェット

- [ ] **Step 1: オーバーレイ（震源情報・凡例）のフォントを AppFonts に、色を DesignTokens / eq* トークンに置換。バッジは Task 1 の共通実装を使用。地図描画ロジックは変更しない**

- [ ] **Step 2: 共通ビルド → 地図型ウィジェットのライト/ダーク表示確認**

- [ ] **Step 3: Commit**

```bash
git add app/ios && git commit -m "refactor(ios/widget): 地図ウィジェットをアプリのデザインに刷新"
```

---

### Task 4: 旧デザイン定数の掃除と総合検証・PR

**Files:**
- Modify: `app/ios/Widget/DesignSystem.swift`

- [ ] **Step 1: 未参照になった旧定数（置換済みの色・サイズのマジックナンバー）を削除。`eqGlass` 等の現役 API は残す**

```bash
cd app/ios && grep -rn "eqBg\|eqSurface\|eqCard\|eqBrand" Widget AppIntentExtension --include="*.swift" | grep -v DesignSystem.swift
# 参照が残っている定数だけ残し、それ以外を削除
```

- [ ] **Step 2: 共通ビルド + WidgetModelsTests 実行（Phase 1 のテストが通ること）**

- [ ] **Step 3: 検証チェックリスト**

- 地震履歴ウィジェット（3サイズ）とアプリの地震履歴画面を並べて違和感がない
- 地図ウィジェットの視認性が落ちていない
- ダークモードで文字・バッジのコントラストが保たれている
- Interactive Snippet（Phase 1）と ウィジェットの見た目が揃っている

- [ ] **Step 4: PR 作成**

```bash
gh pr create --repo YumNumm/EQMonitor --base develop \
  --title "refactor(ios): App Intents対応 Phase 3 — ホーム画面ウィジェットのデザイン刷新" \
  --body "(before/after スクリーンショットを添付)"
```
