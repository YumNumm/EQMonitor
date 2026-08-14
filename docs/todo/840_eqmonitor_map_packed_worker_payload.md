# eqmonitor_map: decode 結果を packed worker payload 化する（必要になったら）

## 現状の判定: 不要（計測済み）

`BaseMapTileDecoder` は decode 結果 `BaseMapTileGeometry`（Freezed ではない素の
immutable、内部は `Float32List`/`Uint16List` の mesh）を `Isolate.run` の SendPort
経由でそのまま返している。decoder doc（`base_map_tile_decoder.dart` 194–205 行）は
`TransferableTypedData` / packed payload を**使わない**ことを実測付きで決めている:

- realistic tile: decode+mesh ~2.6ms、出力 payload ~112KB。
- SendPort の TypedData コピーは <1ms（メモリ帯域、計測誤差の範囲）。
- packed 化の分岐・API の複雑さの方がコピー節約より上回る。

したがって versioned flat-buffer payload（header + vertex/index/offset/string/error
section、section ごとの byte 上限つき）を新設するのは、Global Constraints「根拠なく
重い機構を入れない」に反する。

## いつ着手するか

次のいずれかが**実測で**確認されたとき:

- 1 tile あたりの出力 payload が MB 級になり、SendPort コピーが frame 予算
  （~16ms / 8ms）を実測で侵食する。
- 永続 worker（todo 845）を導入し、同一 buffer を zero-copy で渡したくなった。

## 着手する場合の要件（review 指摘 P1 由来）

- payload 総 byte と section/table ごとの件数上限を、**確保・転送の前に**
  呼び出し側の設定として検証する。上限超過は typed exception（空 payload に
  丸めない）。現状これは decode 側の `MvtDecodeLimits` が同じ役割を担っている。

## 参照

- `packages/eqmonitor_map/lib/src/tile/base_map_tile_decoder.dart`
- PR #1627 review（P1: "Bound every packed worker payload section"）
- #1591 Task 10 / parent #1611
