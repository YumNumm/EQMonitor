# EEW Card / Live Activity 表示仕様揃え

**日付:** 2026-08-01  
**状態:** 承認済み（会話上の決定を反映）

## 目的

`eew_card.dart` と iOS Live Activity（Lock Screen / Dynamic Island）の EEW 表示を揃え、最終報・到達済み・仮定震源・取消・深さ表示の食い違いを解消する。

## 決定事項

| # | 項目 | 決定 |
|---|------|------|
| 1 | 最終報 | `最終 第N報` で統一（Lock Screen / Dynamic Island） |
| 2 | 到達後 | `主要動到達済み`。到達時刻は `location.arrivalTime` |
| 3 | 仮定震源 | `eew_card` を Live Activity に合わせ、PLUM / レベル法 / 1点で M・深さ非表示 + 検知ラベル。デバッグ画面にケース追加 |
| 4 | Dynamic Island Expanded Bottom | `isPlum` / `isLevel` / `isOnePoint` 時は M・深さを出さない |
| 5 | 取消 | `eew_card` を Live Activity に合わせる（種別 `緊急地震速報(取消)`、本文「緊急地震速報は取り消されました」） |
| 6 | 深さ 0 / 700 | 特別分岐なし。常に `N km` |
| 7 | headline 一本化 | 今回スルー |
| 8 | PLUM 時刻ラベル | Live Activity も `isPlum` なら「地震検知」 |
| 9 | 深発注釈・LPGM | Live Activity には載せない（現状維持） |
| 10 | M / 深さが null | 非表示（「不明」は出さない） |

## 仮定震源の判定（アプリ）

Live Activity（backend）と同じ意味になるよう:

- **PLUM:** `eew.isPlum`
- **レベル法:** `accuracy?.epicenter == 1 && originTime == null`
- **IPF 1点:** `accuracy?.epicenter == 1 && originTime != null && !isPlum`

表示ラベル:

- PLUM → `PLUM法による検知`
- レベル法 → `レベル法による検知`
- 1点 → `低精度の緊急地震速報`

## 対象ファイル

- `app/ios/Widget/LiveActivity/Eew/EewLiveActivityView.swift`
- `app/ios/Widget/LiveActivity/EQMonitorLiveActivityWidget.swift`
- `app/ios/Widget/LiveActivity/Eew/EewLiveActivityAttributes.swift`（timeLabel / preview）
- `app/lib/feature/home/ui/component/eew/eew_card.dart`
- `app/lib/feature/eew/data/model/eew_telegram_item.dart`（判定 getter）
- `app/lib/feature/settings/children/config/debug/eew/debug_eew_card_page.dart`
