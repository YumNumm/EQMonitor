# EEW Card と Live Activity の表示揃え

- 日付: 2026-08-01
- 対象: `eew_card.dart` / iOS Live Activity（Lock Screen・Dynamic Island）

## 揃えた仕様

| 項目 | 仕様 |
|------|------|
| 最終報 | `最終 第N報` |
| 到達後 | `主要動到達済み`（`location.arrivalTime`） |
| PLUM | M/深さ非表示、`PLUM法による検知`、時刻は「地震検知」 |
| レベル法 | `accuracy.epicenter==1 && originTime==null`。M/深さ非表示、`レベル法による検知` |
| IPF 1点 | `epicenter==1 && originTime!=null && !isPlum`。M/深さ非表示、`低精度の緊急地震速報` |
| 取消 | 種別 `緊急地震速報(取消)`、本文「緊急地震速報は取り消されました」 |
| 深さ | `0` / `700` の特別表示なし。常に `N km` |
| M/深さ null | 非表示 |

## 注意

- Live Activity の ContentState は backend APNs が組み立てる。アプリはトークン登録のみ。
- Dynamic Island の Expanded Bottom でも仮定震源フラグを見て M/深さを隠すこと。
- Dynamic Island の到達表示も Lock Screen と同じく `主要動到達済み` / `timerInterval` カウントダウンを使う。
- headline 生成のアプリ/backend 差分は今回未対応。
- 深発注釈・LPGM は `eew_card` のみ（Live Activity には載せない）。

## デバッグ

設定 → デバッグ → EEW Card デバッグのサンプル一覧に PLUM / レベル法 / 1点 / 取消 / M深さなし / 深さ0 を含む。
