# 非同期データを使う MapLibre レイヤーのライフサイクル

## ルール

- 初回取得前の空データで MapLibre の source / layer 置換を実行しない。
- `AsyncValue.valueOrPrevious` にデータがある場合だけレイヤー Widget をマウントする。
- provider の `invalidate` による再取得中と再取得失敗時は previous value を使い、表示済みレイヤーを維持する。
- 再取得成功時はデータの実体が変化した場合だけレイヤーを更新する。
- 読み込み表示は `CircularProgressIndicator.adaptive()` を使い、`IgnorePointer` または非モーダルな配置で戻る操作を遮らない。
- 再試行で provider の Future が失敗しても、画面は provider のエラー状態を表示するため、ボタンの Future から例外を再伝播させない。

## 理由

初回データがない段階で空のレイヤー置換を予約すると、MapLibre の style 初期化とデータ取得の順序によって空の更新だけが反映されることがある。一方、再取得のたびにレイヤーをアンマウントすると、取得中のちらつきや取得失敗時の表示消失につながる。

## 回帰確認

初回取得、実際の `invalidate`、再取得成功、再取得失敗を同じテストで確認する。

```sh
mise exec -- flutter test \
  test/feature/intensity_history/intensity_history_map_layers_test.dart \
  test/feature/intensity_history/intensity_history_loading_overlay_test.dart \
  test/feature/intensity_history/intensity_history_error_overlay_test.dart \
  test/feature/intensity_history/intensity_history_page_state_test.dart
```
