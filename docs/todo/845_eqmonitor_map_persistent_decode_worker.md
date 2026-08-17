# eqmonitor_map: decode を永続 worker isolate 化する（計測後）

## 背景

`BaseMapTileDecoder.decode` は tile ごとに `Isolate.run` で使い捨て isolate を
起動して decode する。これは「UI Isolate で decode 禁止」という hard 制約を既に
満たしているが、多数 tile を短時間に decode する場面では **isolate 起動コストが
tile 数に比例して積み上がる**可能性がある。

decoder の doc（`base_map_tile_decoder.dart`）は per-call `Isolate.run` の起動コストを
`compute` と同等として問題視していないが、これは単発 decode の話。pan/pinch で
cover が大きく変わり数百 tile を連続 decode する production シナリオでの実測は
まだ無い。

## やること（**実測で問題が確認できてから**着手）

1. まず計測: 実機（低スペック含む）で cover 総入れ替え時の decode スループットと
   isolate 起動オーバーヘッドを frame timing で取る。問題が無ければ着手しない。
2. 問題があれば、長命な decode worker isolate（`ReceivePort`/`SendPort` で
   job を投げる）に置き換える。
   - cancel: port を閉じて worker を retire。待機中の呼び出し側を error にしない。
   - incarnation: `AsyncGenerationToken` で stale 結果を破棄（cache 側は既存）。
3. `TransferableTypedData` の要否も同時に再評価する（todo 840）。ただし現時点の
   計測では不要と判断済み。

## 参照

- `packages/eqmonitor_map/lib/src/tile/base_map_tile_decoder.dart`
- todo 830（scheduler 配線）/ todo 840（packed payload）
- #1591 Task 11 / parent #1611
