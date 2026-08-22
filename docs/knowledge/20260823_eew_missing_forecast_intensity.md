# 予想最大震度が未発表のときの EEW 表示

- 日付: 2026-08-23
- 対象: iOS Live Activity（Lock Screen / Dynamic Island）・`eew_card.dart`

## 震度コンポーネントを消さない

予想最大震度が `nil`（未発表）でも震度バッジを消さない。消すと以下の問題が起きる。

- 左端の枠が無くなり、報が進んで震度が付いた瞬間にレイアウトが跳ねる
- 「震度 0 が発表された」のか「まだ発表されていない」のかを読み手が区別できない

灰色（`0x757575`）背景に白の `-` を、震度がある場合と同じ寸法で描く。
iOS では `IntensityBadgeAppearance`（`app/ios/Shared/IntensityBadge.swift`）に集約し、
`SquareIntensityBadge`（Lock Screen）と `DynamicIslandIntensityBadge`（compact / minimal / expanded）が共有する。
どちらも `IntensityValue?` を受け取り、`nil` を「未発表」として描く。

取消報だけは例外で、震度バッジではなく `EewCanceledSymbol` を出す（予想震度自体が無効）。

## 深発注意文

深さ 150km **より深い**（`depth > 150`）場合、JMA は予想震度・主要動到達時刻を発表しない。
未発表の理由が深さだと言えるときだけ、Lock Screen の下部に次を出す。

```text
震源の深さが150kmより深いため、予想震度は発表されていません
```

判定は `EewDisplay.showsDeepHypocenterIntensityNotice`（`app/ios/Shared/EewDisplay.swift`）に置き、
`WidgetModelsTests` で固定する。条件は「取消でない」「PLUM / レベル法 / 1点検知でない」
「最大震度が未発表」「深さが 150km より深い」のすべて。

アプリ本体は `EewDeepHypocenterIntensityNotice`（`app/lib/feature/eew/data/logic/`）が同じ条件を持つ。
文言・しきい値はアプリと Live Activity で一致させること。

Dynamic Island の狭い領域には注意文を載せない（1 行に収まらず切り取られる）。

## 検証コマンド

```sh
cd app
mise exec -- flutter test \
  test/feature/eew/data/logic/eew_deep_hypocenter_intensity_notice_test.dart \
  test/feature/home/ui/eew_card_deep_hypocenter_notice_test.dart

cd app/ios
xcodebuild test -workspace Runner.xcworkspace -scheme WidgetModelsTests \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

`Shared/` は file-system synchronized group ではないため、新規ファイルを足すと
`project.pbxproj` への手登録が必要になる。既存ファイルへ型を追加すれば回避できる
（今回は `IntensityBadge.swift` に `IntensityBadgeAppearance` を追加した）。
