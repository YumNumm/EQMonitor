# eqmonitor_map line extrude projection

## 現在の契約

`LineMeshBuilder`はMVT入力と同じtile-local Y-down座標系で線分法線を生成する。
`BaseMapGeometryFactory`はFlutter Sceneへ渡す境界でY成分を反転し、`base_map_line.fmat`が
`vertex.world_position`へ直接加算できるclip/NDC Y-up座標系の押し出し方向として
`texCoords`へ積む。

この契約は、現在の`viewProjectionMatrixFor`が正射影・north-lockedで、回転やpitchを持たず、
screen logical pixelとworld pixelの対応が等方であることを前提にしている。

## Deferred work

pitch、bearing、perspectiveを導入する前に、MapLibre-styleの押し出し設計へ移行する。
具体的には、中心線と同じ行列の線形部で押し出しベクトルを変換してからprojection後の位置へ
加算する必要がある。現在のY反転だけの最小修正は、正射影かつnorth-lockedの間だけ正しい。

参照: `docs/knowledge/20260805_maplibre_native_renderer_reference.md`
