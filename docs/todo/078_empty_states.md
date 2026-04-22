# 空状態 UI の統一

## 背景

DESIGN.md では「空状態は冷たい無表示にしない。1 つの説明文と、可能なら次の行動を用意する」と定めている。
現状、複数の画面が生の `Text` ウィジェットのみで空状態を表現しており、ユーザーへの文脈説明や次のアクションが欠けている。
一方、`EarthquakeHistoryNotFound` コンポーネント（地震履歴画面・ホームシート）は良い実装例として存在する。

## 対象ファイルと現状

| ファイル | 現状の表示 |
|---|---|
| `feature/eew/ui/screen/eew_details_screen.dart` | `Text('データがありません')` |
| `feature/eew/ui/screen/eew_details_by_event_id_page.dart` | プレーンテキスト |
| `feature/telegram_list/ui/telegram_list_by_event_id_page.dart` | `Text('電文がありません')` |
| `feature/nied/ui/fnet/fnet_catalog_page.dart` | `Text('データがありません')` |
| `feature/nied/ui/aqua/aqua_catalog_page.dart` | プレーンテキスト |

## やること

1. **共通 `AppEmptyState` ウィジェットを作成する**（`app/lib/core/component/widget/app_empty_state.dart`）
   - アイコン（`Icons` または SVG）+ タイトル + 説明文 + オプショナルな CTA ボタンを受け取る。
   - デザインシステムのトークン（カラー・タイポグラフィ・スペーシング）を使う。
   - `EarthquakeHistoryNotFound` の実装を参考にしつつ、汎用的な props 設計にする。

2. **各画面の空状態を `AppEmptyState` に置き換える**
   - EEW 詳細: 「まだ EEW 情報がありません」＋ホームに戻るボタン
   - 電文一覧: 「電文がありません」＋説明
   - NIED カタログ: 「データがありません」＋再読み込みボタン

3. **「現在データなし」と「取得結果が空」を明確に分ける**
   - ローディング中は skeleton、取得結果ゼロは `AppEmptyState` を使うよう統一する。

## 参照

- `app/lib/feature/earthquake_history/ui/component/earthquake_history_not_found.dart`（実装例）
- `app/lib/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart`（空状態の使い方）
