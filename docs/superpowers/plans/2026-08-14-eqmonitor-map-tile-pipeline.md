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
- 共有 Flutter gate（devices primary constructor / freezed `final`）は develop baseline。本 PR の成功判定は `packages/eqmonitor_map`（と追加 fixture package）の focused analyze/test。
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

### Task 1: 現状契約の回帰ピン（ローカル verified + 欠損/破損）

**Files:**
- Test: `packages/eqmonitor_map/test/tile/verified_source_contract_test.dart`（新規）
- Modify: なし（RED なら既存境界のみ最小修正）

**Interfaces:**
- Consumes: `VerifiedPmTilesSource`, `BaseMapTileRepository`, MVT typed exceptions
- Produces: ローカル identity fixture が「欠損=null / 破損=typed」を固定する回帰

- [ ] **Step 1: Write the failing/pinning tests** for missing tile → `null`, corrupt bytes → typed exception, never empty geometry.
- [ ] **Step 2: Run** `mise exec -- dart test packages/eqmonitor_map/test/tile/verified_source_contract_test.dart`
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

- [ ] **Step 1: Write failing harness test**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement controlled server + fixture archive**
- [ ] **Step 4: Run GREEN**
- [ ] **Step 5: Commit** `test: identity remote Range fixture harness を追加`

---

### Task 8: Map remote random-access reader

**Files:**
- Create: `packages/eqmonitor_map/lib/src/tile/remote/map_remote_pm_tiles_reader.dart`
- Test: `packages/eqmonitor_map/test/tile/remote/map_remote_pm_tiles_reader_test.dart`

**Interfaces:**
- Consumes: Task 5–7 validators + `VerifiedRemotePmTilesSource`
- Produces: `Future<Uint8List> readAt({required int offset, required int length})` with LRU、in-flight coalesce、generation cancel、close/retire。No asset fallback.

- [ ] **Step 1: Write failing reader tests** (happy 206 path, 200-on-range reject, etag drift, cancel)
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement reader (Dio or http — follow existing map deps; do not add seismicity_pmtiles dep)**
- [ ] **Step 4: Run GREEN**
- [ ] **Step 5: Commit** `feat: map remote PMTiles Range reader を追加`

---

### Task 9: TileRepository を local/remote 両 descriptor 対応へ

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/tile/base_map_tile_repository.dart`
- Test: `packages/eqmonitor_map/test/tile/base_map_tile_repository_remote_test.dart`

**Interfaces:**
- Produces: same `Future<Uint8List?>` tile fetch surface; remote path uses Task 8 reader + `pmtiles_v3`

- [ ] **Step 1: Write failing remote fetch test via fixture**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Wire repository**
- [ ] **Step 4: Run GREEN + existing repository tests**
- [ ] **Step 5: Commit** `feat: TileRepository を remote verified source 対応`

---

### Task 10: packed worker payload 型（versioned flat buffer）

**Files:**
- Create: `packages/eqmonitor_map/lib/src/tile/worker/map_tile_worker_payload.dart`
- Test: `packages/eqmonitor_map/test/tile/worker/map_tile_worker_payload_test.dart`

**Interfaces:**
- Produces: versioned payload header + vertex/index/offset/string/error sections suitable for `TransferableTypedData`. No Freezed object graph of features in the hot path return.

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

- [ ] **Step 1: Write failing worker/cancel/incarnation tests**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement**
- [ ] **Step 4: Run GREEN**
- [ ] **Step 5: Commit** `feat: MVT decode worker と cancel 契約を追加`

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

- [ ] **Step 1: Write failing integration contract tests**
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Wire remaining seams; update README**
- [ ] **Step 4: Run** `mise exec -- dart test packages/eqmonitor_map/test/tile` and `mise exec -- dart analyze packages/eqmonitor_map --fatal-infos`
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
