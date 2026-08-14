# eqmonitor_map: decode 並行度を MapTileScheduler で制御する（backpressure）

## 背景・根本原因

`BaseMapView._requestMissingDecodes`（`base_map_view.dart`）は、cover 内の
未 cache・未 pending tile **すべて**に対して即座に `unawaited(_decodeTile(...))` を
張る。`_decodeTile` は `BaseMapTileDecoder.decode`（=`Isolate.run`）を呼ぶため、
1 frame で数百枚の tile が要求されると **数百個の isolate を同時に spawn** し得る。

これは backpressure が無い状態で、低スペック端末で resource 枯渇・jank を招く。
`MapTileScheduler`（#1591 Task 12、実装済み）はこの制御のために作ったが、まだ
production 経路へ接続されていない（review 指摘 P1「scheduler が dead code」）。

## やること（Task 15 の主眼）

1. `MapBaseLayerLimits` に `maxInFlightDecodes`（>0、呼び出し側が明示）を追加。
   app の construction site（`eqmonitor_map_debug_page.dart`）と関連 test を追従。
2. `_requestMissingDecodes` を scheduler 駆動へ:
   - cover(`List<OverscaledTileId>`)→ `List<UnwrappedTileId>`（`toUnwrapped()`）。
   - `MapTileScheduler.selectNext(coverOrdered, inFlight: _pendingDecodes,
     completed: <cache hit の集合>)` で開始対象を `maxInFlightDecodes` 以内に絞る。
   - decode 完了ごとに次を start する drain ループ（`_decodeTile` の finally から
     再 schedule）。
3. camera 移動で cover から外れた in-flight は `tilesToCancel` で追跡を外し、
   `BaseMapTileCache.cancelInFlight()` で stale 結果を破棄する。
   - `Isolate.run` は起動後に中断できないため、「開始しない」＋「結果を捨てる」で
     cancel を表現する（ceiling: 走り始めた decode は最後まで CPU を使う。真の
     中断が要るなら永続 worker + kill が必要 → todo 845）。
4. widget/unit test:
   - `maxInFlightDecodes` を超えて同時 decode しない。
   - 中心近傍が先に decode される。
   - 別 world copy を二重 decode しない。
   - cover が変わったら外れた tile を再 decode し続けない。

## 判定基準

`MapTileScheduler` は既に coalesce / backpressure / wrap 考慮 priority / cancel を
unit test 済み。本 todo は **production 経路への配線と widget test** に集中する。

## 参照

- `packages/eqmonitor_map/lib/src/tile/scheduler/map_tile_scheduler.dart`
- `packages/eqmonitor_map/lib/src/widget/base_map_view.dart` `_requestMissingDecodes`
- PR #1627 review（P1: "Wire the scheduler and worker into the production view"）
- Issue #1591 / parent #1611
