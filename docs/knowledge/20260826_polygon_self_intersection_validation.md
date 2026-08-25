# Polygon mesh の自己交差検証

## 原則

`dart_earcut` は自己交差Polygonを入力エラーとして拒否するvalidatorではない。
実用的な三角形化を試みるため、戻り値が得られても入力geometryが有効とは限らない。
信頼できないMVTを描画する前に、`FillMeshBuilder`側で境界の自己交差を検証する。

## 実装上の制約

- 辺を`minX`順に処理し、`maxX`が現在位置より小さい辺を比較対象から外す。
- 同一ringの隣接辺は比較しない。
- X範囲が重なる非隣接辺だけをcaller必須の`maxIntersectionChecks`で数える。
- Y範囲が重なる場合だけ整数orientationで接触・交差・重複を判定する。
  Int64の積差が安全な範囲は通常の整数演算を使い、それを外れる座標だけ
  `BigInt`で符号を正確に求める。
- 境界交差がなくても、外形外の穴、穴同士の包含、外形同士の包含は
  `FillMeshInvalidTopologyException`として拒否する。
- `maxIntersectionChecks`は、境界交差候補と包含判定を合計し、tileごとに
  生成する1つの`FillMeshBuilder`の全`build`呼び出しで共有する。
- 上限超過は`FillMeshLimitExceededException`、交差は
  `FillMeshSelfIntersectionException`として返す。

debug地図の基図policyは、最大65,536頂点の通常形状を受理しながら比較処理を
有限化する値として、1 tileあたり約100万件を明示する。

## 確認コマンド

```sh
mise exec -- flutter test test/mesh/polygon_self_intersection_validator_test.dart
mise exec -- flutter test test/mesh/fill_mesh_builder_test.dart
mise exec -- flutter test test/tile/estimated_intensity_tile_decoder_test.dart
```
