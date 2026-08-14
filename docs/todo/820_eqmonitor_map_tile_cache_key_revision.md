# eqmonitor_map: tile cache key に revision / content digest を含める

## 背景

`BaseMapTileCache` の cache key は現在 `(sourceInstanceId, CanonicalTileId)` のみ。
`MapTileFallbackPolicy`（#1591 Task 13）は「revision 跨ぎの last-good は
`sourceInstanceId` が revision ごとに変わることで構造的に防がれる」という前提で
`allowsCrossRevisionLastGood == false` を表現しているが、**この前提は型として
強制されていない**。

`VerifiedRemotePmTilesSource` は `sourceInstanceId` と `sourceRevision` を
独立したフィールドとして持つため、source が `sourceInstanceId` を据え置いたまま
`sourceRevision` だけ上げることが可能である。その場合:

- `lookupWithFallback` の **exact hit が前 revision の geometry を返す**。
- fallback policy を通る前に返るため、hazard の fail closed も効かない。

renderer 設計（`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`
の `TileKey` 契約）とも矛盾する。

## 現状の緩和

- hazard レイヤーは #1591 時点で production 経路に未接続のため、実害は潜在的。
- basemap は同一 revision 内での親/子 fallback のみを許可している。

## やること

1. cache key を `(sourceInstanceId, sourceRevision または content digest,
   CanonicalTileId)` へ拡張する（専用の値型を導入するのが望ましい）。
2. `BaseMapTileCache` の `get` / `put` / `pin` / `unpin` / `lookupWithFallback`
   と、`base_map_view.dart`・既存 test の呼び出し側を追従させる。
3. revision が上がった際に前 revision の entry が exact hit しないことを test で
   固定する（basemap / hazard 双方）。
4. `map_tile_fallback_policy.dart` の doc から「構造的に担保されている」旨の
   記述を、実装後の実際の保証内容へ更新する。

## 参照

- PR #1627 review コメント（P1: "Include the revision or digest in every tile cache key"）
- Issue #1591 / parent #1611
