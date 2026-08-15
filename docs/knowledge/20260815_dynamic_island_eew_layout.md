---
alwaysApply: false
globs: app/ios/Widget/LiveActivity/**,app/ios/Shared/EewDisplay.swift
---

# EEW Live Activity / Dynamic Island のレイアウト方針

Dynamic Island は展開しても表示面積が小さく、要素を並べるほど「角で切り取られる」
「文字が縮んで読めない」の両方が起きる。Apple のタイマー / アラームと同じく
**主役を 1 つに絞る**方針で組む。

## 1. 状況ごとに主役を決める（判定は `EewDisplay` に置く）

`EewDisplay.dynamicIslandLayout`（`app/ios/Shared/EewDisplay.swift`）で 3 通りに分岐する。
Foundation のみに依存させ、`WidgetModelsTests` で固定する。

| レイアウト | 条件 | leading | trailing | center（説明ラベル） | bottom |
|---|---|---|---|---|---|
| `.countdown` | 到達予想あり | 現在地の予想震度バッジ | 残り時間（等幅・大） | 地名 / 「主要動到達まで」 | 警報バッジ + 震源地 + M・深さ |
| `.summary` | 到達予想なし | 予想最大震度バッジ | 警報 / 予報バッジ | 震度の種別 / 報番号 | 震源地 + M・深さ |
| `.canceled` | 取消報 | 取消シンボル | 報番号 | 「緊急地震速報は取り消されました」 | 「予想震度・主要動到達の予想は無効です」 |

取消報の文言は `EewDisplay.canceledTitle` / `canceledDescription` に集約し、
Lock Screen と Dynamic Island でズレないようにする。

## 2. leading / trailing には要素を 1 つだけ置く

`.leading` / `.trailing` は TrueDepth カメラ脇の細い L 字領域。ここに
`VStack { ラベル; バッジ }` のように積むと、上端が島の角で切り取られる（実機で発生）。

```swift
// ❌ 悪い例: ラベルを積んで角で切れる
DynamicIslandExpandedRegion(.leading) {
    VStack { Text("予想震度"); IntensityBadge(...) }
}

// ✅ 良い例: 値だけ置き、ラベルは全幅の center 行へ回す
DynamicIslandExpandedRegion(.leading) { IntensityBadge(...) }
DynamicIslandExpandedRegion(.center) {
    HStack { Text("予想震度"); Spacer(); Text("主要動到達まで") }
}
```

`.center` はカメラ下の全幅領域なので、左右端に寄せれば leading / trailing の値の
真下にラベルが並び、キャプションとして読める。余白（`padding`）は足さない。

## 3. カウントダウンは等幅フォント + 同じフォントの placeholder

`Text(timerInterval:)` は横幅いっぱいに広がろうとするため、`Text("00:00").hidden()` で
幅を確保して `overlay` で重ねる。**placeholder と本文のフォントは必ず一致させる**
（片方だけ `design: .monospaced` にすると確保した幅と実際の幅がずれる）。

数字は `AppFonts.code`（GoogleSansCode = アプリの Mono フォント）で描く。
実装は `ArrivalCountdownText`（`Widget/LiveActivity/Common/SharedComponents.swift`）に
共通化してあり、Lock Screen ヘッダー（`color: .white`）と Dynamic Island で共用する。

## 4. 精度の低い検知では M・深さを出さない

PLUM法 / レベル法 / 1点検知は震源要素の精度が低い。Lock Screen と同じく、
Dynamic Island でも M・深さの代わりに検知方法（`PLUM法` / `レベル法` / `1点検知(低精度)`）を出す。
仮定震源要素の検知では「震源地」ではなく「検知観測点」と明示する。

## 5. 検証手段

- 判定ロジック（`EewDisplay`）は Linux でも検証できる。SwiftPM の一時パッケージへ
  `EewDisplay.swift` と `IntensityValue` のスタブをコピーし `swift test`
  （手順は `docs/knowledge/20260815_live_activity_content_state_robustness.md`）。
- 見た目は Xcode Preview（`EewLiveActivityWidget_Previews`）と実機で確認する。
  到達カウントダウンのプレビューは固定日時だと常に「到達済み」になるため、
  実行時刻から生成する `EewContentState.countingDown()` を使う。
- 実機は `設定 > デバッグ > Live Activity テスト` からローカル開始できる
  （`docs/knowledge/20260815_live_activity_local_debug.md`）。
