# flutter_scene: batched draw が geometry 自前の instance buffer を上書きする

## 状態

fork（`YumNumm/flutter_scene`）側の未修正課題。EQMonitor からは `StaticInstanceGeometry`
の doc に書いた「1 geometry につき 1 ノード」制約を守ることで回避する。

`master` に対して再検証済み（2026-08-15）。上流の 81 コミットでは修正されておらず、
`instance_batching.dart` の差分は winding-flip 配線のみで挙動は当時のまま。

## 背景

`opaqueBatchEnd` / `depthBatchEnd`（`packages/flutter_scene/lib/src/render/instance_batching.dart`）
は batching 条件を `instancedVertexLayout != null` と geometry/material/pipeline の
identity だけで決めており、`Geometry.bindsModelTransformInstance` を参照しない。

`bindsModelTransformInstance == false` を返す geometry は「自前の instance-rate buffer を
末尾スロットへ bind する」ことを宣言しているが、batched 経路では `bind()` の**後**に
encoder が同じスロットを packed model transform で上書きする。

- `lib/src/scene_encoder.dart` `_encodeInstancedBatches`
- `lib/src/render/depth_prepass.dart` の batches 経路

単一ノード経路（`scene_encoder.dart` / `depth_prepass.dart` の per-item 側）は
このフラグを尊重しており、depth_prepass には「or it clobbers the stream slot」という
コメントまである。batched 側にだけ同じガードがない。

## 影響

1 つの `StaticInstanceGeometry`（例: 200万 instance）を 2 つのノードが共有し、
どちらも opaque・同一 pipeline・同一 fade・同一ライトリストだと batching が成立する。
結果、200万 instance がノード 2 件ぶん（160 バイト）の buffer を instance-rate で読む。
大幅な範囲外フェッチであり、同時に「毎フレーム repack しない」という型の存在意義も
この経路では失われる。

`BillboardGeometry` も同じ形（`bindsModelTransformInstance == false` + スロット自前 bind）
なので、これは `StaticInstanceGeometry` が作った失敗クラスではない。ただし
`StaticInstanceGeometry` は geometry をノード間で共有するのが自然に読める型なので露出は増える。

## やること

fork 側で、geometry が自前の instance データを供給する場合は batching しないようにする。
2 つの batch-end ヘルパへ 1 条件ずつ。

```dart
if (first.geometry.instancedVertexLayout == null ||
    !first.geometry.bindsModelTransformInstance ||   // 追加
    first.jointsTexture != null) {
  return start + 1;
}
```

該当 geometry は per-item 経路へ落ち、そちらは既にフラグを尊重している。
`BillboardGeometry` も同時に直る。

## 参照

- https://github.com/YumNumm/flutter_scene/pull/2#issuecomment-5297825484（fork 側の記録。fork は Issues 無効）
- Issue #1602 / #1612
