# EQMonitor Map 04-tile-pipeline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Issue #1591 — verified source / trust / PMTiles / MVT / remote identity+range fixture / worker payload / scheduler / cache を、ベースレイヤー縦切りの暫定実装から本番契約へ拡張する。

**Architecture:** `eqmonitor_map` は `app` 非依存のまま、呼び出し側が渡す immutable `Verified*Source` だけを受理する。ローカル検証済み path は既存 `VerifiedPmTilesSource` を維持し、remote は identity encoding + strong validator 付き Range のみを合成する。MVT decode / mesh は UI Isolate 禁止で packed worker payload へ載せ、incarnation token で古い結果を破棄する。basemap は同一 revision の親/直前 tile fallback 可、hazard は revision 跨ぎ last-good 禁止（fail closed）。CPU/GPU budget・pin・eviction は設定モデルで明示する。

**Tech Stack:** Flutter pin `4dacd3fc91d96262a33e5c598e17d816f0b35641`、Dart、Freezed、`pmtiles_v3`、既存 `eqmonitor_map` tile/MVT、mise、`TransferableTypedData`。remote Range 契約は `seismicity_pmtiles` network reader（#1600 / #1619）の validator 設計を参照するが、震源 package へ依存しない（地図側へ同等契約を移植または共有最小型のみ）。

## Global Constraints

- Flutter/Dart は必ず `mise exec --` 経由。依存追加は `mise exec -- flutter pub add`。生成は `mise exec -- dart run build_runner build --delete-conflicting-outputs`。
- `eqmonitor_map` / `pmtiles_v3` は `app` へ依存しない。Asset Pack / manifest / attestation 検証は app 所有。
- 欠損 tile = `null`。破損・上限超過・schema 不整合 = typed exception。空 tile へ丸めない。
- remote: `Accept-Encoding: identity`。非 identity Content-Encoding 拒否。strong validator なしの Range 合成禁止。`200 OK` で Range 要求 body 全体受理禁止。
- UI Isolate で MVT decode / mesh 構築禁止。cancel はエラーにしない。古い incarnation の結果は attachment も通知もしない。
- basemap: 同一 `sourceRevision`/digest 内の親・直前 fallback 可。hazard: revision 跨ぎ last-good 禁止。
- 上限・budget は呼び出し側が渡す version 付き設定。decoder 内部の隠れた固定 fallback 禁止。
- 本 Issue は Scene Fill/Line 一般化（#1593）、label asset（#1592）、Home 切替（#1596）を実装しない。
- Backend / Asset Pack producer は触らない。attestation sidecar 検証は #1592。
- 本 PR の成功判定は `packages/eqmonitor_map`（と追加 fixture package）の focused analyze/test。共有 Flutter gate が赤い場合は **無条件に baseline 扱いしない**。devices primary constructor / freezed `final` を理由とする waiver は `f0b3bd37`（#1628）で解消済みのため既に無効。現在 waive してよい既知失敗の一覧と判定手順は `docs/knowledge/20260814_stacked_pr_flutter_gate_baseline.md` を正本とし、そこに載っていない赤は回帰として調査する。
- 各タスクの本番+手書き test は 30–100 行目安。生成物は別計上。コミット prefix は英語1語+日本語1行。

## Baseline（#1589 / #1590 で既にあるもの）

再利用し、破壊的に作り直さない。

| 既存 | 役割 | 本 Issue での扱い |
|---|---|---|
| `VerifiedPmTilesSource` | ローカル検証済み path/size/sha256 | 維持。remote 用 descriptor を追加 |
| `MvtDecoder` / `MvtDecodeLimits` | strict MVT + 上限 | 維持。worker 経由へ移設 |
| `BaseMapTileCache` + incarnation | LRU / zoom 窓 / 子→親 fallback / cancel | basemap policy として明示。hazard policy を分離 |
| `BaseMapTileRepository` | ローカル PMTiles → tile bytes | remote reader 差し込み境界を追加 |
| `SceneSpikeAsyncGeneration*` | incarnation token | domain 名へ昇格（spike 依存を断つ） |
| `TileCoverCalculator` / render plan | cover / transform | 触るなら回帰テスト必須 |

