# Task 6 Report: ホームボタン enabled 制御

## Status

**完了**

## 変更内容

### `home_map_controller_card.dart`

- `isLocationButtonEnabled` パラメータを追加（デフォルト `true`）
- 無効時: `InkWell.onTap: null`、アイコン色を `colorTheme.onSurface.withValues(alpha: 0.38)` に変更

### `home_map_view.dart` (`_MapHeader`)

- `eewMapFocusProvider` と `eewAliveTelegramProvider` を watch
- `isLocationButtonEnabled = !hasAliveEew || !focus.isFocused` を計算して `HomeMapControllerCard` に渡す
- `onLocationButtonTap` は既存どおり `returnToHome()`（Task 4 の EEW 再フォーカス / ホーム復帰分岐を利用）

## 状態マトリクス

| 状態 | enabled |
|------|---------|
| EEW なし | true（通常ホーム） |
| EEW あり & focused | false |
| EEW あり & 解除後 | true（再フォーカス） |

## Analyze

```
mise exec -- dart analyze lib/feature/home lib/feature/map/ui/maplibre_event_provider.dart
```

結果: **No issues found!**

> worktree では `app/tools -> ../tools` シンボリックリンクが必要だった（`docs/knowledge/20260722_analyzer_plugin_worktree.md` 参照）。本コミットには含めていない。

## Tests

新規テストは追加していない（UI 接続のみの変更）。

## Commits

- `feat: EEWフォーカス中はホームボタンを無効化`

## Concerns

- 無効色は Material 標準の `onSurface` 38% 不透明度を使用。デザインシステムに専用トークンがあれば将来差し替え可能。
- Widget テストでの enabled/disabled 見た目検証は未実施（Task 7 以降で検討可）。
