# MapLibre レイヤーの挿入順は effect の再実行順で壊れる

`StyleController.addLayer(layer, belowLayerId: X)` は「X の直下」へ挿入する
（iOS: `MLNStyle.insertLayer(_, below:)` / Android: 同等の API）。
同じアンカー `X` に対して複数のレイヤーを順に追加すると、**後から追加したものが上**
になる。

```dart
await style.addLayer(a, belowLayerId: 'line'); // [..., a, line]
await style.addLayer(b, belowLayerId: 'line'); // [..., a, b, line]  ← b が上
```

## ハマった問題

`intensity_history` の震度塗り分けは、細分区域(Lv1)用と市区町村(Lv2)用で
`useEffect` を分けており、どちらも `belowLayerId: areaForecastLocalELine` を
指定していた。

- 初回は Lv1 → Lv2 の順に追加されるため意図どおり
- しかし Lv1 側の依存（cache-first SWR による再検証結果、テーマ色）が後から
  変化して effect が再実行されると、Lv1 が最上位に挿入され Lv2 の塗り・ディムを
  覆う

例外もログも出ないため「色がときどきおかしい」という再現しにくい不具合になる。

## ルール

- **同一マップ上の複数レイヤーを別々の `useEffect` で追加しない。**
  1 つの effect でレイヤー一式を組み立て、`replaceMapStyleLayers` に
  「下 → 上」の順で渡す。
- レイヤー構築は純粋クラス（例:
  `app/lib/feature/intensity_history/ui/layer/intensity_fill_layer_builder.dart`）に
  切り出し、順序・挿入アンカーを unit test で固定する。
- `belowLayerId` / `aboveLayerId` は存在しないレイヤー ID を渡すと例外になる。
  ベーススタイルの `BaseLayer` enum（`map_style_util.dart`）以外をアンカーに
  しないこと。
- `aboveLayerId` は web では無視される。

## 半透明レイヤーの重ね合わせ

不透明度 < 1 のレイヤーを重ねると下のレイヤーの色が混ざる。震度色のように
「色そのものが情報」である塗りは重ねないこと。ズームで表示を切り替える場合は、
下側のレイヤーの `fill-opacity` を `['step', ['zoom'], ...]` で 0 にして
明示的に消す。

```dart
'fill-opacity': <Object>[
  'step',
  <Object>['zoom'],
  0.7,                          // cityMinZoom 未満: 細分区域を見せる
  BaseMapTileSpec.cityMinZoom,
  0.0,                          // cityMinZoom 以上: 市区町村の塗りに譲る
],
```