## Out of scope

- #1592 signed sidecar / Asset Pack label Point
- #1593 Scene adapter 一般化・GPU lifecycle
- #1602 Flutter Scene fork
- backend B1 producer
- Home / MapLibre 並行切替

## Stack

1. #1616 `fix/eqmonitor-map-base-layer-residuals` → `develop`
2. #1617 `feat/eqmonitor-map-foundation` → #1616
3. **本 branch** `feat/eqmonitor-map-tile-pipeline` → #1617（Issue #1591）

Worktree: `.worktrees/flutter-scene-map-tile-pipeline`

---

- [x] **Step 1: Write the failing/pinning tests** for missing tile → `null`, corrupt bytes → typed exception, never empty geometry.
- [x] **Step 2: Run** `(cd packages/eqmonitor_map && mise exec -- flutter test test/tile/verified_source_contract_test.dart)`（`eqmonitor_map` は Flutter SDK 依存のため `dart test` は `dart:ui` 解決に失敗する。加えて **package ディレクトリから**実行しないと fixture 解決 root がずれる。`docs/todo/700_melos_dart_test_package_filter.md` / CI の `wc-check-dart-test.yaml` 参照）
- [ ] **Step 3: Fix only if RED** at the owning boundary.
- [ ] **Step 4: Re-run GREEN**
- [ ] **Step 5: Commit** `test: ローカル verified source 契約をピン留め`

---

### Task 2: incarnation token を spike から domain へ昇格

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/async_generation_token.dart`
- Modify: `packages/eqmonitor_map/lib/src/tile/base_map_tile_cache.dart`（import 差し替え）
- Modify/Delete path: spike ファイルからの参照を断つ（spike 本体は残してよい）
- Test: `packages/eqmonitor_map/test/foundation/async_generation_token_test.dart`

**Interfaces:**
- Produces: `AsyncGenerationOwner` / `AsyncGenerationToken`（cancel は非 error、stale put 無視）
- **世代は `begin()` では進めない**（review 指摘 P1）。1 incarnation = 1 camera 状態とし、その中で発行した token はすべて等しく有効にする。`begin()` ごとに世代を進めると、Task 12 が `maxInFlightDecodes > 1` で並行 decode を始めた瞬間、最後に開始した1件以外の結果が `put` で黙って捨てられる。世代を進めるのは `cancel()` / `dispose()` のみ。

- [ ] **Step 1: Write failing tests** for begin/cancel/dispose/stale ignore.
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement domain token; rewire cache**
- [ ] **Step 4: Run GREEN + cache existing tests**
- [ ] **Step 5: Commit** `refactor: incarnation token を foundation へ昇格`

---

### Task 3: SourceKind と revision 付き verified descriptor 拡張

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/tile/verified_pm_tiles_source.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/verified_remote_pm_tiles_source.dart`（または同一ファイルの sealed 化）
- Test: `packages/eqmonitor_map/test/tile/verified_source_models_test.dart`

**Interfaces:**
- Produces: local `VerifiedPmTilesSource` + remote `VerifiedRemotePmTilesSource`（https URL、allowlist 済み host 前提の descriptor、expected size/digest、`sourceInstanceId`、`sourceRevision`）
- package は URL の DNS/TLS を再検証しない（app が検証済み）

- [ ] **Step 1: Write failing model/equality tests**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement Freezed models + generate/normalize**
- [ ] **Step 4: Run GREEN**
- [ ] **Step 5: Commit** `feat: remote verified PMTiles descriptor を追加`

---

### Task 4: MapDecodeLimits / budget 設定モデル

**Files:**
- Create: `packages/eqmonitor_map/lib/src/tile/map_tile_pipeline_budget.dart`
- Test: `packages/eqmonitor_map/test/tile/map_tile_pipeline_budget_test.dart`

**Interfaces:**
- Produces: version 付き `MapTilePipelineBudget`（max in-flight decodes、max cache entries、pin 上限、CPU work units、optional GPU upload bytes/frame）。hidden default なし。

