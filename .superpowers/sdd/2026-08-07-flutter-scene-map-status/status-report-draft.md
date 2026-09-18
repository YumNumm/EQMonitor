# Flutter Scene マップ実装 — 状態統合レポート

調査日: 2026-08-07
指揮: 親エージェント / 調査: Task 1–5 subagents（全件完了）

## 総合判定

**foundation / alpha 手前。** `packages/eqmonitor_map` は PMTiles → MVT decode →
Fill/Line mesh → Flutter Scene node/material/camera の縦切りが通っており、単体テストは
22 ファイル・196 件と厚い。ただし本番マップ面への統合はゼロで、描画結果を守る
Widget/Golden/物理端末の検証層が欠けている。生命に関わる表示の置換先としては、
描画差分・性能・操作回帰を検知できない状態。

## 1. 計画・設計の進捗

| 項目 | 状態 | 根拠 |
| --- | --- | --- |
| 設計正本 (2026-08-02 renderer design) | merged (#1565) | `7ed21d1e7` |
| Scene spike (2026-08-02) | superseded | #1566 → #1574 で evidence gate 削除 |
| mise / spike 簡素化 (2026-08-03) | merged (#1574) | `4921a9b1e` |
| base-layer PMTiles 縦切り (2026-08-05) | **partial** | #1579 `71f9a10d8`, #1580 `26c915608` |
| seismicity 3D (2026-08-02) | 別スコープ | 2D base map 完了条件とは無関係 |

3計画ともチェックボックスは全件未チェック（旧spike 51 / 簡素化 38 / base-layer 94）。
進捗は merge commit・README・TODO から読むしかない運用上の負債。

## 2. 設計正本に対する未実装

- production public API: `EqmonitorMapView` / `EqmonitorMapController` / `MapScene` /
  typed `MapNode` / reconciler（`MapNode → MapElement → MapRenderObject`）
- ラベル（PMTiles label anchor + TextPainter placement / collision / leader line）
- 動的 hazard layer、現在地、P/S波、typed snapshot/delta、fresh/stale/expired
- hit test / semantics
- remote PMTiles、signed sidecar attestation、producer semantic validation
- Performance HUD と観測基盤

現公開 API は `BaseMapView` + `VerifiedPmTilesSource` + `MapCamera` + limits 群 +
`pmtiles_v3` 再export。debug/foundation renderer を起動する最小面。

## 3. アプリ統合

- `app/pubspec.yaml` は `eqmonitor_map` に path 依存済み。`maplibre: ^0.3.5` も併存。
- 実利用は `/settings/debug/eqmonitor-map`（`EqmonitorMapDebugPage` → `BaseMapView`）のみ。
- todo 780 の本番 surface **11面すべて `MapLibreMap` 直接 host**。部分移行ゼロ。
- 本番切替の feature flag / dart-define / runtime 分岐は存在しない。
- `MapLibreEventProvider`、`MapOperationQueueScope`、`queryLayers`、`fitBounds`、
  `getVisibleRegion`、`lockBearing` は全面的に現役で削除不可。

## 4. 既知の correctness debt

| 優先 | 項目 | 内容 |
| --- | --- | --- |
| 高 | flood post-fix 検証 | 真因は `setCustomAttribute('extrude')` がshaderに届かずpositionが読まれていたこと。`texCoords` 経由 (`32377f2f3`) と半線幅NDC換算 (`14916951f`) で対策済みだが、**修正後の目視証跡なし**。READMEの「未着手」は stale。 |
| 高 | MVT extent 固定 | `MvtDecoder` は extent を読むが `BaseMapTileGeometry` が保持せず、`base_map_view.dart` が `mvtDefaultExtent`=4096 を固定で渡す。実archiveは全layer 4096のため現状は破綻しないが設計違反。 |
| 中 | tile buffer の clip/scissor 無し | `FillMesh`/`LineMesh` が tile 境界外頂点を保持したまま描画。境界品質の保証なし。 |
| 中 | ancestor fallback の重複描画 | 複数 visible tile が同一祖先へ fallback すると同じ geometry を複数 node で描画。不透明色前提に依存。 |
| 中 | `NodeCamera + EqmonitorOrthographicProjection` | この配線で描画されない疑いが TODO に記録。`BaseMapView` は identity camera + node 焼き込みで回避しているが spike/preflight の信頼性に影響。 |
| 中 | join/cap | miter + butt のみ。bevel/round/dash/`linesofar` 未実装。 |
| 低〜中 | properties / feature ID 未 decode | label / hit test / semantics の前提として必要。 |

## 5. 検証の現状

**自動テスト（厚い）**: 22ファイル・196件。MVT decode（実tile fixture 2件 + 合成 +
limit + malformed拒否）、Fill mesh（hole/winding/segment split）、Line mesh（miter
limit / closed loop / ring境界不変条件）、tile cover（wrap/overscale/sort）、tile
cache（LRU/非対称zoom窓/fallback）、projection、Scene adapter 引数、spike lifecycle。

**未カバー（deferred）**: `BaseMapView` 本体の Widget test（検証済みは gesture の
pure 関数のみ）、Golden、GPU upload、性能ベンチと回帰閾値、Performance HUD、
物理 iOS/Android profile/release smoke、pinch zoom、背景色、線幅・tile境界の目視。

**CI**: `pr-flutter-check.yaml` から `eqmonitor_map_scene_spike` job が起動
（path filter `packages/eqmonitor_map/**`）。Android/iOS で `flutter analyze
--fatal-infos` と example の profile/release build。**build gate であり描画
correctness gate ではない。**

**今回のローカル実行**: `mise exec -- flutter test --no-pub` は依存解決状態により
テスト開始前に失敗。read-only 方針のため `pub get` は未実行。

**simulator 確認済み（Task 10 時点、修正前）**: iPhone 17 Pro / iOS 27.0 で本番相当
`all.pmtiles` z0..8 の海岸線 Fill 描画、1本指 pan での tile 差し替え、zoom clamp。

## 6. dashmap（bdero）参考実装

MIT / 最新 commit 2026-08-06 / flutter_scene 0.18.1 path依存。
**terrain raster + 衛星画像 + Overpass building extrusion の 3D デモ**であり、
PMTiles・MVT・line stroking・extent・tile clip・label は存在しない（= 直接の
参考にはならない領域が多い）。

転用価値のある知見:

1. **入力 tile のスケールを固定値に隠さない** — dashmap は `projectedTileSize(z)` を
   mesh job へ明示的に渡す。EQMonitor の extent 4096 固定と対照的。
2. **shader の座標空間を material parameter とセットで検証する** — globe wrap は
   `curve_center` / `focus_merc_yn` で相対座標を渡し、vertex stage の空間を明示。
3. **tile 境界処理を renderer policy として持つ** — skirt geometry + `clampToEdge`。
4. **GPU upload の frame budget 化** — terrain 3 tile/frame、building 1 chunk/frame、
   24000 vertex chunk。EQMonitor は `_rebuildSceneNodes` が毎回 `removeAll()` →
   `addAll()` で Scene graph を作り直している。
5. **worker isolate での mesh 構築**、in-flight cap、exponential backoff、
   coarse-to-fine stand-in（render set は重複なし・load set は ancestor pyramid）。
6. **floating origin** — 将来の 3D / 地下震源で float32 精度を保つ設計の参考。

コピーしないもの: live 第三者データを render path に入れる構造（Asset Pack
attestation 前提と衝突）、OSM default height と `(id % 7)` の height jitter（推測値を
事実として描かない）、JSON を hot path に置く設計、StatefulWidget 中心の巨大画面、
hole 非対応 ear clipping、無条件の `frustumCulled = false`、無制限 disk cache。

## 7. 推奨する次マイルストーン

Home 統合や `MapScene` 全面実装より先に「`BaseMapView` stabilization slice」を置く。

1. flood/線幅の **post-fix 視覚確認**（screenshot/log 付き）と README/TODO の再同期
2. MVT `extent` を `BaseMapTileGeometry` へ伝播し 4096 固定を除去
3. `BaseMapView` の最低限の Widget / golden smoke を整備
4. 物理 iOS または Android の profile/release で pan / pinch / 線幅 / tile境界 /
   fallback / background 復帰を確認
5. debug `BaseMapView` と production `EqmonitorMapView` / `MapScene` の API 境界確定

その後に labels → dynamic layers → Home integration のスタックへ進む。
