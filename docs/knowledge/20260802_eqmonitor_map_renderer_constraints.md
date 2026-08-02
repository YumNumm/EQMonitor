# eqmonitor_mapで維持する設計制約

## 初期surface

- `packages/eqmonitor_map`はEQMonitor専用とする。
- 初期対象はiOS/Android、北固定・真上視点とする。
- Flutter Sceneで地物、Flutter `TextPainter`でラベルを描画する。
- ラベルアンカーはPMTiles生成時に専用Pointレイヤーへ格納する。
- 動的描画でGeoJSONを介さない。

## 将来互換性

- 地理座標は`altitudeMeters`を持ち、2D段階でもZ軸を削除しない。
- 地表は0、地下震源や断層は負、地上要素は正の高度を使う。
- Geographic、Mercator、Tile Local、Camera-relative World、Screenを別の型と責務で扱う。
- GPUへ渡す座標はcamera origin rebasingを行い、高zoomと3Dのfloat精度低下を避ける。
- bearing、pitch、透視投影、地下表示はfeatureモデルではなくprojection/rendererを拡張する。

## 宣言と実体

- 公開APIは不変なFreezed `MapNode`ツリーとする。
- 内部`MapElement`がkeyとnode型でmount/update/unmountを行う。
- Flutter Widget/Elementの内部APIへ依存しない。
- GPU/HTTP/Controllerなどの実行時資源をJSONモデルへ混ぜない。

## 性能観測

- HUDや性能試験より先に`MapPerformanceSnapshot`と`MapPerformanceEvent`を実装する。
- tile request、decode、mesh build、GPU upload、cache、label、frameを同じ計測基盤で観測する。
- Feature単位のScene Nodeを作らず、tile/layer/material単位でbatchする。

## 検証コマンド

Flutter/Dartコマンドは必ず`mise exec --`経由で実行する。

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test
mise exec -- dart analyze
```