**残要件（review 指摘 P2、未実装）:** 件数だけでなく **retained CPU/GPU byte の集計上限** を持たせる。per-tile decode 上限内でも tile ごとの vertex/index/property/string の実サイズは大きく異なるため、`maxCacheEntries` だけでは Task 14 の「no unbounded growth」を byte 単位で保証できない。`docs/todo/810_eqmonitor_map_tile_budget_retained_bytes.md` 参照。

- [ ] **Step 1: Write failing construction/validation tests**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement**
- [ ] **Step 4: Run GREEN**
- [ ] **Step 5: Commit** `feat: tile pipeline budget 設定モデルを追加`

---

### Task 5: remote HTTP identity validator（地図側）

**Files:**
- Create: `packages/eqmonitor_map/lib/src/tile/remote/map_http_identity_validator.dart`
- Test: `packages/eqmonitor_map/test/tile/remote/map_http_identity_validator_test.dart`

**Interfaces:**
- Consumes: response headers
- Produces: accept only missing/`identity` Content-Encoding; reject gzip/br/etc with typed error

- [ ] **Step 1: Write failing table tests**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement**
- [ ] **Step 4: Run GREEN**
- [ ] **Step 5: Commit** `feat: remote identity encoding validator を追加`

---

### Task 6: Content-Range / strong ETag / If-Match 契約

**Files:**
- Create: `packages/eqmonitor_map/lib/src/tile/remote/map_http_range_validators.dart`
- Test: `packages/eqmonitor_map/test/tile/remote/map_http_range_validators_test.dart`

**Interfaces:**
- Produces: validators requiring 206、exact Content-Range、stable total length、strong ETag（weak `W/` 拒否）、body length match。412 / mismatch → discard all bytes + typed snapshot mismatch。

- [ ] **Step 1: Write failing contract table**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement**
- [ ] **Step 4: Run GREEN**
- [ ] **Step 5: Commit** `feat: remote Range/ETag 契約 validator を追加`

---

### Task 7: identity-encoded remote Range fixture harness

**Files:**
- Create: `packages/eqmonitor_map/test/support/controlled_remote_pmtiles_server.dart`（または同等）
- Create: fixture bytes under `packages/eqmonitor_map/test/fixtures/remote_pmtiles/`
- Test: `packages/eqmonitor_map/test/tile/remote/identity_range_fixture_test.dart`

**Interfaces:**
- Produces: local loopback server that speaks identity encoding + strong ETag + 206 only for Range；rejects non-identity；never accepts full 200 for Range request as success path for random-access reader

- [x] **Step 1–5 完了**: `test/support/controlled_remote_pmtiles_server.dart`（dart:io loopback）で identity + strong ETag + 206 を返し、status / Content-Encoding / redirect / ETag を切り替えられる。fixture bytes は別ファイルにせず `MinimalPmTilesArchiveBuilder` で生成。Task 8 の reader test が harness を消費する。

---

### Task 8: Map remote random-access reader

**Files:**
- Create: `packages/eqmonitor_map/lib/src/tile/remote/map_remote_pm_tiles_reader.dart`
- Test: `packages/eqmonitor_map/test/tile/remote/map_remote_pm_tiles_reader_test.dart`

**Interfaces:**
- Consumes: Task 5–7 validators + `VerifiedRemotePmTilesSource`
- Produces: `Future<Uint8List> readAt({required int offset, required int length})` with LRU、in-flight coalesce、generation cancel、close/retire。No asset fallback.

**必須の追加要件（review 指摘 P1。Task 5–6 の validator だけでは満たせない）:**
- **expected digest への束縛**: strong ETag は「リクエスト間の整合性」しか保証せず、attested asset との対応は保証しない。CDN/origin が安定した ETag のまま古い/別の archive を返す場合を検出するため、`VerifiedRemotePmTilesSource.sha256` / `sizeBytes` と実データを突き合わせる（archive 全体の digest 検証、または header/root directory を含む検証済み範囲との照合）。digest 不一致は typed exception で fail closed。
- **redirect 方針の強制**: app の事前検証は初期 URL のみ。reader は redirect を無効化するか、host/scheme(https)/回数を検証して allowlist 外・HTTPS→HTTP へ出た時点で fail closed する。controlled redirect fixture で test する。

