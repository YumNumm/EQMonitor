# eqmonitor_map: tile budget に retained CPU/GPU byte の集計上限を追加する

## 背景

`MapTilePipelineBudget`（#1591 Task 4）は現在、次の**件数・並列度**の上限しか
持っていない。

- `maxInFlightDecodes` / `maxCacheEntries` / `maxPinnedEntries`
- `cpuWorkUnitsPerFrame`（計算量であって保持 byte 量ではない）
- `maxGpuUploadBytesPerFrame`（1 frame の転送量であって保持総量ではない）

per-tile の `MvtDecodeLimits` を満たす正当な tile でも、vertex / index /
property / string の実サイズは tile ごとに桁が違う。したがって
`maxCacheEntries` だけでは、`BaseMapTileCache` の pin/eviction（Task 14）が
掲げる「no unbounded growth」を **byte 単位では保証できない**。大きい geometry
ばかりが上限件数まで載ると memory を食い潰し得る。

## やること

1. `MapTilePipelineBudget` へ retained byte の集計上限を追加する
   （例: `maxRetainedCpuBytes` / optional `maxRetainedGpuBytes`）。
   `createMapTilePipelineBudget` で正値検証すること（hidden default を作らない）。
2. `BaseMapTileGeometry` の保持 byte を見積もる手段を用意する
   （mesh の `positions` / `indices` の `lengthInBytes` 合計など）。
3. `BaseMapTileCache` の eviction を件数と byte の**両方**で駆動する。
   pin 済み entry は保護しつつ、pin 合計 byte も上限内に収める。
4. 大きい geometry を入れたときに byte 上限で evict されることを test で固定する。

## 参照

- PR #1627 review コメント（P2: "Add aggregate byte limits to the cache budget"）
- Issue #1591 / parent #1611
