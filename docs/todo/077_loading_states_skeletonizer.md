# ローディング状態 — CircularProgressIndicator を Skeletonizer に置き換え

## 背景

DESIGN.md では「画面全体を単一の `CircularProgressIndicator` だけで済ませるのは避ける」と定めている。
現状、以下の画面が spinner のみで読み込み中を表現しており、レイアウトジャンプが発生する。
`skeletonizer` は既に依存関係に含まれており、ホームの地震履歴シートや通知設定画面では正しく使われているため、同じパターンを横展開する。

## 対象ファイルと対応方針

| ファイル | 現状 | 対応 |
|---|---|---|
| `feature/eew/ui/screen/eew_details_screen.dart` | `CircularProgressIndicator.adaptive()` | EEW カードの skeleton に置き換え |
| `feature/eew/ui/screen/eew_details_by_event_id_page.dart` | spinner | EEW 詳細の skeleton |
| `feature/telegram_list/ui/telegram_list_by_event_id_page.dart` | リストフッターの spinner | `Skeletonizer` でリスト行を fake 表示 |
| `feature/earthquake_history/ui/earthquake_history_page.dart` | 初回・追加読み込み spinner | `Skeletonizer.sliver` でカード skeleton |
| `feature/earthquake_search/ui/earthquake_search_result_page.dart` | spinner | 検索結果カードの skeleton |
| `feature/nied/ui/aqua/aqua_catalog_page.dart` | spinner | テーブル行の skeleton |

## やること

1. 各画面の「読み込み中」状態でダミーデータを用意し、実 UI をそのまま `Skeletonizer` でラップする。
2. `NetworkImage` などネット画像を含むウィジェットは `Skeleton.replace` で安全なプレースホルダに差し替える。
3. Skeleton の shimmer 色はダークテーマの階層（`surface.raised` / `surface.card`）に合わせ、情報色と競合させない。
4. 読み込み完了後のレイアウトジャンプがないことを実機またはシミュレーターで確認する。

## 参照

- `app/lib/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart`（実装例）
- `app/lib/feature/settings/features/notification_settings/ui/page/eew_settings_page.dart`（実装例）
- https://pub.dev/packages/skeletonizer