- [x] **Step 1–5 完了**: `MapRemotePmTilesRandomAccessReader implements PmTilesRandomAccessReader`。HTTP は `dart:io HttpClient`（新規依存なし）。identity / 206 / strong ETag / 厳密 Content-Range / body 長を検証し、初回で strong ETag を pin して以後 `If-Match`。redirect(3xx)は fail closed、snapshot drift は terminal、`(etag,offset,length)` の並行 read を coalesce、直近範囲を `maxCacheBytes` LRU で再利用、close 後は fail closed。実 loopback サーバで 8 ケースを test。
  - **未対応（別タスクへ送り）**: `sha256` への digest 束縛（上記 P1）は本 reader では未実装。CDN が同一 ETag で別 archive を返すケースの検出は、archive open 後に検証済み範囲の digest を突き合わせる別レイヤーが要る。`docs/todo/815_eqmonitor_map_remote_digest_binding.md` 参照。
  - `dart test` ではなく実 HTTP を使うため cancel は「close で in-flight socket を force-close」で表現（Dio の `CancelToken` は使わない＝新規依存を避けた）。

---

### Task 9: TileRepository を local/remote 両 descriptor 対応へ

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/tile/base_map_tile_repository.dart`
- Test: `packages/eqmonitor_map/test/tile/base_map_tile_repository_remote_test.dart`

**Interfaces:**
- Produces: same `Future<Uint8List?>` tile fetch surface; remote path uses Task 8 reader + `pmtiles_v3`

- [x] **Step 1–5 完了**: `BaseMapTileRepository.open` を sealed `VerifiedTileSource` で分岐（local→file reader / remote→Task 8 reader）。`readTile` の surface は不変。remote は `remoteMaxCacheBytes` を必須にした（hidden default なし）。実 loopback サーバで build→serve→open→readTile の end-to-end を test。
- [ ] ~~Step 1: Write failing remote fetch test via fixture~~
- [ ] ~~Step 2: Run RED~~
- [ ] ~~Step 3: Wire repository~~
- [ ] **Step 4: Run GREEN + existing repository tests**
- [ ] **Step 5: Commit** `feat: TileRepository を remote verified source 対応`

---

### Task 10: packed worker payload 型（versioned flat buffer）

**Files:**
- Create: `packages/eqmonitor_map/lib/src/tile/worker/map_tile_worker_payload.dart`
- Test: `packages/eqmonitor_map/test/tile/worker/map_tile_worker_payload_test.dart`

**Interfaces:**
- Produces: versioned payload header + vertex/index/offset/string/error sections suitable for `TransferableTypedData`. No Freezed object graph of features in the hot path return.

**判定: 本 Issue では実装しない（YAGNI / 計測済みの決定と矛盾する）。**
`BaseMapTileDecoder.decode` は既に `Isolate.run` で UI isolate 外で decode し、
その doc（`base_map_tile_decoder.dart` 194–205 行）で `TransferableTypedData` を
**使わない**ことを実測付きで決めている（realistic tile で decode+mesh ~2.6ms /
出力 ~112KB、SendPort コピーは <1ms で計測誤差の範囲、packed 化の複雑さの方が
上回る）。したがって packed flat-buffer payload を新設するのは「根拠なく重い機構を
入れない」という Global Constraints に反する。review 指摘の「payload section の
byte 上限」は、packed payload 前提の要件であり、Freezed object graph を SendPort で
そのまま渡す現行方式では **decode 側の `MvtDecodeLimits`（layer/feature/vertex 数の
上限）が既に同じ役割**を果たしている。将来 packed 化が必要になった場合の残課題は
`docs/todo/840_eqmonitor_map_packed_worker_payload.md`。

- [ ] **Step 1: Write failing encode/decode roundtrip tests**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement**
- [ ] **Step 4: Run GREEN**
- [ ] **Step 5: Commit** `feat: tile worker packed payload を追加`

---

### Task 11: decode worker + UI Isolate 禁止ゲート

**Files:**
- Create: `packages/eqmonitor_map/lib/src/tile/worker/map_tile_decode_worker.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/worker/map_tile_decode_client.dart`
- Test: `packages/eqmonitor_map/test/tile/worker/map_tile_decode_worker_test.dart`

**Interfaces:**
- Consumes: payload + incarnation token + budget
- Produces: client that runs decode off UI isolate; cancel closes port / retires worker without erroring callers waiting on stale work

**判定: hard 制約は既に達成済み。永続 worker 化は計測待ちで defer。**
「UI Isolate で MVT decode / mesh 構築禁止」は `BaseMapTileDecoder.decode` の
`Isolate.run` で既に満たしている（decode は毎回 UI 外 isolate で走る）。Task 11 が
追加で狙うのは **per-call `Isolate.run` を永続 worker に替えて isolate 起動コストを
削る**最適化だが、decoder doc は per-call のコストを `compute` と同等として問題視して
いない。多数 tile を同時 decode するときの起動コストが実測で問題になって初めて
永続化する。残課題は `docs/todo/845_eqmonitor_map_persistent_decode_worker.md`。
- incarnation の stale 破棄は `BaseMapTileCache`（`AsyncGenerationToken`）が既に担う。
- **並行度の制御（backpressure）は別問題で、こちらは未達**。現行の
  `_requestMissingDecodes` は cover 内の欠損 tile 全部へ無制限に `Isolate.run` を
  張る。ここに Task 12 の `MapTileScheduler` を挿すのが Task 15 の主眼
  （`docs/todo/830_eqmonitor_map_scheduler_wiring.md`）。

---

### Task 12: TileScheduler（priority / backpressure / coalesce）

**Files:**
- Create: `packages/eqmonitor_map/lib/src/tile/scheduler/map_tile_scheduler.dart`
- Test: `packages/eqmonitor_map/test/tile/scheduler/map_tile_scheduler_test.dart`

**Interfaces:**
- Consumes: budget max in-flight、tile keys、incarnation
- Produces: center-near priority、duplicate identity coalesce、camera move cancel、queue backpressure

- [ ] **Step 1: Write failing scheduler tests**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement**
- [ ] **Step 4: Run GREEN**
- [ ] **Step 5: Commit** `feat: tile scheduler を追加`

---

### Task 13: basemap vs hazard fallback policy

**Files:**
- Create: `packages/eqmonitor_map/lib/src/tile/map_tile_fallback_policy.dart`
- Modify: `packages/eqmonitor_map/lib/src/tile/base_map_tile_cache.dart`（policy 注入）
- Test: `packages/eqmonitor_map/test/tile/map_tile_fallback_policy_test.dart`

**Interfaces:**
- Produces: `basemap` allows parent/previous within same revision; `hazard` forbids cross-revision last-good and fails closed on miss/expiry

**cache key の内容束縛（review 指摘 P1、対応済み）:** cache は`(identity, CanonicalTileId)`で引くが、identity に `VerifiedTileSourceCacheIdentity.cacheIdentity`（`sourceInstanceId` + 内容 digest）を渡すことで、source が `sourceInstanceId` を据え置いたまま中身を差し替えても exact lookup が前 revision の geometry を返さないようにした。digest は revision 番号より強い保証になる。

- [ ] **Step 1: Write failing policy matrix tests**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement + wire cache**
- [ ] **Step 4: Run GREEN + existing fallback tests**
- [ ] **Step 5: Commit** `feat: basemap/hazard tile fallback policy を分離`

---

### Task 14: pin / eviction を budget へ接続

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/tile/base_map_tile_cache.dart`
- Test: `packages/eqmonitor_map/test/tile/base_map_tile_cache_budget_test.dart`

