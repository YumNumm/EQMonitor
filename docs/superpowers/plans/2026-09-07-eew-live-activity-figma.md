# EEW Live Activity Figma Implementation Plan

**Goal:** 合意済みのロック画面・Expanded・Minimalを実装し、ユーザーがSwift Previewでデザインチェックできる状態にする。

**Architecture:** `EewDisplay`に表示判定を集約する。既存の震度色・フォント・カウントダウン・しましまを再利用し、現在地と最大震度の部品を分離する。

**Tech Stack:** SwiftUI / ActivityKit / WidgetKit / Swift Testing

**Spec:** Figma `AmrOwdlmvdGU03vssT9e1H` の `1628:1745`（ロック画面）、`1628:1694`（Expanded）と本会話で合意したMinimal。

## Constraints

- Minimal: 現在地は塗りつぶしあり。最大震度は塗りつぶしなし＋MAX。現在地ラベルは追加しない。
- 現在地情報は警報、または予報で現在地の予想震度4以上の場合に表示。欠損値を補完しない。
- 現在地が警報対象かは電文全体の警報と分ける。取消時は震度・到達予想を抑止する。
- ロック画面のヘッダーは既存のしましまを再利用し、右端を最大震度にする。
- Expandedは上段に最大震度とM/深さ、下段に見出しと現在地の注意・カウントダウン・予想震度。
- PLUM/レベル法/1点検知の低精度表示と深発注意を維持する。
- フォントは既存のAppFonts。配信されない最大長周期地震動階級は表示しない。
- 新規ブランチ`feat/eew-live-activity-figma`で変更し、ユーザーの未コミット変更はステージしない。作業前は`136f74218`。

## Tasks

- [x] `LocationInfo`で警報対象・PLUMを受信し、`EewDisplay`で現在地情報の可否、震度の種別、注意帯を判定する。警報対象外・予報3/4・取消・欠損・PLUMの回帰テストを追加する。
- [x] 最大震度専用のMAX付き部品と現在地の色付き部品を作り、Compact/Minimalで使い分ける。
- [x] ロック画面のヘッダー・地震詳細・現在地情報をFigmaに沿って組み直す。
- [x] Expandedのleading/trailing/bottomを組み直し、現在地情報なし・取消・低精度も対応する。
- [x] 状態別のLock Screen/Expanded/Compact/Minimal Previewを追加。WidgetModelsTestsとPreviewターゲットのビルド・静的解析で確認する。
- [x] 配信項目の制約・Preview手順をknowledge/todoに記録する。対象ファイルのみコミット・pushする。

## Verification

```sh
xcodebuild test -project app/ios/Runner.xcodeproj -scheme WidgetModelsTests -destination 'platform=iOS Simulator,name=iPhone 17' CODE_SIGNING_ALLOWED=NO
xcodebuild build -project app/ios/Runner.xcodeproj -scheme EQMonitorPreview -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO
git --no-pager diff --check
```

最終的な見た目の採否はユーザーがSwift Previewで確認する。
