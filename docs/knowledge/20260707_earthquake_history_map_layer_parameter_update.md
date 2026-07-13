# 地震履歴詳細マップ: レイヤーパラメータ変更時の flicker 防止

## 症状

デバッグモーダルで `EarthquakeHistoryMapLayerParameter` を変更すると、震度履歴詳細マップのレイヤーが消えたり戻ったりする。

## 原因

1. `parameter` がレイヤー初期化と同じ `useEffect` の deps に入っており、変更のたびに cleanup（remove）→ 再 add が走る
2. 各レイヤー Widget が個別の `useMapOperationQueue()` を持ち、同一 `StyleController` への操作が並列実行される

## 対策パターン（`HomeMapLabelLayer` と同様）

1. **マップ親（`_MapContent`）で `useMapOperationQueue()` を1回だけ**呼び、`enqueue` を全レイヤーに渡す
2. **init effect**: `parameter` を deps から除外。unmount 時のみ cleanup
3. **update effect**: deps は `[styleController, parameter, enqueue]` のみ。`isInitialized` ref でガード。cleanup なし（remove → add で更新）
4. 非 parameter 値は `latest*` ref で update 時に参照
5. init cleanup 先頭で **同期的に** `isInitialized.value = false`

## debounce

不要（スライナーは `notifier.save` をそのまま呼ぶ）。

## 参考

- `app/lib/feature/home/ui/component/map/layer/home_map_label_layer.dart`
- `app/lib/core/hook/use_map_operation_queue.dart`（キュー導入理由のコメント）