**Interfaces:**
- Consumes: `MapTilePipelineBudget`
- Produces: explicit pin set + LRU eviction respecting pins; no unbounded growth

- [ ] **Step 1: Write failing pin/eviction tests**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement**
- [ ] **Step 4: Run GREEN**
- [ ] **Step 5: Commit** `feat: cache pin/eviction を budget 接続`

---

### Task 15: 統合 contract test（local + remote identity fixture）

**Files:**
- Test: `packages/eqmonitor_map/test/tile/tile_pipeline_contract_test.dart`
- Modify: `packages/eqmonitor_map/README.md`（契約と検証コマンド）

**Interfaces:**
- Produces: end-to-end local verified + remote identity range fixture covering cancel/incarnation; documents focused gate commands

**production 配線（review 指摘 P1）: scheduler は配線済み。**
`MapBaseLayerLimits.maxInFlightDecodes` を追加し、`BaseMapView._requestMissingDecodes`
を `MapTileScheduler.selectNext` 駆動へ差し替えた。cover 内の欠損 tile を無制限に
`Isolate.run` していたのを、中心近傍優先・canonical 単位 coalesce・
`maxInFlightDecodes` の backpressure で頭打ちにし、decode 完了ごとに
`_decodeTile` の finally → `_refresh` → `_requestMissingDecodes` が次を開始する
drain ループにした。UI Isolate decode 禁止は `BaseMapTileDecoder`(`Isolate.run`)で
既に達成済み（Task 10-11 の判定参照）。
- **未対応（todo 830）**: cover 変更時の in-flight decode の明示 cancel。per-frame の
  再 selection で off-cover tile は再 issue されないため実害は限定的だが、走り始めた
  decode の結果が cache に入る点は残る（`Isolate.run` は中断不可）。
