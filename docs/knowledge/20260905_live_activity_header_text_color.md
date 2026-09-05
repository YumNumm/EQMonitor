# Live Activity ヘッダー文字は `.primary` ではなく白固定

- 日付: 2026-09-05
- 対象: iOS Live Activity（EEW / 揺れ検知のヘッダー帯）

## 制約

EEW Live Activity のヘッダー背景は警報・予報・取消で常に濃色（赤 / 橙 / 灰）である。
ここに `.foregroundColor(.primary)` を使うと、ライトモードでは黒文字になり、帯の上で読めなくなる。

`.primary` はシステム外観に追従する。ヘッダー帯は外観に依らず濃色なので、文字色も外観に依らず白にする。

## 方針

- ヘッダー内の見出し・カウントダウンは `liveActivityHeaderPrimaryTextColor`（`.white`）
- ヘッダー内の補助ラベルは既存の `liveActivityHeaderSecondaryTextColor`（`.white.opacity(0.7)`）
- 白い本文エリア（震源地・M・深さ・時刻など）はこれまで通り `.primary`

揺れ検知 Live Activity のヘッダーは当初から `.white` 直書きだった。EEW 側も同じ定数に揃える。
