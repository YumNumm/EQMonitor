# Live Activity の主要動カウントダウンは到達後も 00:00 のまま

- 日付: 2026-08-23
- 対象: iOS Live Activity（Lock Screen・Dynamic Island）、`eew_card`

## 制約

Live Activity の SwiftUI `body` は ContentState の更新か `staleDate` 到達でしか再評価されない。
`Text(timerInterval:countsDown:)` の秒読みだけはシステムが進める。

そのため「0 になった瞬間に別文言へ切り替える」はできない。切り替えると、次報が来るまで `00:00` のまま張り付く。

## 方針

到達予想がある間は、到達前後で View を切り替えない。

- Live Activity: `ArrivalCountdown.remaining` は到達後も終了済み区間 `arrival...arrival` を返し、表示は `主要動到達まで` + `00:00`
- `eew_card`: 到達後も `主要動到達まで` + `0秒`
- `now > arrival` の `ClosedRange` はクラッシュするので作らない

`staleDate` は EEW 開始/更新から 30 分後であり、到達時刻とは別用途。到達切替に使わない。
