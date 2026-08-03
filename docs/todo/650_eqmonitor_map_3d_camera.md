# eqmonitor_mapを3D cameraと地下表示へ拡張する

## 背景

初期実装は北固定・真上視点だが、座標モデルは`altitudeMeters`を保持し、GPU頂点はXYZで扱う。

## 実施内容

- bearing / pitch
- 透視投影
- 地形と3D地物
- 負の高度を使う地下震源要素
- 断層面・断層モデル
- 地表、地下、overlayのrender phaseとdepth policy

既存featureモデルを作り直さずcamera/projection/rendererの拡張で実現する。
