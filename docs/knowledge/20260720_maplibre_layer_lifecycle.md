# MapLibre レイヤーのライフサイクル

## 規約

- `addSource`、`addImage`、`addLayer` は原則として style ごとに一度だけ実行する。
- 可変 GeoJSON は source を削除・再登録せず、`updateGeoJsonSource` で更新する。
- filter は `updateFilter` で更新する。paint/layout に更新 API がない場合は layer だけを差し替え、source と image は維持する。
- データ更新は source 初期化 Future の完了を待つ。初期化中に Widget が破棄された場合は lifecycle token を照合し、後続の追加・更新を中止する。
- cleanup は layer、source、image の順に行い、各削除を独立して試行する。一件の失敗で後続 resource の削除を止めない。
- `VectorSource.url` など source 定義そのものが変わる場合だけ、source の再作成を許可する。

## 実装例

GeoJSON source は空の FeatureCollection で初期化し、更新側では共通 updater を使う。

```dart
final updater = useMemoized(MapGeoJsonSourceUpdater.new);
final initialization = useRef<Future<void>?>(null);

initialization.value = enqueue(
  () => style.addSource(
    const GeoJsonSource(id: sourceId, data: emptyGeoJson),
  ),
);

unawaited(
  enqueue(
    () => updater.update(
      styleController: style,
      sourceId: sourceId,
      geoJson: latestGeoJson,
      initialization: initialization.value,
      isDisposed: () => lifecycleToken.value != token,
    ),
  ),
);
```

cleanup は `removeMapStyleResources` に全 ID を渡す。存在しない途中 resource があっても残りの削除が継続される。

## 監査方法

```bash
rg -l '\.(addSource|addImage|addImages|addImageFromAssets|addLayer|removeSource|removeImage|removeLayer|updateGeoJsonSource|updateFilter)\(' app/lib -g '*.dart'
rg -n 'removeLayer\(|removeSource\(|removeImage\(' app/lib -g '*.dart'
```

監査では次に分類する。

- 静的 source/layer: style だけに依存して初期化する。
- GeoJSON 更新分離済み: P/S 波、揺れ検知など。cleanup が独立していることも確認する。
- source 定義変更: PMTiles URL の変更など。完全再作成を許可するが、初期化中断と独立 cleanup は必要。
- 修正対象: 可変データ、表示設定、timer tick を初期化 effect の依存に含み、同じ ID の source/image/layer を再登録するもの。

## 検証

```bash
cd app
mise exec -- flutter test test/core/util/map
mise exec -- flutter test test/feature/seismicity
mise exec -- flutter test test/feature/earthquake_history/ui/layer
mise exec -- flutter test test/feature/tsunami
```
