# BaseMapのFlutter Scene camera契約

## #1589で正式な経路

`scene.NodeCamera`のprojectionは恒等にし、CPUのdouble精度で
`clip = viewProjection * tileMatrix * position`を合成してから、各nodeの
`localTransform`へ一度だけ渡す。custom materialのline押し出しはclip/NDC
空間で行うため、半線幅もviewport由来のNDC単位にする。

`BaseMapView`では`baseMapTileViewProjectionMatrixFor(...)`がこの行列を作る。
decode済みのsource layerごとのextentと、fallback確定後のtile ID・zoomを入力にし、
同じtransformをlayer nodeへ適用する。

## #1589で正式ではない経路

spike/preflightの`NodeCamera` + `FlutterSceneOrthographicProjection`はこのpinで
可視出力を確認できていない。BaseMapの成立根拠にせず、#1593でGPU lifecycle、
context recovery、resizeと一緒に扱う。

## 自動確認

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/geo/tile_matrix_test.dart test/tile/base_map_render_plan_builder_test.dart
```