- widget test は追加しない（Global Constraints）。scheduler の decision は
  `map_tile_scheduler_test.dart` で単体 test 済みで、配線は tested な `selectNext`
  への薄い glue。

- [ ] **Step 1: Write failing integration contract tests**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Wire remaining seams; update README**
- [ ] **Step 4: Run** `(cd packages/eqmonitor_map && mise exec -- flutter test test/tile)` and `mise exec -- dart analyze packages/eqmonitor_map --fatal-infos`（**package ディレクトリから**実行する。repository root から呼ぶと fixture 解決 root がずれ、fixture 依存の tile/MVT test が誤って赤くなる。`docs/knowledge/20260814_cloud_agent_flutter_toolchain_bootstrap.md` 参照）
- [ ] **Step 5: Commit** `test: tile pipeline 本番契約の統合テストを追加`

---

### Task 16: Issue / knowledge ゲート

**Files:**
- Modify: Issue #1591 checkboxes via PR body
- Optional: `docs/knowledge/20260814_eqmonitor_map_tile_pipeline.md`（remote 契約の運用注意があれば）

- [ ] **Step 1: Confirm checklist** identity remote fixture + local verified + cancel/incarnation tests green
- [ ] **Step 2: Confirm no #1592/#1593/#1602 scope leaked**
- [ ] **Step 3: Push tip; ensure PR base remains `feat/eqmonitor-map-foundation`**
- [ ] **Step 4: Record shared Flutter gate failures as baseline（do not “fix” by weakening analyze）**
- [ ] **Step 5: Mark #1591 ready for review only after Tasks 1–15 green**

## Completion Checklist

- [ ] identity-encoded remote fixture + local verified source の contract test
- [ ] cancel / incarnation の unit test
- [ ] hazard fail-closed / basemap parent fallback がテストで分離
- [ ] budget/pin/eviction が設定モデル経由
- [ ] UI Isolate decode 経路が worker 経由のみ
- [ ] focused `eqmonitor_map` analyze/test green（共有 app gate は別 issue）

## References

- Design: `docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`
- Issue: #1591 / parent #1611
- Prior slice: `docs/superpowers/plans/2026-08-05-eqmonitor-map-base-layer-pmtiles.md`
- Foundation: `docs/superpowers/plans/2026-08-09-eqmonitor-map-foundation.md`
- Network reference (do not depend): `packages/seismicity_pmtiles` #1619
